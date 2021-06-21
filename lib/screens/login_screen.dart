import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zxplore_app/utils/flushbar_helper.dart';

import '../blocs/login_bloc.dart';
import '../colors.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  bool _passwordVisible = false;
  @override
  void initState() {
    _loginBloc = LoginBloc();
    _passwordVisible = false;
    super.initState();
  }

  Widget userNameField() {
    return StreamBuilder(
      stream: _loginBloc.username,
      builder: (context, snapshot) {
        return AccentColorOverride(
          color: ZxplorePrimaryColor,
          child: TextField(
            onChanged: _loginBloc.changeUserName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Username',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
        stream: _loginBloc.password,
        builder: (context, snapshot) {
          return AccentColorOverride(
            color: ZxplorePrimaryColor,
            child: TextField(
              onChanged: _loginBloc.changePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: snapshot.error,
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: ZxplorePrimaryColor,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_passwordVisible,
            ),
          );
        });
  }

  Widget submitButton() {
    return StreamBuilder(
      stream: _loginBloc.submitValid,
      builder: (context, snapshot) {
        return ButtonTheme(
          height: 60.0,
          child: RaisedButton(
            child: Text('Login'),
            textColor: Color.fromRGBO(255, 255, 255, 1),
            color: ZxplorePrimaryColor,
            elevation: 8.0,
            onPressed: snapshot.hasData
                ? () async {
                    var loadingBar = FlushbarHelper.createLoading(
                        message: "Attempting to login....",
                        linearProgressIndicator: null);
                    loadingBar..show(context);

                    _loginBloc.submit();

                    _loginBloc.subjectLoginResponse
                        .listen((loginResponse) async {
                      loadingBar.dismiss();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyHomePage()),
                      );
                    }).onError((error) {
                      loadingBar.dismiss();

                      loadingBar.dismiss();
                      FlushbarHelper.createError(
                              message: "${error.toString()}.")
                          .show(context);
                      loadingBar.dismiss();
                    });
                  }
                : null,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        body: SafeArea(
          child: ListView(children: <Widget>[
            Container(
              color: ZxplorePrimaryColor,
              height: 0.5 * MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                  height: 120,
                  width: 120,
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Enter your Zenith bank active directory credentials below. This helps identify the employee that wants to access the application.',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: userNameField(),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: passwordField(),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: submitButton(),
            ),
//          Expanded(child: WavyFooter())
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc?.dispose();
    super.dispose();
  }
}

Future<bool> _exitApp(BuildContext context) {
  return showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text('Do you want to exit this application?'),
          content: new Text('We hate to see you leave...'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            new FlatButton(
              onPressed: () => exit(0),
              child: new Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;
}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}
