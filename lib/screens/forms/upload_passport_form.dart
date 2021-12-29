import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
    accountFormBloc!.uploadPassportController.listen((base64Signature) {
      if (_img.lengthInBytes == 0) {
        var imageData = base64Decode(base64Signature!);

        setState(() {
          _img = imageData.buffer.asByteData();
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
                  heroTag: 'image0',
                  backgroundColor: ZxplorePrimaryColor,
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.camera);
                  },
                  backgroundColor: ZxplorePrimaryColor,
                  heroTag: 'image1',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ],
            ),
            SizedBox(height: 40.0),
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

    accountFormBloc!.setUploadPassportForm(base64Image);
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
        _convertImagesToByte();
      });
    } else {
      retrieveDataError = response.exception!.code;
    }
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await _picker.pickImage(source: source, maxHeight: 350);
      if (_imageFile != null) {
        _convertImagesToByte();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Picture Uploaded')),
        );
      }
    } catch (e) {
      pickImageError = e;
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
