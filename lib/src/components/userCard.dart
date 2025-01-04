import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users/src/models/user.dart';
import 'package:users/src/provider/usersProvider.dart';
import 'package:users/src/routes/appRoutes.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? CircleAvatar(
            child: Icon(Icons.person_rounded, size: 40, color: Colors.white))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 4,
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: avatar,
          title: Text(
            user.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:
                  Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
            ),
          ),
          subtitle: Text(
            user.email,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.USER_FORM,
                      arguments: user,
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.blueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Confirmar Exclusão",
                            style: TextStyle(color: Colors.white)),
                        content: Text(
                            "Tem certeza que deseja remover este usuário?",
                            style: TextStyle(color: Colors.white)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancelar",
                                style: TextStyle(color: Colors.white)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .red, // Cor vermelha para o botão de excluir
                            ),
                            onPressed: () {
                              Provider.of<UsersProvider>(context, listen: false)
                                  .remove(user);
                              Navigator.of(context).pop();
                            },
                            child: Text("Remover",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
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
