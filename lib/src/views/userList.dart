import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users/src/components/userCard.dart';
import 'package:users/src/models/user.dart';
import 'package:users/src/provider/usersProvider.dart';
import 'package:users/src/routes/appRoutes.dart';

class userList extends StatelessWidget {
  const userList({super.key});

  @override
  Widget build(BuildContext context) {
    final UsersProvider users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.USER_FORM,
                    arguments: const User(
                      id: '',
                      name: '',
                      email: '',
                      avatarUrl: '',
                    ));
              },
              icon: Icon(Icons.add))
        ],
        title: Text(
          "Users List",
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Colors.black54,
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (context, index) => UserCard(users.byIndex(index)),
      ),
    );
  }
}
