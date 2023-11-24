import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:zxplore_app/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';

class UploadUtilityBillStep extends StatefulWidget {
  @override
  _UploadUtilityBillState createState() => _UploadUtilityBillState();
}

class _UploadUtilityBillState extends State<UploadUtilityBillStep>
    with AutomaticKeepAliveClientMixin<UploadUtilityBillStep> {
  XFile? _imageFile;
  String? retrieveDataError;
  dynamic pickImageError;
  AccountFormBloc? accountFormBloc;
  ByteData _img = ByteData(0);
  ImagePicker _picker = ImagePicker();

  // Resident permit
  XFile? _imageFile2;
  String? retrieveDataError2;
  dynamic pickImageError2;
  ByteData _img2 = ByteData(0);
  ImagePicker _picker2 = ImagePicker();

  @override
  void initState() {
    super.initState();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    accountFormBloc!.uploadUtilityBillController.listen((base64Signature) {
      if (_img.lengthInBytes == 0) {
        var imageData = base64Decode(base64Signature!);

        setState(() {
          _img = imageData.buffer.asByteData();
        });
      }
    });

    // Resident Permit
    accountFormBloc!.uploadResidentPermitController.listen((base64Signature) {
      if (_img2.lengthInBytes == 0) {
        var imageData = base64Decode(base64Signature!);

        setState(() {
          _img2 = imageData.buffer.asByteData();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Platform.isAndroid
                  ? FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Text(
                              'Click either the gallery or camera icon to upload a picture of your utility Bill',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return (_img.buffer.lengthInBytes == 0
                                ? const Text(
                                    'Click either the gallery or camera icon to upload a picture of your utility Bill',
                                    textAlign: TextAlign.center,
                                  )
                                : LimitedBox(
                                    maxHeight: 600.0,
                                    child: Image.memory(
                                        _img.buffer.asUint8List())));
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              const Text(
                                'Click either the gallery or camera icon to upload a picture of your utility Bill',
                                textAlign: TextAlign.center,
                              );
                            }
                        }
                        return Text(
                          'Click either the gallery or camera icon to upload a picture of your utility Bill',
                          textAlign: TextAlign.center,
                        );
                      },
                    )
                  : (_img.buffer.lengthInBytes == 0
                      ? const Text(
                          'Click either the gallery or camera icon to upload a picture of your utility Bill',
                          textAlign: TextAlign.center,
                        )
                      : LimitedBox(
                          maxHeight: 600.0,
                          child: Image.memory(_img.buffer.asUint8List()))),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery);
                  },
                  heroTag: 'image10',
                  backgroundColor: ZxplorePrimaryColor,
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.camera);
                  },
                  backgroundColor: ZxplorePrimaryColor,
                  heroTag: 'image11',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ],
            ),
            SizedBox(height: 60.0),

            // Resident permit for non-Ghanian
            (accountFormBloc!.countryOfResident != "GHANA" &&
                    accountFormBloc!.countryOfResident != null)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("2"),
                      SizedBox(height: 30.0),
                      Text("Resident Permit"),
                      SizedBox(height: 15.0),
                      Container(
                        child: Platform.isAndroid
                            ? FutureBuilder<void>(
                                future: retrieveLostData2(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<void> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                    case ConnectionState.waiting:
                                      return const Text(
                                        'Click either the gallery or camera icon to upload a picture of your resident permit',
                                        textAlign: TextAlign.center,
                                      );
                                    case ConnectionState.done:
                                      return (_img2.buffer.lengthInBytes == 0
                                          ? const Text(
                                              'Click either the gallery or camera icon to upload a picture of your resident permit',
                                              textAlign: TextAlign.center,
                                            )
                                          : LimitedBox(
                                              maxHeight: 600.0,
                                              child: Image.memory(
                                                  _img2.buffer.asUint8List())));
                                    default:
                                      if (snapshot.hasError) {
                                        return Text(
                                          'Pick image error: ${snapshot.error}}',
                                          textAlign: TextAlign.center,
                                        );
                                      } else {
                                        const Text(
                                          'Click either the gallery or camera icon to upload a picture of your resident permit',
                                          textAlign: TextAlign.center,
                                        );
                                      }
                                  }
                                  return Text(
                                    'Click either the gallery or camera icon to upload a picture of your resident permit',
                                    textAlign: TextAlign.center,
                                  );
                                },
                              )
                            : (_img2.buffer.lengthInBytes == 0
                                ? const Text(
                                    'Click either the gallery or camera icon to upload a picture of your resident permit',
                                    textAlign: TextAlign.center,
                                  )
                                : LimitedBox(
                                    maxHeight: 600.0,
                                    child: Image.memory(
                                        _img2.buffer.asUint8List()))),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: () {
                              _onImageButtonPressed2(ImageSource.gallery);
                            },
                            heroTag: 'image12',
                            backgroundColor: ZxplorePrimaryColor,
                            tooltip: 'Pick Image from gallery',
                            child: const Icon(Icons.photo_library),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              _onImageButtonPressed2(ImageSource.camera);
                            },
                            backgroundColor: ZxplorePrimaryColor,
                            heroTag: 'image13',
                            tooltip: 'Take a Photo',
                            child: const Icon(Icons.camera_alt),
                          ),
                        ],
                      ),
                      SizedBox(height: 70.0),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

//  Text _getRetrieveErrorWidget() {
//    if (_retrieveDataError != null) {
//      final Text result = Text(_retrieveDataError);
//      _retrieveDataError = null;
//      return result;
//    }
//    return null;
//  }

//  Widget _previewImage() {
//    final Text retrieveError = _getRetrieveErrorWidget();
//    if (retrieveError != null) {
//      return retrieveError;
//    }
//    if (_imageFile != null) {
//      _convertImagesToByte();
//      return Image.file(_imageFile);
//    } else if (_pickImageError != null) {
//      return Text(
//        'Pick image error: $_pickImageError',
//        textAlign: TextAlign.center,
//      );
//    } else {
//      return const Text(
//        'Click either the gallery or camera icon to upload a picture of your utility Bill',
//        textAlign: TextAlign.center,
//      );
//    }
//  }

  Future _convertImagesToByte(String? msg) async {
    List<int> imageBytes = await _imageFile!.readAsBytes();
    var maxFileSizeInBytes = 2 * 1048576; // 2 MB
    var fileSize = imageBytes.length; // Get the file size in bytes
    if (fileSize < maxFileSizeInBytes) {
      var imgBytes = new Uint8List.fromList(imageBytes);

      String base64Image = base64Encode(imageBytes);
      _img = imgBytes.buffer.asByteData();

      accountFormBloc!.setUploadUtilityBillForm(base64Image);

      if (msg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Size of Image is too large. Image size must be less than 2MB')),
      );
    }

//    print(base64Image);
  }

  Future _convertImagesToByte2(String? msg) async {
    List<int> imageBytes = await _imageFile2!.readAsBytes();

    var maxFileSizeInBytes = 2 * 1048576; // 2 MB
    var fileSize = imageBytes.length; // Get the file size in bytes
    if (fileSize <= maxFileSizeInBytes) {
      var imgBytes = new Uint8List.fromList(imageBytes);

      String base64Image = base64Encode(imageBytes);
      _img2 = imgBytes.buffer.asByteData();

      accountFormBloc!.setUploadResidentPermit(base64Image);
      if (msg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Size of Image is too large. Image size must be less than 2MB')),
      );
    }

//    print(base64Image);
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _convertImagesToByte(null);
      });
    } else {
      retrieveDataError = response.exception!.code;
    }
  }

  Future<void> retrieveLostData2() async {
    final LostDataResponse response = await _picker2.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile2 = response.file;
        _convertImagesToByte(null);
      });
    } else {
      retrieveDataError = response.exception!.code;
    }
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await _picker.pickImage(source: source, maxHeight: 350);
      if (_imageFile != null) {
        _convertImagesToByte(null);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Utility Bill Uploaded')),
        );
      }
    } catch (e) {
      pickImageError = e;
    }
    setState(() {});
  }

  void _onImageButtonPressed2(ImageSource source) async {
    try {
      _imageFile2 = await _picker2.pickImage(source: source, maxHeight: 350);
      if (_imageFile2 != null) {
        _convertImagesToByte2(null);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Resident permit Uploaded')),
        );
      }
    } catch (e) {
      pickImageError2 = e;
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
