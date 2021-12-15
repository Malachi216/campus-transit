import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/logic/vxmutations.dart';
import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/models/tickets_model.dart';
import 'package:campus_transit/ui/screens/ticket_details.dart';
import 'package:campus_transit/ui/widgets/common/common_button.dart';
import 'package:campus_transit/ui/widgets/common/common_scafold.dart';
import 'package:campus_transit/ui/widgets/containers/boxes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import 'tickets.dart';

Size _size;
TransitStore _store;
BuildContext _context;

class SearchForBuses extends StatelessWidget {
  const SearchForBuses({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _context = context;

    _store = (VxState.store as TransitStore);
    return CommonScaffold(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          HeightDividerBox(30),
          Center(
            child: Text(
              'SEARCH FOR BUSES',
              style: UIData.campusStyle,
            ),
          ),
          HeightDividerBox(30),
          Align(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              'From:',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _fromDropdown(),
          HeightBox(30),
          Align(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              'To:',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _toDropdown(),
          HeightBox(30),
          Align(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              'Select Date and Time',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          HeightBox(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _size.width / 5),
            child: CommonButton(
              label: 'Select Date',
              greenColor: true,
              onPressed: () => _showDatePicker(context),
            ),
          ),
          HeightBox(10),
          _showDateWidget(),
          HeightBox(30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _size.width / 5),
            child: CommonButton(
              label: 'Search',
              onPressed: () => _search(),
              greenColor: true,
            ),
          ),
          HeightDividerBox(8),
        ],
      ),
    );
  }
    void _search() async {
    await Fluttertoast.showToast(msg: 'Fetching travels...');
    UpdateLoadingStatus(true);
    await Future.delayed(const Duration(milliseconds: 4000));
    UpdateLoadingStatus(false);
    Fluttertoast.showToast(msg: 'Travels fetched succesfully...');
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TicketDetails(
            Ticket(
              name:
                  '${_store.selectedFromBustop.substring(0, 2)}_${_store.selectedToBustop.substring(0, 2)}',
              busNumber: 'BUS_4637HG',
              WithAcAndCurtains: true,
              timestamp: _store.selectedTransitTime.millisecondsSinceEpoch,
              bustops: [_store.selectedFromBustop, _store.selectedToBustop],
              price: 100,
            ),
          );
        },
      ),
    );
  }

  Widget _showDateWidget() {
    return VxBuilder<TransitStore>(
      mutations: {SelectTransitTime},
      builder: (BuildContext context, TransitStore store, VxStatus status) {
        var d12 = DateFormat('MM/dd/yyyy, HH:mm:ss a')
            .format(store.selectedTransitTime);

        return Align(
          alignment: Alignment(-0.8, 0.0),
          child: Container(
              child: Text(
            'Selected Date and Time: $d12',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )),
        );
      },
    );
  }


  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: _size.height / 2.0,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: _size.height / 3.0,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime chosenTime) {
                  SelectTransitTime(chosenTime);
                },
              ),
            ),
            CupertinoButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  Widget _fromDropdown() {
    return VxBuilder(
      mutations: {SelectFromBustop, SelectToBustop},
      builder: (BuildContext context, TransitStore store, VxStatus status) {
        TransitStore store = (VxState.store as TransitStore);
        List<String> bustops = store.Bustops;
        return Padding(
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 32.0, left: 32.0, right: 32.0),
          child: DropdownButtonHideUnderline(
            child: InputDecorator(
              decoration:
                  UIData.dropdownDecoration.copyWith(hintText: 'Select bustop'),
              isEmpty: store.selectedFromBustop == null,
              child: DropdownButton<String>(
                value: store.selectedFromBustop,
                isDense: true,
                isExpanded: true,
                onChanged: (String bustop) => SelectFromBustop(bustop),
                items: bustops.map((String bustop) {
                  return DropdownMenuItem<String>(
                    value: bustop,
                    child: Text(
                      bustop,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _toDropdown() {
    return VxBuilder(
      mutations: {SelectFromBustop, SelectToBustop},
      builder: (BuildContext context, TransitStore store, VxStatus status) {
        TransitStore store = (VxState.store as TransitStore);
        List<String> bustops = store.Bustops;
        return Padding(
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 32.0, left: 32.0, right: 32.0),
          child: DropdownButtonHideUnderline(
            child: InputDecorator(
              decoration:
                  UIData.dropdownDecoration.copyWith(hintText: 'Select bustop'),
              isEmpty: store.selectedToBustop == null,
              child: DropdownButton<String>(
                value: store.selectedToBustop,
                isDense: true,
                isExpanded: true,
                onChanged: (String bustop) => SelectToBustop(bustop),
                items: bustops.map((String bustop) {
                  return DropdownMenuItem<String>(
                    value: bustop,
                    child: Text(
                      bustop,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SelectDesiredBusScreen extends StatelessWidget {
  const SelectDesiredBusScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransitStore _store;
    _store = (VxState.store as TransitStore);
    List<Ticket> results = _store.searchTransitResults;
    return CommonScaffold(
      child: Column(
        children: [
          HeightDividerBox(30),
          Text('SELECT DESIRED BUS'),
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (BuildContext context, int index) {
                  return TicketCard(results[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _search() async {
    await Fluttertoast.showToast(msg: 'Fetching travels...');
    UpdateLoadingStatus(true);
    await Future.delayed(const Duration(milliseconds: 4000));
    UpdateLoadingStatus(false);
    Fluttertoast.showToast(msg: 'Travels fetched succesfully...');
    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TicketDetails(
            Ticket(
              name:
                  '${_store.selectedFromBustop.substring(0, 2)}_${_store.selectedToBustop.substring(0, 2)}',
              busNumber: 'BUS_4637HG',
              WithAcAndCurtains: true,
              timestamp: _store.selectedTransitTime.millisecondsSinceEpoch,
              bustops: [_store.selectedFromBustop, _store.selectedToBustop],
            ),
          );
        },
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    Size _size;
    _size = MediaQuery.of(context).size;
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: _size.height / 2.0,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: _size.height / 3.0,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime chosenTime) {
                  SelectTransitTime(chosenTime);
                },
              ),
            ),
            CupertinoButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  Widget _fromDropdown() {
    return VxBuilder(
      mutations: {SelectFromBustop, SelectToBustop},
      builder: (BuildContext context, TransitStore store, VxStatus status) {
        TransitStore store = (VxState.store as TransitStore);
        List<String> bustops = store.Bustops;
        return Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
          child: DropdownButtonHideUnderline(
            child: InputDecorator(
              decoration:
                  UIData.dropdownDecoration.copyWith(hintText: 'Select bustop'),
              isEmpty: store.selectedFromBustop == null,
              child: DropdownButton<String>(
                value: store.selectedFromBustop,
                isDense: true,
                isExpanded: true,
                onChanged: (String bustop) => SelectFromBustop(bustop),
                items: bustops.map((String bustop) {
                  return DropdownMenuItem<String>(
                    value: bustop,
                    child: Text(
                      bustop,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _toDropdown() {
    return VxBuilder(
      mutations: {SelectFromBustop, SelectToBustop},
      builder: (BuildContext context, TransitStore store, VxStatus status) {
        TransitStore store = (VxState.store as TransitStore);
        List<String> bustops = store.Bustops;
        return Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
          child: DropdownButtonHideUnderline(
            child: InputDecorator(
              decoration:
                  UIData.dropdownDecoration.copyWith(hintText: 'Select bustop'),
              isEmpty: store.selectedToBustop == null,
              child: DropdownButton<String>(
                value: store.selectedToBustop,
                isDense: true,
                isExpanded: true,
                onChanged: (String bustop) => SelectToBustop(bustop),
                items: bustops.map((String bustop) {
                  return DropdownMenuItem<String>(
                    value: bustop,
                    child: Text(
                      bustop,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
