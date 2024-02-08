import 'package:examen_practic_sim/Models/User.dart';
import 'package:examen_practic_sim/Providers/db_users_provider.dart';
import 'package:examen_practic_sim/Providers/ui_provider.dart';
import 'package:examen_practic_sim/Providers/users_providers.dart';
import 'package:examen_practic_sim/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserService userService = Provider.of<UserService>(context);
    ScanListProvider scanListProvider = Provider.of<ScanListProvider>(context);
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    

    List<User> usuaris = uiProvider.isOnline? userService.users : scanListProvider.scans;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: usuaris.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: usuaris.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: GestureDetector(
                    child: UserCard(usuari: usuaris[index]),
                    onTap: () {
                      userService.tempUser = usuaris[index].copy();
                      Navigator.of(context).pushNamed('detail');
                    },
                  ),
                  onDismissed: (direction) {
                    if (usuaris.length < 2) {
                      uiProvider.isOnline
                          ? userService.loadUsers()
                          : scanListProvider.carregaScans();
                      // userService.loadUsers();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('No es pot esborrar tots els elements!')));
                    } else {
                      uiProvider.isOnline
                          ? userService.deleteUser(usuaris[index])
                          : scanListProvider.esborraPerID(usuaris[index].id as int);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '${usuaris[index].name} esborrat')));
                    }
                  },
                );
              }),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // scanListProvider.nouScan(User(address: "address", email: "email", name: "name", phone: "phone", photo: "photo"));
          userService.tempUser = User(
              address: '',
              email: '',
              name: '',
              phone: '',
              photo: '');
          Navigator.of(context).pushNamed('detail');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}