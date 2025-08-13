import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fastdelivery/Pharmacie/item.dart';
import 'package:fastdelivery/generated/l10n.dart';
import 'package:fastdelivery/main.dart';
import 'package:fastdelivery/pages/LanguageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

class maps extends StatefulWidget {
  final String name;
  final String numeroTel;
  final double lat;
  final double long;
  const maps(
      {super.key,
      required this.name,
      required this.numeroTel,
      required this.lat,
      required this.long});

  @override
  State<maps> createState() => _mapsState();
}

class _mapsState extends State<maps> {
  double? lat;
  GoogleMapController? controller;
  CameraPosition cameraPosition =
      CameraPosition(target: LatLng(18.0490793, -15.9597956), zoom: 15);
  Map<PolylineId, Polyline> polylines = {};
  StreamSubscription<Position>? positionStream;
  List<Marker> markers = [
    // Marker(markerId: MarkerId('4'), position: _position, icon: BitmapDescriptor.defaultMarker),
    //Marker(markerId: MarkerId('4'), position: _position, icon: BitmapDescriptor.defaultMarker),
  ];
  Future<BitmapDescriptor> _createMarkerIcon() async {
    return await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      'Assets2/pharmacy.png',
    );
  }

  Color color = Colors.grey;
  void addMarkers() async {
    final markerIcon = await _createMarkerIcon();
    final latitude =
        Provider.of<languageProvider>(context, listen: false).latitude;
    final longitude =
        Provider.of<languageProvider>(context, listen: false).longitude;
    final marker = Marker(
        markerId: MarkerId('current'), position: LatLng(latitude, longitude));
    final marker2 = Marker(
        markerId: MarkerId('1'),
        position: LatLng(widget.lat, widget.long),
        icon: markerIcon);
    // controller!.animateCamera( CameraUpdate.newLatLng(LatLng(latitude, longitude)), );
    setState(() {
      markers.add(marker);
      markers.add(marker2);
    });
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = dotenv.env['API_KEY'] ?? "cle non trouvee";

  void vibrateOnPageLoad() async {
    await Future.delayed(Duration(seconds: 1));
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 600);
    }
  }

  bool ouverture() {
    return DateTime.now().hour >= 23 || DateTime.now().hour <= 6;
  }

  void initState() {
    super.initState();
    //  getCurrentPosition();
    vibrateOnPageLoad();
    getPolyline();
    addMarkers();
  }

  @override
  void dispose() {
    positionStream!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              isArabic() ? " صيد " : "Ma",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              isArabic() ? "لياتي" : "Pharmacie",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 11),
            child: Image.network(
              "https://e7.pngegg.com/pngimages/155/90/png-clipart-green-and-white-snake-and-chalice-icon-faculty-of-pharmacy-silpakorn-university-pharmacist-pharmaceutical-drug-naplex-pharmacy-text-logo-thumbnail.png",
              width: 23,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 600,
            child: GoogleMap(
              onTap: (LatLng latLng) async {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    latLng.latitude, latLng.longitude);
                print(placemarks[0].country);
                print(placemarks[0].locality);
                print(placemarks[0].street);
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: '${placemarks[0].country}',
                  desc: '${placemarks[0].street}',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                )..show();
              },
              mapType: MapType.normal,
              initialCameraPosition: cameraPosition,
              onMapCreated: (mycontroller) {
                mycontroller.animateCamera(
                  CameraUpdate.newLatLng(LatLng(
                      Provider.of<languageProvider>(context, listen: false)
                          .latitude,
                      Provider.of<languageProvider>(context, listen: false)
                          .longitude)),
                );
                ;
              },
              markers: markers.toSet(),
              polylines: Set<Polyline>.of(polylines.values),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      color: ouverture() ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        ouverture()
                            ? S.of(context).title27
                            : S.of(context).title28,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.numeroTel,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          // await FlutterPhoneDirectCaller.callNumber('+22222484022');
                          makePhoneCall(widget.numeroTel);
                        },
                        icon: Icon(
                          Icons.phone,
                          size: 27,
                        ))
                  ],
                ),
                Consumer<languageProvider>(builder: (context, item5, child) {
                  return IconButton(
                      onPressed: () {
                        color = Colors.green;
                        item5.addItem(item(
                            title: widget.name,
                            numero: widget.numeroTel,
                            distance: 0.0,
                            lat: 0.0,
                            long: 0.0));
                        SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                                "Vous avez ajouté ${widget.name} à votre liste de favoris"));

                        //    item.addMonList(widget.name, widget.numeroTel);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: color,
                      ));
                })

                /*  Padding(
                padding: const EdgeInsets.only(right: 23),
                child: Container(
                  
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: IconButton(onPressed: (){
                      showModalBottomSheet(context: context, builder: (context)=>Container(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Text("Les informations sur tous les pharmacies", style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold
                                 ),),

                                 Text("${widget.lat} ET ${widget.long}")
                            ],
                          ),
                        ),
                      ));
                           }, icon:Icon(Icons.add, color: Colors.white, size: 30,)),
                  ),
                ),
              )*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.green, points: polylineCoordinates);

    setState(() {
      polylines[id] = polyline;
    });
  }

  getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleAPiKey,
      request: PolylineRequest(
        origin: PointLatLng(widget.lat, widget.long),
        destination: PointLatLng(
            Provider.of<languageProvider>(context, listen: false).latitude,
            Provider.of<languageProvider>(context, listen: false).longitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
    print(Provider.of<languageProvider>(context, listen: false).latitude);
    print(Provider.of<languageProvider>(context, listen: false).longitude);
  }
}
