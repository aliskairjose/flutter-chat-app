import 'package:chat_app/pages/pages.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> appRutes = {
  'users': (_) => const UsersPage(),
  'chat': (_) => const ChatPage(),
  'login': (_) => const LoginPage(),
  'loading': (_) => const LoadingPage(),
  'register': (_) => const RegisterPage()
};
