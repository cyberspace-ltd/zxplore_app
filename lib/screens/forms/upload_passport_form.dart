import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';

import '../../colors.dart';

class UploadPassportStep extends StatefulWidget {
  @override
  _UploadPassportState createState() => _UploadPassportState();
}

class _UploadPassportState extends State<UploadPassportStep>
    with AutomaticKeepAliveClientMixin<UploadPassportStep> {
  File _imageFile;
  String _retrieveDataError;
  dynamic _pickImageError;
  AccountFormBloc accountFormBloc;

  @override
  void initState() {
    super.initState();
    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);
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
                              'Click either the gallery or camera icon to upload a passport',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return (LimitedBox(
                                maxHeight: 600.0, child: _previewImage()));
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              const Text(
                                'Click either the gallery or camera icon to upload a passport',
                                textAlign: TextAlign.center,
                              );
                            }
                        }
                      },
                    )
                  : (LimitedBox(maxHeight: 600.0, child: _previewImage())),
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

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      _convertImagesToByte();
      return Image.file(_imageFile);
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'Click either the gallery or camera icon to upload a passport',
        textAlign: TextAlign.center,
      );
    }
  }

  Future _convertImagesToByte() async {
    List<int> imageBytes = await _imageFile.readAsBytes();

    String base64Image = base64Encode(imageBytes);

    accountFormBloc.setUploadPassportForm(base64Image);
    print(base64Image);
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await ImagePicker.pickImage(source: source);
    } catch (e) {
      _pickImageError = e;
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
