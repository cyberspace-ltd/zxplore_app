import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/libs/Signature.dart';
import 'package:zxplore_app/utils/flushbar_helper.dart';

import '../../colors.dart';
import '../../login.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:zxplore_app/home.dart';

class SignatoryStep extends StatefulWidget {
  @override
  _SignatoryStepState createState() => _SignatoryStepState();
}

class _SignatoryStepState extends State<SignatoryStep>
    with AutomaticKeepAliveClientMixin<SignatoryStep> {
  ByteData _img = ByteData(0);
  var color = Colors.black;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  AccountFormBloc accountFormBloc;
  var loadingBar;
  bool _isButtonDisabled;

  File _imageFile;
  String _retrieveDataError;
  dynamic _pickImageError;
  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;

    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);

    accountFormBloc.uploadSignatureController.listen((base64Signature) {
      var imageData = base64Decode(base64Signature);
      setState(() {
        _img = imageData.buffer.asByteData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SizedBox(height: 8,),

            Padding(
              padding: const EdgeInsets.only(left:8.0, right: 8),
              child: Text(
                'Upload your Signature by clicking either the gallery or camera icon',
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery);
                    _isButtonDisabled = false;

                  },
                  heroTag: 'image0',
                  backgroundColor: ZxplorePrimaryColor,
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.camera);
                    _isButtonDisabled = false;

                  },
                  backgroundColor: ZxplorePrimaryColor,
                  heroTag: 'image1',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),

              ],
            ),
            Text(
              'Or',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16,),

            Text(
              'Sign Below',
              textAlign: TextAlign.center,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LimitedBox(
                maxHeight: 300,
                maxWidth: 350,
                child: Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Signature(
                      color: color,
                      key: _sign,
                      onSign: () {
                        final sign = _sign.currentState;
                        // debugPrint(
                        //     '${sign.points.length} points in the signature');
                      },
                      strokeWidth: strokeWidth,
                    ),
                  ),
                ),
              ),
            ),
            _img.buffer.lengthInBytes == 0
                ? Container()
                : LimitedBox(
                    maxHeight: 200.0,
                    child: Image.memory(_img.buffer.asUint8List())),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlineButton(
                      child: Text('Accept Signature.'),
                      onPressed: () async {
                        final sign = _sign.currentState;
                        if (sign.points.length == 0) {
                          FlushbarHelper.createError(
                              message: "You have not signed this form")
                            ..show(context);
                          return;
                        }
                        //retrieve image data, do whatever you want with it (send to server, save locally...)
                        final image = await sign.getData();
                        var data = await image.toByteData(
                            format: ui.ImageByteFormat.png);
                        sign.clear();
                        final encoded = base64
                            .encode(data.buffer.asUint8ClampedList())
                            .toString();

                        accountFormBloc.setSignature(encoded);

                        setState(() {
                          _img = data;
                          _isButtonDisabled = false;

                        });
//                        debugPrint("onPressed " + encoded);
                      },
                    ),
                    FlatButton(
                        child: Text(
                          'Clear Signature',
                        ),
                        textColor: ZxploreRedColor,
                        onPressed: () {
                          final sign = _sign.currentState;
                          sign.clear();
                          accountFormBloc.setSignature(null);
                          setState(() {
                            _img = ByteData(0);
                             _isButtonDisabled = true;
                          });
                        }),
                  ],
                ),
                SizedBox(height: 16.0),
                submitButton(),
                SizedBox(height: 60.0),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return StreamBuilder(
      stream: accountFormBloc.submitValid,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: new RaisedButton(
              child: Text('Submit Account'),
              textColor: Color.fromRGBO(255, 255, 255, 1),
              color: ZxplorePrimaryColor,
              elevation: 8.0,
              onPressed: _isButtonDisabled ? null : submitAccount,
//              onPressed: accountFormBloc.submit,
            ),
          ),
        );
      },
    );
  }

  void submitAccount()async{
      var loadingBar = FlushbarHelper.createLoading(
          message: "Attempting to submit account form....")
        ..show(context);
      setState(() {
        _isButtonDisabled = true;
      });
      accountFormBloc.submit();

      accountFormBloc.subjectSaveAccountResponse
          .listen((response) {
        loadingBar.dismiss(context);


        _showSuccessDialog(
            'The created account was sent successfully, an account number will be generated shortly.');
      }).onError((error) {
        loadingBar.dismiss(context);

        FlushbarHelper.createError(message: error.toString())
          ..show(context);
        setState(() {
          _isButtonDisabled = false;
        });

      });
  }
  void _showSuccessDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Account Creation Status"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            OutlineButton(
              child: Text('Done'),
              textColor: Colors.green,
              color: Colors.transparent,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MyHomePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }


  Future _convertImagesToByte() async {
    List<int> imageBytes = await _imageFile.readAsBytes();
    var imgBytes = new Uint8List.fromList(imageBytes);

    String base64Image = base64Encode(imageBytes);
    _img = imgBytes.buffer.asByteData();

    accountFormBloc.setSignature(base64Image);

//    print(base64Image);
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _convertImagesToByte();
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await ImagePicker.pickImage(source: source, maxHeight: 350);
      _convertImagesToByte();
    } catch (e) {
      _pickImageError = e;
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
