import 'dart:convert';
import 'dart:io';

import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/core/navigator/navigator.dart';
import 'package:campus_transit/logic/vxmutations.dart';
import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/models/tickets_model.dart';
import 'package:campus_transit/ui/screens/tickets.dart';
import 'package:campus_transit/ui/widgets/common/common_button.dart';
import 'package:campus_transit/ui/widgets/common/common_scafold.dart';
import 'package:campus_transit/ui/widgets/containers/boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class TicketDetails extends StatefulWidget {
  final Ticket ticket;

  const TicketDetails(this.ticket, {Key key}) : super(key: key);

  @override
  State<TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  TransitStore _store;
  Ticket ticket;
  String ticketId;
  final paystackPlugin = PaystackPlugin();
  String backendUrl = "${DotEnv.env['BACKEND_URL']}";
  String paystackPublicKey = "${DotEnv.env['PAYSTACK_TEST_PUBLIC_KEY']}";
  String paystackSecret = "${DotEnv.env['PAYSTACK_TEST_SECRET']}";
  bool payStackDialogActivated = false;

  String emailAddress;
  double amountToTopUp = 25.0;
  String loanReference;
  int scheduleId;
  bool _isLocal = false;

  String _cardNumber;
  String _name;
  String _cvv;
  int _expiryMonth = 0;
  int _expiryYear = 0;

  @override
  void initState() {
    super.initState();
    paystackPlugin.initialize(publicKey: paystackPublicKey);
    ticket = widget.ticket;
    ticketId = '${ticket.busNumber}_${ticket.timestamp}';
  }

  @override
  Widget build(BuildContext context) {
    _store = (VxState.store as TransitStore);

    return CommonScaffold(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: [
          HeightDividerBox(24),
          Center(
            child: TicketCard(widget.ticket),
          ),
          HeightBox(40),
          _userDetails(),
          HeightBox(20),
          Spacer(),
          _qrCode(),
          HeightBox(20),
          _paystackButton(),
          HeightDividerBox(8),
        ],
      ),
    );
  }

  Widget _userDetails() {
    TransitStore _store;
    _store = (VxState.store as TransitStore);
    Size _size;
    _size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: _size.height / 8,
        width: 400,
        decoration: BoxDecoration(
          color: UIData.primaryColor.withOpacity(0.2),
        ),
        padding: EdgeInsets.only(left: 18, top: 5),
        margin: EdgeInsets.symmetric(horizontal: _size.width / 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${_store.user.name}'),
            Text('Sex: Male'),
            Text('Phone Number: ${_store.user.phoneNumber}'),
            Text('Email: ${_store.user.emailAddress}'),
          ],
        ),
      ),
    );
  }

  Widget _qrCode() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'TICKET QR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            HeightBox(6),
            //qrcode
            QrImage(
              data: ticketId,
              version: QrVersions.auto,
              size: 200,
              gapless: false,
              semanticsLabel: ticketId,
            )
          ],
        ),
      ),
    );
  }

  Widget _paystackButton() {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _size.width / 6),
      child: CommonButton(
        label: 'Pay For Transport',
        greenColor: true,
        onPressed: _onSelectPaystack,
      ),
    );
  }

  void _onSelectPaystack() async {
    TransitStore store = (VxState.store as TransitStore);
    if (payStackDialogActivated) return;
    _setPaystackLoading(true);
    emailAddress = store.user.emailAddress;
    amountToTopUp =
        widget.ticket.price; //store.selectedLoanRepayment.monthlyPayment;
    print('amount to top up $amountToTopUp');

    print('loan refrence is $loanReference');

    Charge charge = Charge()
      ..amount = (amountToTopUp * 100).toInt()
      ..email = emailAddress
      ..reference = _getReference()
      ..card = _getCardFromUI();

    try {
      CheckoutResponse response = await paystackPlugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
      );

      UpdateLoadingStatus(false);

      if (response.reference.isEmptyOrNull) {
        _setPaystackLoading(false);
        print('response is null');
        Fluttertoast.showToast(msg: 'response is null');
        return;
      }
      String status = await _verifyTransaction(response.reference);
      await Fluttertoast.showToast(
        msg: 'You have succesfully booked for a ticket',
      );

      TransitNavigator.navigateToHome(context);

      _setPaystackLoading(false);
    } catch (e) {
      print('error from paystack $e');
      _setPaystackLoading(false);
      if (e is InvalidEmailException) {
        Fluttertoast.showToast(
          msg: 'Invalid email.Correct your email and try again.',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    }
  }

  _setPaystackLoading(bool value) {
    payStackDialogActivated = value;
    UpdateLoadingStatus(value);
  }

  PaymentCard _getCardFromUI() {
    return PaymentCard(
      name: _name,
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }

  Future<String> _fetchAccessCodeFrmServer(String reference) async {
    String url = '$backendUrl/new-access-code'; //TODO HERE
    String accessCode;
    try {
      print("Access code url = $url");
      http.Response response = await http.get(Uri.parse(url));
      accessCode = response.body;
      print('Response for access code = $accessCode');
    } catch (e) {
      UpdateLoadingStatus(false);
    }

    return accessCode;
  }

  String _getReference() {
    TransitStore store = (VxState.store as TransitStore);
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return '${store.user.userId}_${DateTime.now().millisecondsSinceEpoch}';
    // return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<String> _verifyTransaction(String reference) async {
    String url = 'https://api.paystack.co/transaction/verify/$reference';
    String status;
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'BEARER $paystackSecret',
      });
      if (response.statusCode == 200) {
        status = json.decode(response.body)['data']['status'];
        print('status $status');
      }
      if (status == null) {
        status = 'failed';
      } else if (status == 'true') {
        status = 'success';
      }
    } catch (e) {
      UpdateLoadingStatus(false);
    }
    return status;
  }
}
