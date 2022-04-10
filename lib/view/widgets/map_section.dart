import 'dart:async';

import 'package:api_cubit/view/widgets/section_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSection extends StatefulWidget {
  final double? lat;
  final double? lon;

  const MapSection({Key? key, this.lat = 37.43296, this.lon = -122.08832})
      : super(key: key);
  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  Completer<GoogleMapController>? _controller;
  static CameraPosition? _kLake;
  static CameraPosition? _kGooglePlex;

  @override
  void initState() {
    super.initState();
    _controller = Completer();
    _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(widget.lat!, widget.lon!),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat!, widget.lon!),
      zoom: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 250,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionHeaderWidget(
              headerTitle: "Map",
              iconData: Icons.view_week_sharp,
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            SizedBox(
              height: 180,
              width: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex!,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller!.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
