import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_appbar.dart';
import 'package:anthealth_mobile/views/medic/medical_directory/medical_contact_page.dart';
import 'package:anthealth_mobile/views/theme/google_map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MedicalMapPage extends StatefulWidget {
  const MedicalMapPage({Key? key, required this.dashboardContext})
      : super(key: key);

  final BuildContext dashboardContext;

  @override
  State<MedicalMapPage> createState() => _MedicalMapPageState();
}

class _MedicalMapPageState extends State<MedicalMapPage> {
  List<MedicalDirectoryData> list = [];
  Set<Marker> markers = {};

  @override
  void initState() {
    BlocProvider.of<DashboardCubit>(widget.dashboardContext)
        .getMedicalContacts()
        .then((value) => setState(() {
              list = value;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (MedicalDirectoryData x in list) {
      markers.add(Marker(
          markerId: MarkerId(list.indexOf(x).toString()),
          infoWindow: InfoWindow(
              title: x.getName(),
              snippet: x.getLocation(),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MedicalContactPage(contact: x)))),
          position: LatLng(x.getGPS().lat, x.getGPS().long)));
    }
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
                zoom: 13),
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(GoogleMapStyle.mapStyle);
            }));
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
