import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/airport.dart';

mixin AllModel on Model {
  User _authenticatedUser;
  bool isLoading = false;
  List<Airport> _airports = [];
  FirebaseUser user;
}

mixin AirportModel on AllModel {
  List<Airport> get allAirports {
    return List.from(_airports);
  }

  Future<void> fetchAirportData() async {
    QuerySnapshot qsnap = await Firestore.instance
        .collection('airportData')
        .orderBy('id')
        .limit(20)
        .getDocuments();
    List qlist = qsnap.documents.toList();

    qlist.forEach((airportData) {
      final Airport airport = Airport(
        id: airportData['id'],
        airport: airportData['airport'],
        airportType: airportData['airport_type'],
        latitude: double.tryParse(airportData['latitude']) ?? 0.0,
        longitude: double.tryParse(airportData['longitude']) ?? 0.0,
        name: airportData['name'],
        numberFbos: int.tryParse(airportData['number_fbos']) ?? 0,
        numberFlightSchools:
            int.tryParse(airportData['number_flight_schools']) ?? 0,
        numberFlyingClubs:
            int.tryParse(airportData['number_flying_clubs']) ?? 0,
        numberHotels: int.tryParse(airportData['number_hotels']) ?? 0,
        numberMaintenance: int.tryParse(airportData['number_maintenance']) ?? 0,
        numberRestaurants: int.tryParse(airportData['number_restaurants']) ?? 0,
        pilotTrips: _authenticatedUser.tripInfo.length == 0
            ? 0
            : _authenticatedUser.tripInfo[airportData['id'] - 1],
      );
      _airports.add(airport);
    });
  }

  Future<void> updateTrip() async {
    _airports.forEach((ap) {
      if (_authenticatedUser.tripInfo.length < ap.id) {
        _authenticatedUser.tripInfo.add(ap.pilotTrips);
      } else {
        _authenticatedUser.tripInfo[ap.id - 1] = ap.pilotTrips;
      }
    });

    DocumentReference dref =
        Firestore.instance.collection('users').document(user.uid);
    final Map<String, dynamic> data = {
      'tripInfo': _authenticatedUser.tripInfo,
    };
    await dref.setData(data);
  }

  void increasePilotTrip(int id) {
    _airports[id - 1].pilotTrips++;
  }

  void decreasePilotTrip(int id) {
    _airports[id - 1].pilotTrips--;
  }
}

mixin UserModel on AllModel {
  PublishSubject<bool> _userSubject = PublishSubject();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User get auser {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  int totalTrips() {
    int res = 0;
    _authenticatedUser.tripInfo.forEach((trip) {
      res += trip;
    });
    return res;
  }

  Future<void> fetchTrip() async {
    DocumentReference dref =
        Firestore.instance.collection('users').document(user.uid);

    dref.get().then((doc) {
      if (doc.exists) {
        List<dynamic> temp = doc['tripInfo'];
        _authenticatedUser.tripInfo = temp.cast<int>().toList();
      }
    });
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    user = (await _auth.signInWithCredential(credential)).user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();

    assert(user.uid == currentUser.uid);

    _authenticatedUser = User(
      id: user.uid,
      email: user.email,
      name: user.displayName,
      token: 'dummy',
    );
    _userSubject.add(true);
    await fetchTrip();
    notifyListeners();
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    _authenticatedUser = null;
    _userSubject.add(false);
  }
}
