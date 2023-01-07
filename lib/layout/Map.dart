import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' hide MapType;



class Map_screen extends StatefulWidget{
  const Map_screen({super.key, this.lat, this.lng});

  @override
  _Map_screenState createState() => _Map_screenState(lat,lng);
  final lat ;
  final lng ;
}

class _Map_screenState extends State<Map_screen> {
final lat ;
final lng ;
_Map_screenState(this.lat, this.lng);

  GoogleMapController? mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    markers.add(Marker( //add marker on google map
      markerId: MarkerId(LatLng( double.parse(lat), double.parse(lng)).toString()),
      position: LatLng( double.parse(lat), double.parse(lng)),
      infoWindow: const InfoWindow(
        // title: 'موقع ',
        // snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(leading: IconButton( onPressed: (){
        Navigator.pop(context);
      },icon:  Icon(Icons.arrow_back_ios, color: Theme
          .of(context)
          .brightness == Brightness.dark ? Colors.white : Colors.black)),title: Text("الموقع"), elevation: 0),

      // appBar: AppBar(
      //   title: const Text("Google Map in Flutter"),
      //   backgroundColor: Colors.deepPurpleAccent,
      //   actions: [
      //     IconButton(onPressed: () async {
      //       final availableMaps = await MapLauncher.installedMaps;
      //       print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]
      //
      //       await availableMaps.first.showMarker(
      //        // coords: Coords(37.759392, -122.5107336),
      //         coords: Coords( double.parse(lat), double.parse(lng)),
      //         title: "Ocean Beach",
      //       );
      //
      //     }, icon: const Icon(Icons.map))
      //   ],
      // ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng( double.parse(lat), double.parse(lng)),
          zoom: 10.0,
        ),
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}