import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/airport.dart';

class AiportCard extends StatelessWidget {
  final Airport airport;
  AiportCard(this.airport);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: Theme(
        data: ThemeData(accentColor: Colors.blueAccent),
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 90, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.local_airport,
                        size: 42, color: Color(0xff212f3d)),
                    title: Text(
                      airport.name + " (" + airport.airport + ")",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        "You've made " +
                            airport.pilotTrips.toString() +
                            " flights to this airport.",
                        style: TextStyle(
                          height: 2,
                        )),
                  ),
                ),
                Divider(),
                Text("Type: " + airport.airportType,
                    style: TextStyle(
                      height: 2,
                      color: Color(0xff454545),
                    )),
                Text(
                    "Location: (" +
                        airport.latitude.toStringAsPrecision(6) +
                        ", " +
                        airport.longitude.toStringAsPrecision(6) +
                        ")",
                    style: TextStyle(
                      height: 2,
                      color: Color(0xff454545),
                    )),
                Text(
                    "Number of Fixed-Based Operators: " +
                        airport.numberFbos.toString(),
                    style: TextStyle(
                      height: 2,
                      color: Color(0xff454545),
                    )),
                Text(
                    "Number of Restaurants Nearby: " +
                        airport.numberRestaurants.toString(),
                    style: TextStyle(
                      height: 2,
                      color: Color(0xff454545),
                    )),
                Text(
                    "Number of Hotels Nearby: " +
                        airport.numberHotels.toString(),
                    style: TextStyle(
                      height: 2,
                      color: Color(0xff454545),
                    )),
                Text(
                    "Number of Flying Schools Nearby: " +
                        airport.numberFlightSchools.toString(),
                    style: TextStyle(
                      height: 2,
                      color: Color(0xff454545),
                    )),
                Text(
                    "Number of Flying Clubs Nearby: " +
                        airport.numberFlyingClubs.toString(),
                    style: TextStyle(
                      height: 2,
                      color: Color(0xff454545),
                    )),
                Text(
                    "Number of Maintenance Companies: " +
                        airport.numberMaintenance.toString(),
                    style: TextStyle(
                      height: 2,
                      color: Color(0xff454545),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
