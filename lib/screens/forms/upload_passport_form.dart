import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zxplore_app/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';

class UploadPassportStep extends StatefulWidget {
  @override
  _UploadPassportState createState() => _UploadPassportState();
}

class _UploadPassportState extends State<UploadPassportStep>
    with AutomaticKeepAliveClientMixin<UploadPassportStep> {
  XFile? _imageFile;
  String? retrieveDataError;
  dynamic pickImageError;
  AccountFormBloc? accountFormBloc;
  ByteData _img = ByteData(0);
  ImagePicker _picker = ImagePicker();
  SharedPreferences? prefs;

  XFile? _imageAdmFile;
  String? retrieveAdmDataError;
  dynamic pickImageAdmError;
  ByteData _imgAdm = ByteData(0);
  // ImagePicker _pickerAdm = ImagePicker();
  String? acctCategory;

  @override
  void initState() {
    super.initState();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    getSharedPref();
    accountFormBloc!.uploadPassportController.listen((base64Signature) {
      if (_img.lengthInBytes == 0) {
        var imageData = base64Decode(base64Signature!);

        setState(() {
          _img = imageData.buffer.asByteData();
        });
      }
    });

    accountFormBloc!.uploadAdmissionLetterController.listen((base64Signature) {
      if (_imgAdm.lengthInBytes == 0) {
        var imageData = base64Decode(base64Signature!);

        setState(() {
          _imgAdm = imageData.buffer.asByteData();
        });
      }
    });
  }

  getSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //  getAcctType();
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
                              'Click either the gallery or camera icon to upload a passport photograph',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return (_img.buffer.lengthInBytes == 0
                                ? const Text(
                                    'Click either the gallery or camera icon to upload a passport photograph',
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
                                'Click either the gallery or camera icon to upload a passport photograph',
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
                          'Click either the gallery or camera icon to upload a passport photograph',
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
                  heroTag: 'image6',
                  backgroundColor: ZxplorePrimaryColor,
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.camera);
                  },
                  backgroundColor: ZxplorePrimaryColor,
                  heroTag: 'image7',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ],
            ),
            SizedBox(height: 80.0),
            StreamBuilder<String?>(
                stream: accountFormBloc!.accountCategoryType,
                builder: (context, snapshot) {
                  return snapshot.data == null
                      ? SizedBox()
                      : snapshot.data == "ASPIRE ACCOUNT"
                          ? Column(
                              children: [
                                Text("2. Admission Letter"),
                                SizedBox(height: 15.0),
                                Container(
                                  child: Platform.isAndroid
                                      ? FutureBuilder<void>(
                                          future: retrieveLostDataAdm(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<void> snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                              case ConnectionState.waiting:
                                                return const Text(
                                                  'Click either the gallery or camera icon to upload your admission letter',
                                                  textAlign: TextAlign.center,
                                                );
                                              case ConnectionState.done:
                                                return (_imgAdm.buffer
                                                            .lengthInBytes ==
                                                        0
                                                    ? const Text(
                                                        'Click either the gallery or camera icon to upload your admission letter',
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    : LimitedBox(
                                                        maxHeight: 600.0,
                                                        child: Image.memory(
                                                            _imgAdm.buffer
                                                                .asUint8List())));
                                              default:
                                                if (snapshot.hasError) {
                                                  return Text(
                                                    'Pick image error: ${snapshot.error}}',
                                                    textAlign: TextAlign.center,
                                                  );
                                                } else {
                                                  const Text(
                                                    'Click either the gallery or camera icon to upload your admission letter',
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
                                      : (_imgAdm.buffer.lengthInBytes == 0
                                          ? const Text(
                                              'Click either the gallery or camera icon to upload your admission letter',
                                              textAlign: TextAlign.center,
                                            )
                                          : LimitedBox(
                                              maxHeight: 600.0,
                                              child: Image.memory(_imgAdm.buffer
                                                  .asUint8List()))),
                                ),
                                SizedBox(height: 30.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FloatingActionButton(
                                      onPressed: () {
                                        _onImageAdmButtonPressed(
                                            ImageSource.gallery);
                                      },
                                      heroTag: 'image8',
                                      backgroundColor: ZxplorePrimaryColor,
                                      tooltip: 'Pick Image from gallery',
                                      child: const Icon(Icons.photo_library),
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        _onImageAdmButtonPressed(
                                            ImageSource.camera);
                                      },
                                      backgroundColor: ZxplorePrimaryColor,
                                      heroTag: 'image9',
                                      tooltip: 'Take a Photo',
                                      child: const Icon(Icons.camera_alt),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 100.0),
                              ],
                            )
                          : SizedBox();
                })
          ],
        ),
      ),
    );
  }

  Future _convertImagesToByte(String? msg) async {
    List<int> imageBytes = await _imageFile!.readAsBytes();

    var maxFileSizeInBytes = 2 * 1048576;
    var fileSize = imageBytes.length; // Get the file size in bytes

    if (fileSize < maxFileSizeInBytes) {
      var imgBytes = new Uint8List.fromList(imageBytes);

      String base64Image = base64Encode(imageBytes);

      _img = imgBytes.buffer.asByteData();

      accountFormBloc!.setUploadPassportForm(base64Image);
      if (msg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    } else {
      // File is too large, ask user to upload a smaller file, or compress the file/image
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Size of Image is too large. Image size must be less than 2MB')),
      );
    }

//    print(base64Image);
  }

  Future _convertAdmImagesToByte() async {
    List<int> imageBytes = await _imageAdmFile!.readAsBytes();
    var imgBytes = new Uint8List.fromList(imageBytes);

    String base64Image = base64Encode(imageBytes);

    _imgAdm = imgBytes.buffer.asByteData();

    accountFormBloc!.setUploadAdmissionLetter(base64Image);
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

  Future<void> retrieveLostDataAdm() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageAdmFile = response.file;
        _convertAdmImagesToByte();
      });
    } else {
      retrieveAdmDataError = response.exception!.code;
    }
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await _picker.pickImage(source: source, maxHeight: 350);
      if (_imageFile != null) {
        _convertImagesToByte('Picture Uploaded');
        /*
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Picture Uploaded')),
        );
        */
      }
    } catch (e) {
      pickImageError = e;
    }
    setState(() {});
  }

  void _onImageAdmButtonPressed(ImageSource source) async {
    try {
      _imageAdmFile = await _picker.pickImage(source: source, maxHeight: 350);
      if (_imageAdmFile != null) {
        _convertAdmImagesToByte();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Admission letter Uploaded')),
        );
      }
    } catch (e) {
      pickImageAdmError = e;
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
