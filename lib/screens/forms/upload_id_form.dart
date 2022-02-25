import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:zxplore_app/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';

class UploadIdStep extends StatefulWidget {
  @override
  _UploadIdStepState createState() => _UploadIdStepState();
}

class _UploadIdStepState extends State<UploadIdStep>
    with AutomaticKeepAliveClientMixin<UploadIdStep> {
  XFile? _imageFile;
  String? retrieveDataError;
  dynamic pickImageError;
  AccountFormBloc? accountFormBloc;
  ByteData _img = ByteData(0);
  ImagePicker _picker = ImagePicker();

  XFile? _imageFile2;
  String? retrieveDataError2;
  dynamic pickImageError2;
  ByteData _img2 = ByteData(0);
  ImagePicker _picker2 = ImagePicker();

  @override
  void initState() {
    super.initState();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);

    accountFormBloc!.uploadIdImageController.listen((base64Signature) {
      if (_img.lengthInBytes == 0) {
        var imageData = base64Decode(base64Signature!);

        setState(() {
          _img = imageData.buffer.asByteData();
        });
      }
    });
  
    accountFormBloc!.uploadIdImageController2.listen((base64Signature) {
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
             Text("1."),
             SizedBox(height: 10,),
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
                              'Click either the gallery or camera icon to add an ID card',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return (_img.buffer.lengthInBytes == 0
                                ? const Text(
                                    'Click either the gallery or camera icon to upload an ID card',
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
                                'Click either the gallery or camera icon to add an ID card',
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
                          'Click either the gallery or camera icon to upload one side of the ID card',
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
                  heroTag: 'image2',
                  backgroundColor: ZxplorePrimaryColor,
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.camera);
                  },
                  backgroundColor: ZxplorePrimaryColor,
                  heroTag: 'image3',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ],
            ),

              SizedBox(height: 75,),
            Text("2."),

             SizedBox(height: 10,),

                 Container(
              child: Platform.isAndroid
                  ? FutureBuilder<void>(
                      future: retrieveLostData2(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Text(
                              'Click either the gallery or camera icon below to add the other side of your ID card',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return (_img2.buffer.lengthInBytes == 0
                                ? const Text(
                                   'Click either the gallery or camera icon below to add the other side of your ID card',
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
                                'Click either the gallery or camera icon below to add the other side of your ID card',
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
                  : (_img2.buffer.lengthInBytes == 0
                      ? const Text(
                          'Click either the gallery or camera icon below to upload one side of the ID card',
                          textAlign: TextAlign.center,
                        )
                      : LimitedBox(
                          maxHeight: 600.0,
                          child: Image.memory(_img2.buffer.asUint8List()))),
            ),
         
            SizedBox(height: 30.0),
         
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed2(ImageSource.gallery);
                  },
                  heroTag: 'image4',
                  backgroundColor: ZxplorePrimaryColor,
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed2(ImageSource.camera);
                  },
                  backgroundColor: ZxplorePrimaryColor,
                  heroTag: 'image5',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ],
            ),
         
         SizedBox(height: 80,),
         
          ],
        ),
      ),
    );
  }

  Future _convertImagesToByte() async {
    List<int> imageBytes = await _imageFile!.readAsBytes();

    var imgBytes = new Uint8List.fromList(imageBytes);

    String base64Image = base64Encode(imageBytes);

    _img = imgBytes.buffer.asByteData();

    accountFormBloc!.setUploadIdForm(base64Image);
//     print(base64Image);
  }


  Future _convertImagesToByte2() async {
    List<int> imageBytes = await _imageFile2!.readAsBytes();

    var imgBytes = new Uint8List.fromList(imageBytes);

    String base64Image = base64Encode(imageBytes);

    _img2 = imgBytes.buffer.asByteData();

    accountFormBloc!.setUploadIdForm2(base64Image);
//     print(base64Image);
  }


  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _convertImagesToByte();
      });
    } else {
      retrieveDataError = response.exception!.code;
    }
  }


    Future<void> retrieveLostData2() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile2 = response.file;
        _convertImagesToByte2();
      });
    } else {
      retrieveDataError2 = response.exception!.code;
    }
  }



  void _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await _picker.pickImage(source: source, maxHeight: 350);
      if (_imageFile != null) {
        _convertImagesToByte();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Identification Uploaded')),
        );
      }
    } catch (e) {
      pickImageError = e;
    }

    setState(() {});
  }

void _onImageButtonPressed2(ImageSource source) async {
    try {
      _imageFile2 = await _picker.pickImage(source: source, maxHeight: 350);
      if (_imageFile2 != null) {
        _convertImagesToByte2();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Identification Uploaded')),
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
