import 'dart:convert';
import 'dart:io';

import 'package:campus_transit/core/navigator/navigator.dart';
import 'package:campus_transit/logic/vxmutations.dart';
import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/models/tickets_model.dart';
import 'package:campus_transit/ui/widgets/common/common_button.dart';
import 'package:campus_transit/ui/widgets/common/common_scafold.dart';
import 'package:campus_transit/ui/widgets/containers/boxes.dart';
import 'package:campus_transit/ui/widgets/display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransitStore _store;
    _store = (VxState.store as TransitStore);
    return CommonScaffold(
      child: Column(
        children: [
          HeightBox(30),
          Text('BOOKED TICKETS'),
          Expanded(
            child: ListView.builder(
              itemCount: _store.user.tickets.length,
              itemBuilder: (BuildContext context, int index) {
                return TicketCard(_store.user.tickets[index]);
              },
            ),
          ),
          // Row(
          //   children: [
          //     Icon(Icons.add),
          //     Text('Book a ticket'),
          //   ],
          // ),
          HeightDividerBox(8),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final bool canbook;
  const TicketCard(this.ticket, {Key key, this.canbook = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (canbook) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return BookParticularTicketScreen(ticket);
          }));
        }
      },
      child: Container(
        height: 120,
        width: 300,
        decoration: BoxDecoration(
          color: Color(0xff7EA7B7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${ticket.name}'),
            Divider(height: 2),
            Text('BUS NO: ${ticket.busNumber}'),
            DisplayWidget(
              displayWidget: ticket.WithAcAndCurtains,
              child: Text('WITH AC & CURTAINS'),
            ),
            // Text('DATE: $/.}'),
            Text('6am - 10pm'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var busstop in ticket.bustops) Text('$busstop '),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String timestampToDate(int timestamp) {}

class BookParticularTicketScreen extends StatefulWidget {
  final Ticket ticket;
  const BookParticularTicketScreen(this.ticket, {Key key}) : super(key: key);

  @override
  State<BookParticularTicketScreen> createState() =>
      _BookParticularTicketScreenState();
}

class _BookParticularTicketScreenState
    extends State<BookParticularTicketScreen> {
  final paystackPlugin = PaystackPlugin();
  String backendUrl = "${DotEnv.env['BACKEND_URL']}";
  String paystackPublicKey = "${DotEnv.env['PAYSTACK_PUBLIC_KEY']}";
  String paystackSecret = "${DotEnv.env['PAYSTACK_SECRET']}";
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
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: Column(
        children: [
          HeightDividerBox(8),
          TicketCard(widget.ticket),
          Spacer(),
          CommonButton(
            label: 'BOOK',
            onPressed: () {
              _onSelectPaystack();
            },
          ),
          HeightDividerBox(8),
        ],
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
