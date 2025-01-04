import 'package:flutter/material.dart';
import 'package:users/src/provider/usersProvider.dart';
import 'package:users/src/routes/appRoutes.dart';
import 'package:users/src/views/userForm.dart';
import 'package:users/src/views/userList.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsersProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'users',
        theme: ThemeData.dark(useMaterial3: true),
        routes: {
          AppRoutes.HOME: (_) => userList(),
          AppRoutes.USER_FORM: (_) => UserForm()
        },
      ),
    );
  }
}
