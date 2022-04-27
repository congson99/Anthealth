import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/theme/google_map_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MedicalContactMapPage extends StatefulWidget {
  const MedicalContactMapPage({Key? key, required this.contact})
      : super(key: key);

  final MedicalDirectoryData contact;

  @override
  State<MedicalContactMapPage> createState() => _MedicalContactMapPageState();
}

class _MedicalContactMapPageState extends State<MedicalContactMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          margin: const EdgeInsets.only(top: 57), child: buildMap(context)),
      SafeArea(
          child:
              CustomAppBar(title: S.of(context).Map, back: () => back(context)))
    ]));
  }

  Widget buildMap(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 57,
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
        child: GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            markers: {
              Marker(
                  markerId: MarkerId('gps'),
                  infoWindow: InfoWindow(
                      title: widget.contact.getName(),
                      snippet: widget.contact.getLocation()),
                  position: LatLng(widget.contact.getGPS().lat,
                      widget.contact.getGPS().long))
            },
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    widget.contact.getGPS().lat, widget.contact.getGPS().long),
                zoom: 16),
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(GoogleMapStyle.mapStyle);
            }));
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
