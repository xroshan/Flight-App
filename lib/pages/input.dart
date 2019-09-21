import 'package:flutter/material.dart';
import 'package:flutter_course/models/airport.dart';
import 'package:flutter_course/scoped-models/main.dart';
import 'package:flutter_course/widgets/airport_card.dart';
import 'package:swipedetector/swipedetector.dart';

class InputPage extends StatefulWidget {
  final MainModel model;
  InputPage(this.model);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController editingController = TextEditingController();
  List<Airport> _filteredAirports = [];

  @override
  void initState() {
    widget.model.isLoading = true;
    widget.model.fetchAirportData().then((_) {
      setState(() {
        _filteredAirports.addAll(widget.model.allAirports);
        widget.model.isLoading = false;
      });
    });
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Airport> temp = [];
    temp.addAll(widget.model.allAirports);
    if (query.isNotEmpty) {
      List<Airport> temp2 = [];
      temp.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          temp2.add(item);
        }
      });
      setState(() {
        _filteredAirports.clear();
        _filteredAirports.addAll(temp2);
      });
      return;
    } else {
      setState(() {
        _filteredAirports.clear();
        _filteredAirports.addAll(widget.model.allAirports);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            controller: editingController,
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemCount: _filteredAirports.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (ctxt) {
                      return AiportCard(_filteredAirports[index]);
                    });
              },
              title: widget.model.isLoading
                  ? Text('loading')
                  : Text(_filteredAirports[index].name),
              subtitle: Text(_filteredAirports[index].airport),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_filteredAirports[index].pilotTrips != 0) {
                          _filteredAirports[index].pilotTrips--;
                          widget.model
                              .decreasePilotTrip(_filteredAirports[index].id);
                        }
                      });
                    },
                  ),
                  Text(
                    _filteredAirports[index].pilotTrips.toString(),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _filteredAirports[index].pilotTrips++;
                        widget.model
                            .increasePilotTrip(_filteredAirports[index].id);
                      });
                    },
                  ),
                ],
              ),
            );
          },
        )),
      ],
    );
  }
}
