import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/libs/Signature.dart';
import 'package:zxplore_app/utils/flushbar_helper.dart';

import '../../colors.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:zxplore_app/screens/home_screen.dart';

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
  ImagePicker _picker = ImagePicker();

  AccountFormBloc? accountFormBloc;
  var loadingBar;
  bool isLoading = false;
  late bool _isButtonDisabled;

  XFile? _imageFile;
  // ignore: unused_field
  String? _retrieveDataError;
  // ignore: unused_field
  dynamic _pickImageError;

  bool isSignatureAcceptButtonVisible = false;
  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;

    accountFormBloc = BlocProvider.of<AccountFormBloc>(context);

    accountFormBloc!.uploadSignatureController.listen((base64Signature) {
      var imageData = base64Decode(base64Signature!);
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
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                'Upload your Signature by clicking either the gallery or camera icon',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery);
                    _isButtonDisabled = false;
                    setState(() {
                      isSignatureAcceptButtonVisible = false;
                    });
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
                    setState(() {
                      isSignatureAcceptButtonVisible = false;
                    });
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
            SizedBox(
              height: 16,
            ),
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
                        // final sign = _sign.currentState;
                        setState(() {
                          isSignatureAcceptButtonVisible = true;
                        });
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
                Visibility(
                  visible: isSignatureAcceptButtonVisible,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        child: Text('Accept Signature.'),
                        onPressed: () async {
                          final sign = _sign.currentState!;
                          if (sign.points.length == 0) {
                            FlushbarHelper.createError(
                                message: "You have not signed this form")
                              ..show(context);
                            return;
                          }
                          //retrieve image data, do whatever you want with it (send to server, save locally...)
                          final image = await sign.getData();
                          var data = await (image.toByteData(
                              format: ui.ImageByteFormat.png));
                          sign.clear();
                          final encoded = base64
                              .encode(data!.buffer.asUint8ClampedList())
                              .toString();

                          accountFormBloc!.setSignature(encoded);

                          setState(() {
                            _img = data;
                            _isButtonDisabled = false;
                          });
//                        debugPrint("onPressed " + encoded);
                        },
                      ),
                      TextButton(
                          child: Text(
                            'Clear Signature',
                          ),
                          onPressed: () {
                            final sign = _sign.currentState!;
                            sign.clear();
                            accountFormBloc!.setSignature(null);
                            setState(() {
                              _img = ByteData(0);
                              _isButtonDisabled = true;
                              isSignatureAcceptButtonVisible = false;
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                disclaimerText(),
                submitButton(),
                SizedBox(height: 60.0),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget disclaimerText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text:
              "By clicking the 'Submit Account' button, you accept that you have read the ",
          style: Theme.of(context).textTheme.caption,
          children: [
            TextSpan(
                text: "Terms & Conditions",
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .apply(color: Colors.pink, fontWeightDelta: 1),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    const url =
                        'https://www.zenithbank.com.gh/terms-and-conditions/';
                    launchURL(url);
                  }),
            TextSpan(
              text:
                  " and that you understand them and that you (the RM) agree to be bound by them.",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget submitButton() {
    return StreamBuilder(
      stream: accountFormBloc!.submitValid,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: SizedBox(
              height: 60,
              width: 200,
              child: new ElevatedButton(
                child: (isLoading == false)
                    ? Text('Submit Account')
                    : CircularProgressIndicator(),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red.shade900,
                  ),
                ),
                onPressed:
                    (snapshot.hasData && !isLoading && !_isButtonDisabled)
                        ? submitAccount
                        : null,
                // onPressed: _isButtonDisabled ? null : submitAccount,
//              onPressed: accountFormBloc.submit,
              ),
            ),
          ),
        );
      },
    );
  }

  void submitAccount() async {
    setState(() {
      isLoading = true;
      _isButtonDisabled = true;
    });
    var loadingBar = FlushbarHelper.createLoading(
        message: "Attempting to submit account form....")
      ..show(context);
    accountFormBloc!.submit();

    accountFormBloc!.subjectSaveAccountResponse.listen(
      (response) {
        loadingBar.dismiss(context);
        setState(() {
          isLoading = false;
        });
        _showSuccessDialog(
            'The created account was sent successfully, an account number will be generated shortly.');
      },
    ).onError((error) {
      loadingBar.dismiss(context);

      FlushbarHelper.createError(message: error.toString())..show(context);
      setState(() {
        isLoading = false;
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
            OutlinedButton(
              child: Text('Done'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.green,
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(color: Colors.green),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(16),
                ),
              ),
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
    List<int> imageBytes = await _imageFile!.readAsBytes();
    var imgBytes = new Uint8List.fromList(imageBytes);

    String base64Image = base64Encode(imageBytes);
    _img = imgBytes.buffer.asByteData();

    accountFormBloc!.setSignature(base64Image);

//    print(base64Image);
  }

  Future<void> retrieveLostData() async {
    var imagePicker = ImagePicker();
    final LostDataResponse response = await imagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _convertImagesToByte();
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await _picker.pickImage(source: source, maxHeight: 350);
      _convertImagesToByte();
    } catch (e) {
      _pickImageError = e;
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
