import 'package:cargic_ninja/helpers/auth_helper.dart';
import 'package:cargic_ninja/screens/auth_screen/register_screen.dart';
import 'package:cargic_ninja/utils/colors.dart';
import 'package:cargic_ninja/widgets/brand_logo.dart';
import 'package:cargic_ninja/widgets/candy_button.dart';
import 'package:cargic_ninja/widgets/progress_dialog.dart';
import 'package:cargic_ninja/widgets/sweet_text_field.dart';

import 'package:flutter/material.dart';

class LoginWithEmailScreen extends StatefulWidget {
  static const String id = 'LoginWithEmailScreen';

  @override
  _LoginWithEmailScreenState createState() => _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends State<LoginWithEmailScreen> {
  AuthHelper _authHelper = AuthHelper();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isObsecure = true;
  void showSnackbar({String message}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  loginUser() {
    //do validation here
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialoger(
        message: 'Logging you in ...',
      ),
    );
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      _authHelper
          .loginUser(
              email: _emailController.text,
              password: _passwordController.text,
              context: context)
          .then((value) {
        Navigator.of(context).pop();

        if (value == 'user-not-found') {
          print('No user found for that email.');
          showSnackbar(message: 'No user found for that email.');
        } else if (value == 'wrong-password') {
          print('Wrong password provided for that user.');
          showSnackbar(message: 'Wrong password provided for that user.');
        } else {
          // Navigator.of(context).popAndPushNamed(NavigationScreen.id);
        }
      });
    } else {
      Navigator.of(context).pop();
      showSnackbar(message: 'Field Can\'t be empty.');
    }
  }

  toggleObsecure() {
    setState(() {
      isObsecure = !isObsecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                BrandLogo(),
                Container(
                  margin: EdgeInsets.all(30.0),
                  padding: EdgeInsets.only(
                    left: 27.0,
                    right: 27.0,
                    top: 52.0,
                    bottom: 52.0,
                  ),
                  decoration: BoxDecoration(
                    color: CargicColors.plainWhite,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        offset: Offset(0, 4.0),
                        color: CargicColors.cosmicShadow,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SweetTextField(
                        controller: _emailController,
                        obsecureText: false,
                        textCapitalization: TextCapitalization.none,
                        keyBoardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        leadingIcon: Icons.email,
                        // trailinIcon: Icons.add,
                      ),
                      SizedBox(height: 20),
                      SweetTextField(
                        controller: _passwordController,
                        textCapitalization: TextCapitalization.none,
                        obsecureText: isObsecure,
                        toggleObsecure: toggleObsecure,
                        hintText: 'Password',
                        leadingIcon: Icons.lock,
                        trailinIcon: Icons.visibility,
                      ),
                      SizedBox(height: 16.5),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: CargicColors.smoothGray,
                            decoration: TextDecoration.underline,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.5),
                      CandyButton(
                        buttonColor: CargicColors.hopeBlue,
                        titleColor: CargicColors.plainWhite,
                        title: 'Login',
                        onPressed: loginUser,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(RegisterScreen.id);
                  },
                  child: Container(
                    child: Text(
                      'CREATE AN ACCOUNT',
                      style: TextStyle(
                        color: CargicColors.smoothGray,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
