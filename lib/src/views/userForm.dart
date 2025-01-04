import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users/src/models/user.dart';
import 'package:users/src/provider/usersProvider.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadDataData(User user) {
    if (user != null) {
      _formData["id"] = user.id;
      _formData["name"] = user.name;
      _formData["email"] = user.email;
      _formData["avatarUrl"] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)?.settings.arguments as User;
    _loadDataData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Colors.black54,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                bool isValid = _form.currentState!.validate();
                if (isValid) {
                  _form.currentState?.save();
                  Provider.of<UsersProvider>(context, listen: false).put(
                    User(
                      id: _formData["id"].toString(),
                      name: _formData["name"].toString(),
                      email: _formData["email"].toString(),
                      avatarUrl: _formData["avatarUrl"].toString(),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              _formData["avatarUrl"]?.isNotEmpty ?? false
                  ? Image.network(
                      _formData["avatarUrl"]!,
                      width: 150,
                      height: 150,
                    )
                  : Icon(
                      Icons.person_rounded,
                      size: 150,
                    ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 9, 0, 20),
              ),
              TextFormField(
                initialValue: _formData["name"],
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nome Inválido.";
                  }
                  if (value.trim().length < 3 || value.trim().length > 15) {
                    return "O nome precisa ter de 3 à 15 caracteres.";
                  }
                  return null;
                },
                onSaved: (value) => _formData["name"] = value!,
              ),
              TextFormField(
                initialValue: _formData["email"],
                decoration: InputDecoration(labelText: "Email"),
                onSaved: (value) => _formData["email"] = value!,
              ),
              TextFormField(
                initialValue: _formData["avatarUrl"],
                decoration: InputDecoration(labelText: "Url do Avatar"),
                onSaved: (value) => _formData["avatarUrl"] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
