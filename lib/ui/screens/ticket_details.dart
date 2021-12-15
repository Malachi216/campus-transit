import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/models/tickets_model.dart';
import 'package:campus_transit/ui/screens/tickets.dart';
import 'package:campus_transit/ui/widgets/common/common_scafold.dart';
import 'package:campus_transit/ui/widgets/containers/boxes.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

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

  @override
  void initState() {
    super.initState();
    ticket = widget.ticket;
    ticketId = '${ticket.busNumber}_${ticket.timestamp}';
  }

  @override
  Widget build(BuildContext context) {
    _store = (VxState.store as TransitStore);

    return CommonScaffold(
      child: Column(
        children: [
          HeightDividerBox(8),
          TicketCard(widget.ticket),
          HeightDividerBox(16),
          _userDetails(),
          HeightBox(20),
          Spacer(),
          _qrCode(),
          HeightDividerBox(8),
        ],
      ),
    );
  }

  Widget _userDetails() {
    return Container(
      height: 300,
      child: Column(
        children: [
          Text('Name: Aduke'),
          Text('data'),
          Text('data'),
        ],
      ),
    );
  }

  Widget _qrCode() {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('TICKET QR'),
          HeightBox(6),
          //qrcode
          QrImage(
            data: ticketId,
            version: QrVersions.auto,
            size: 320,
            gapless: false,
            semanticsLabel: ticketId,
          )
        ],
      ),
    );
  }
}
