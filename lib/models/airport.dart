import 'package:flutter/foundation.dart';

class Airport {
  final int id;
  final String airport;
  final String airportType;
  final double latitude;
  final double longitude;
  final String name;
  final int numberFbos;
  final int numberFlightSchools;
  final int numberFlyingClubs;
  final int numberHotels;
  final int numberMaintenance;
  final int numberRestaurants;
  int pilotTrips;

  Airport({
    @required this.id,
    @required this.airport,
    @required this.airportType,
    @required this.latitude,
    @required this.longitude,
    @required this.name,
    @required this.numberFbos,
    @required this.numberFlightSchools,
    @required this.numberFlyingClubs,
    @required this.numberHotels,
    @required this.numberMaintenance,
    @required this.numberRestaurants,
    this.pilotTrips = 0,
  });
}
