import 'package:campus_transit/core/constants.dart';
import 'package:campus_transit/logic/vxmutations.dart';
import 'package:campus_transit/logic/vxstore.dart';
import 'package:campus_transit/models/tickets_model.dart';
import 'package:campus_transit/ui/widgets/common/common_button.dart';
import 'package:campus_transit/ui/widgets/common/common_scafold.dart';
import 'package:campus_transit/ui/widgets/containers/boxes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'tickets.dart';

class SearchForBuses extends StatelessWidget {
  const SearchForBuses({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransitStore _store;
    _store = (VxState.store as TransitStore);
    return CommonScaffold(
      child: Column(
        children: [
          HeightDividerBox(30),
          Text('SEARCH FOR BUSES'),
          HeightDividerBox(30),
          Text('FROM:'),
          _fromDropdown(),
          HeightBox(30),
          _toDropdown(),
          HeightBox(30),
          Text('Select Date and Time'),
          CommonButton(label: 'Select Date'),
          HeightBox(30),
          CommonButton(
            label: 'Search',
            onPressed: () => _search(),
          ),
          HeightDividerBox(8),
        ],
      ),
    );
  }

  void _search() async {
    UpdateLoadingStatus(true);

    UpdateLoadingStatus(false);
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
    UpdateLoadingStatus(true);

    UpdateLoadingStatus(false);
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
