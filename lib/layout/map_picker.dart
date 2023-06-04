import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
MapController controller = MapController(
  initMapWithUserPosition: false,
  initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
  areaLimit: BoundingBox(
    east: 10.4922941,
    north: 47.8084648,
    south: 45.817995,
    west:  5.9559113,
  ),
);class map_picker extends StatelessWidget {
  const map_picker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// To Start assisted Selection

    /// To get location desired
    //controller.getCurrentPositionAdvancedPositionPicker().then((value) => print(value));
    /// To get location desired and close picker

    /// To cancel assisted Selection
   // controller.geopoints.then((value) => print(value));
   return StatefulBuilder(
     builder: (context,setstate) {
       controller.advancedPositionPicker().then((value) {});
       // controller.selectAdvancedPositionPicker().then((value) {
       //   print(value);
       //
       // });
       return OSMFlutter(controller:controller,isPicker: true,);
     }
   );
  }

}
