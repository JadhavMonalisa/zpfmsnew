import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:zpfmsnew/theme/app_text_theme.dart';

class PhotoUploadScreen extends StatefulWidget {
  final String partyId;
  final String workId;
  final String billId;
  PhotoUploadScreen({Key? key,required this.partyId,required this.workId,required this.billId}) : super(key: key);

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  String language = "";
  String username = "";
  String token = "";
  int statusCode = 200;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    reload();
    _getCurrentPosition();
    super.initState();
  }

  reload() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      language = localStorage.getString('language')!;
    });
  }

  File? imageFile;
  final picker = ImagePicker();
  bool isSelected = false;
  _pickImageFromCamera() async {
    try{
      final pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
      imageFile = pickedImage != null ? File(pickedImage.path) : null;
      if (imageFile != null) {
        setState(() {
          imageFile = imageFile;
          isSelected = true;
        });
      }
    }
    catch (error) {
      setState(() {
        isSelected = false;
      });
    }
  }

  String? gender;
  int radioValue = -1;

  handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  // Location
  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future callPhotoUpload() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    username = localStorage.getString('username')!;
    token = localStorage.getString('token')!;
    Map<String, String> headers = {
      "Authorization": 'Bearer $token',
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://api.demofms.com/api/UploadedPhoto/SetUploadedPhotoDetails'),
    );
    request.headers.addAll(headers);
    request.fields['BillID'] = widget.billId;
    request.fields['Longitude'] = _currentPosition!.longitude.toString();
    request.fields['Latitude'] = _currentPosition!.latitude.toString();
    request.fields['Location'] = _currentAddress.toString();

    request.files.add(await http.MultipartFile.fromPath('Image', imageFile!.path));

    var res = await request.send();
    statusCode = res.statusCode;

    final responsebody = await res.stream.bytesToString();
    Map jsonBody = json.decode(responsebody);


    if(jsonBody["status"]==200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonBody["result"])),
      );
      setState(() {
        imageFile==null;isSelected=false;isLoading=false;
      });
    }
    else if(jsonBody["status"]==403){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong.Please try again later!")),
      );
      setState(() {
        imageFile==null;isSelected=false;isLoading=false;
      });
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
      isLoading=false;
    }

    setState(() {
      imageFile==null;isSelected=false;isLoading=false;
    });

    return res.reasonPhrase;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          color: const Color.fromARGB(246, 214, 105, 17),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: language == "English"
            ? const Text(
          "Photo Upload",
          style: TextStyle(
              color: Color.fromARGB(246, 214, 105, 17),
              fontWeight: FontWeight.bold),
        )
            : const Text(
          "फोटो अपलोड",
          style: TextStyle(
              color: Color.fromARGB(246, 214, 105, 17),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // actions: [],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0,),
                Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.fill,
                  height: 70,
                  width: 70,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                        height: 40.0,width: 150.0,
                        color: Colors.red,
                        child: Center(
                          child: buildTextBoldWidget(language == "English" ? "Photo Upload" : "फोटो अपलोड",
                              Colors.white, context, 16.0,align: TextAlign.center),
                        )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20.0),
                //   child: Table(
                //     columnWidths: const {
                //       0: FlexColumnWidth(3),
                //       1: FlexColumnWidth(1),
                //       2: FlexColumnWidth(6),
                //     },
                //     children: [
                //       buildTableRow(context, "LATITUDE", "${_currentPosition?.latitude ?? ""}"),
                //       buildSpaceTableRow(),
                //       buildTableRow(context, "LONGITUDE", "${_currentPosition?.longitude ?? ""}"),
                //       buildSpaceTableRow(),
                //       buildTableRow(context, "ADDRESS", "${_currentAddress ?? ""}"),
                //       buildSpaceTableRow(),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 20.0,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Radio(
                          activeColor: Colors.red,
                          value: 0,
                          groupValue: radioValue,
                          onChanged: (val){handleRadioValueChanged(val!);}),
                    ),
                    buildTextBoldWidget("Before", Colors.black, context, 16.0,fontWeight: FontWeight.normal),
                    Flexible(
                      child: Radio<int>(
                          activeColor: Colors.red,
                          value: 1,
                          groupValue: radioValue,
                          onChanged: (val){handleRadioValueChanged(val!);}),
                    ),
                    buildTextBoldWidget("After", Colors.black, context, 16.0,fontWeight: FontWeight.normal),
                  ],
                ),

                isSelected == false
                    ? Container(
                  height: 250,
                  width: 250,
                  color: Colors.white,
                  child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.upload,
                          color: Colors.orange,
                          size: 40,
                        ),
                        onPressed: () {
                          _pickImageFromCamera();
                        },
                      )),
                )
                    : SizedBox(
                  height: 250,
                  width: 250,
                  child: Stack(
                    children: [
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          image: DecorationImage(
                              image: FileImage(imageFile!),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isSelected = false;
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.green,
                          backgroundColor: Colors.deepOrange,
                          minimumSize: const Size(90, 40),
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if(imageFile==null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please add photo')),
                              );
                            }
                            else if(radioValue==-1){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please select before or after')),
                              );
                            }
                            else{
                              isLoading = true;
                              callPhotoUpload();
                            }
                          });
                        },
                        child: const Text(
                          'Capture',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Flexible(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.green, backgroundColor: Colors.orange,
                          minimumSize: const Size(90, 40),
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
