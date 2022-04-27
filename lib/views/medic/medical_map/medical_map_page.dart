import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/common/gps_models.dart';
import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/medic/medic_directory/medical_contact_page.dart';
import 'package:anthealth_mobile/views/theme/google_map_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MedicalMapPage extends StatefulWidget {
  const MedicalMapPage({Key? key}) : super(key: key);

  @override
  State<MedicalMapPage> createState() => _MedicalMapPageState();
}

class _MedicalMapPageState extends State<MedicalMapPage> {
  List<MedicalDirectoryData> list = [
    MedicalDirectoryData(
        "Bệnh viện Chợ Rẫy",
        "201B Nguyễn Chí Thanh, phường 12, quận 5, Thành phố Hồ Chí Minh, Việt Nam",
        "02838554137",
        "06:00–16:00",
        "",
        GPS(10.757899397875105, 106.65948982430974)),
    MedicalDirectoryData(
        "Bệnh viện Đại học Y dược TP.HCM",
        "215 Hồng Bàng, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam",
        "02838554269",
        "03:00–16:30",
        "",
        GPS(10.755429618832546, 106.66453507044434))
  ];
  Set<Marker> markers = {};

  @override
  void initState() {
    for (MedicalDirectoryData x in list)
      markers.add(Marker(
          markerId: MarkerId('gps'),
          infoWindow: InfoWindow(
              title: x.getName(),
              snippet: x.getLocation(),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MedicalContactPage(contact: x)))),
          position: LatLng(x.getGPS().lat, x.getGPS().long)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          margin: const EdgeInsets.only(top: 57), child: buildMap(context)),
      SafeArea(
          child: CustomAppBar(
              title: S.of(context).Medical_map, back: () => back(context)))
    ]));
  }

  Widget buildMap(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 57,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            padding: EdgeInsets.symmetric(horizontal: 16),
            markers: markers,
            initialCameraPosition: CameraPosition(
                target: LatLng(10.773374292292058, 106.66065148393713),
                zoom: 14),
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(GoogleMapStyle.mapStyle);
            }));
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
