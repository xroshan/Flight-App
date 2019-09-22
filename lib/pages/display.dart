import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../scoped-models/main.dart';
import '../widgets/airport_card.dart';

class DisplayPage extends StatefulWidget {
  final MainModel model;

  DisplayPage(this.model);

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  GoogleMapController mapController;
  Map<String, Marker> markers = {};
  int index = 0;

  @override
  void initState() {
    index = index % widget.model.auser.recommendedAirports.length;
    widget.model.auser.recommendedAirports.forEach((recmd) {
      markers[recmd.toString()] = Marker(
          markerId: MarkerId(recmd.toString()),
          position: LatLng(widget.model.allAirports[recmd - 1].latitude,
              widget.model.allAirports[recmd - 1].longitude),
          infoWindow: InfoWindow(
            title: widget.model.allAirports[recmd - 1].name,
            snippet: widget.model.allAirports[recmd - 1].airport,
          ),
          onTap: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (ctxt) {
                  return AiportCard(widget.model.allAirports[recmd - 1]);
                });
          });
    });
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                widget
                    .model
                    .allAirports[
                        widget.model.auser.recommendedAirports[index] - 1]
                    .latitude,
                widget
                    .model
                    .allAirports[
                        widget.model.auser.recommendedAirports[index] - 1]
                    .longitude),
            zoom: 12.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
            zoom: 12.0,
          ),
          markers: markers.values.toSet(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Color(0xff212f3d),
                    child: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      index = (index - 1) %
                          widget.model.auser.recommendedAirports.length;
                      mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(
                                  widget
                                      .model
                                      .allAirports[widget.model.auser
                                              .recommendedAirports[index] -
                                          1]
                                      .latitude,
                                  widget
                                      .model
                                      .allAirports[widget.model.auser
                                              .recommendedAirports[index] -
                                          1]
                                      .longitude),
                              zoom: 12.0),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  FloatingActionButton(
                    backgroundColor: Color(0xff212f3d),
                    child: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      index = (index + 1) %
                          widget.model.auser.recommendedAirports.length;

                      mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(
                                  widget
                                      .model
                                      .allAirports[widget.model.auser
                                              .recommendedAirports[index] -
                                          1]
                                      .latitude,
                                  widget
                                      .model
                                      .allAirports[widget.model.auser
                                              .recommendedAirports[index] -
                                          1]
                                      .longitude),
                              zoom: 12.0),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
