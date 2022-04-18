import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';
import 'package:anthealth_mobile/views/common_pages/template_form_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:anthealth_mobile/views/theme/google_map_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MedicalContactPage extends StatelessWidget {
  const MedicalContactPage({Key? key, required this.contact}) : super(key: key);

  final MedicalDirectoryData contact;

  @override
  Widget build(BuildContext context) {
    return TemplateFormPage(
        title: S.of(context).Hospital_info,
        back: () => back(context),
        edit: () {},
        content: buildContent(context));
  }

  // Content
  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildInfoComponent(context, S.of(context).Name, contact.getName()),
      CustomDivider.common(),
      SizedBox(height: 16),
      buildInfoComponent(
          context, S.of(context).Phone_number, contact.getPhoneNumber()),
      CustomDivider.common(),
      SizedBox(height: 16),
      buildInfoComponent(context, S.of(context).Working_time, contact.getWorkTime()),
      CustomDivider.common(),
      SizedBox(height: 16),
      buildInfoComponent(context, S.of(context).Address, contact.getLocation()),
      SizedBox(height: 8),
      if (contact.getGPS().lat != 0 && contact.getGPS().long != 0)
        buildMap(context)
    ]);
  }

  Column buildInfoComponent(
      BuildContext context, String title, String content) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: AnthealthColors.black2)),
      SizedBox(height: 8),
      Text(content, style: Theme.of(context).textTheme.subtitle1),
      SizedBox(height: 16)
    ]);
  }

  Container buildMap(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
            border: Border.all(color: AnthealthColors.black3, width: 1),
            borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                markers: {
                  Marker(
                      markerId: MarkerId('gps'),
                      infoWindow: InfoWindow(
                          title: contact.getName(),
                          snippet: contact.getLocation()),
                      position:
                          LatLng(contact.getGPS().lat, contact.getGPS().long))
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(contact.getGPS().lat, contact.getGPS().long),
                    zoom: 16),
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle(GoogleMapStyle.mapStyle);
                })));
  }

  // Actions
  void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
