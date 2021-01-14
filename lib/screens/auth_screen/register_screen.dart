import 'package:cargic_ninja/helpers/auth_helper.dart';
import 'package:cargic_ninja/screens/auth_screen/login_with_email.dart';
import 'package:cargic_ninja/utils/colors.dart';
import 'package:cargic_ninja/widgets/brand_logo.dart';
import 'package:cargic_ninja/widgets/candy_button.dart';
import 'package:cargic_ninja/widgets/progress_dialog.dart';
import 'package:cargic_ninja/widgets/sweet_text_field.dart';

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  TextEditingController _fullNameController = TextEditingController();
  // TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  AuthHelper _authHelper = AuthHelper();
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

  registerUser() {
    //do input validation here
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialoger(
        message: 'Signin Up ...',
      ),
    );
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _fullNameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      if (_passwordController.text == _confirmPasswordController.text) {
        _authHelper
            .regsterUser(
          context: context,
          email: _emailController.text,
          password: _passwordController.text,
          fullName: _fullNameController.text,
          // lastName: _lastNameController.text,
          phone: _phoneController.text,
        )
            .then((value) {
          Navigator.of(context).pop();

          if (value == 'weak-password') {
            print('The password provided is too weak.');
            showSnackbar(message: 'The password provided is too weak.');
          } else if (value == 'email-already-in-use') {
            print('The account already exists for that email.');
            showSnackbar(message: 'The account already exists for that email.');
          } else {
            // Navigator.of(context).popAndPushNamed(NavigationScreen.id);
          }
        });
      } else {
        Navigator.of(context).pop();
        showSnackbar(message: 'Password Mismatch.');
      }
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BrandLogo(
                width: 80,
                height: 80,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                padding: EdgeInsets.symmetric(horizontal: 27.0, vertical: 15.0),
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
                    CandyButton(
                      iconColor: CargicColors.rageRed,
                      buttonColor: CargicColors.plainWhite,
                      buttonIcon: 'images/google_icon.svg',
                      title: 'Create with Google',
                      onPressed: () {
                        // _authHelper.signInWithGoogle();
                        print('google');
                      },
                    ),

                    SizedBox(height: 21.0),
                    SweetTextField(
                      controller: _fullNameController,
                      obsecureText: false,
                      leadingIcon: Icons.person,
                      hintText: 'Full Name',
                    ),
                    SizedBox(height: 20),

                    SweetTextField(
                      controller: _emailController,
                      obsecureText: false,
                      keyBoardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      leadingIcon: Icons.email,
                      hintText: 'Email',
                    ),

                    // SizedBox(height: 20),
                    // SweetTextField(
                    //   controller: _lastNameController,
                    //   obsecureText: false,
                    //   leadingIcon: Icons.person,
                    //   hintText: 'Last Name',
                    // ),
                    SizedBox(height: 20),
                    SweetTextField(
                      controller: _phoneController,
                      obsecureText: false,
                      keyBoardType: TextInputType.phone,
                      leadingIcon: Icons.phone,
                      hintText: 'phone',
                    ),
                    SizedBox(height: 20),
                    SweetTextField(
                      controller: _passwordController,
                      obsecureText: isObsecure,
                      toggleObsecure: toggleObsecure,
                      leadingIcon: Icons.lock,
                      trailinIcon: Icons.visibility,
                      hintText: 'Password',
                    ),
                    SizedBox(height: 20),
                    SweetTextField(
                      controller: _confirmPasswordController,
                      obsecureText: isObsecure,
                      toggleObsecure: toggleObsecure,
                      leadingIcon: Icons.lock,
                      trailinIcon: Icons.visibility,
                      hintText: 'Confirm Password',
                    ),
                    SizedBox(height: 25.5),
                    CandyButton(
                      buttonColor: CargicColors.hopeBlue,
                      titleColor: CargicColors.plainWhite,
                      title: 'Create',
                      onPressed: registerUser,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .popAndPushNamed(LoginWithEmailScreen.id);
                },
                child: Container(
                  child: Text(
                    'Have an account ? login',
                    style: TextStyle(
                      color: CargicColors.smoothGray,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
