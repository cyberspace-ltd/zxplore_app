import 'package:flutter/material.dart';
import 'package:zxplore_app/utils/secure_storage.dart';

import 'blocs/login_bloc.dart';
import 'colors.dart';
import 'home.dart';
import 'models/login_response.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc();
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
              ),
              obscureText: true,
            ),
          );
        });
  }

  Widget submitButton() {
    return StreamBuilder(
      stream: _loginBloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Login'),
          textColor: Color.fromRGBO(255, 255, 255, 1),
          color: ZxplorePrimaryColor,
          elevation: 8.0,
//          onPressed: snapshot.hasData ? _loginBloc.submit : null,

          onPressed: snapshot.hasData
              ? () async {
                  _loginBloc.submit();
                  final loadingSnackBar = SnackBar(content: Text('Attempting to login....'));

                  Scaffold.of(context).showSnackBar(loadingSnackBar);

                  _loginBloc.subjectLoginResponse.first.then((loginResponse) async {
                    if (loginResponse.status) {
                      Scaffold.of(context).removeCurrentSnackBar();

                      await SecureStorage.saveAgentInformation(
                          loginResponse?.data?.user?.token,
                          loginResponse?.data?.user?.employeeId?.toString(),
                          loginResponse?.data?.user?.branchNumber.toString());


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyHomePage()),
                      );

                    } else {
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(loginResponse.message),
                        duration: Duration(seconds: 15),
                      ));
                    }
                  }).catchError((error) {
                    Scaffold.of(context).removeCurrentSnackBar();

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(error),
                      duration: Duration(seconds: 15),
                    ));
                  });
                }
              : null,
        );
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Loading data from API..."), CircularProgressIndicator()],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return SnackBar(
      content: Text(error),
      action: SnackBarAction(
        label: 'retry',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 80.0),
              Column(
                children: <Widget>[
                  SizedBox(height: 16.0),
                  Text(
                    'Welcome to Z-xplore',
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'Enter your Zenith bamk active directory credentials below. This helps identify the employee that wants to access the application.',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.0),
              userNameField(),
              SizedBox(height: 12.0),
              passwordField(),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                      child: Text('Clear'),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      onPressed: () {}),
                  submitButton(),
                ],
              ),
            ],
          ),
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
