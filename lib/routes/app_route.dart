import 'package:cargic_ninja/screens/auth_screen/login_method_screen.dart';
import 'package:cargic_ninja/screens/auth_screen/login_with_email.dart';
import 'package:cargic_ninja/screens/auth_screen/register_screen.dart';
import 'package:cargic_ninja/screens/auth_screen/splash_screen.dart';
import 'package:cargic_ninja/screens/home_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> appRoute = {
  SplashScreen.id: (context) => SplashScreen(),
  LoginMethodScreen.id: (context) => LoginMethodScreen(),
  LoginWithEmailScreen.id: (context) => LoginWithEmailScreen(),
  RegisterScreen.id: (context) => RegisterScreen(),
  NinjaHome.id: (context) => NinjaHome(),
};
