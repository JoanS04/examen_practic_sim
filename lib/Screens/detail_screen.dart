import 'package:examen_practic_sim/Providers/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// import '../ui/input_decorations.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<UserService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: _UserForm(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (userForm.isValidForm()) {
            userForm.saveOrCreateUser();
            Navigator.of(context).pop();
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class _UserForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<UserService>(context);
    final tempUser = userForm.tempUser;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: userForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: tempUser.name,
                onChanged: (value) => tempUser.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nom és obligatori';
                },
                decoration: InputDecoration(
                  labelText: 'nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${tempUser.email}',
                onChanged: (value) {
                  tempUser.email = value;
                  
                },
                decoration: InputDecoration(
                  labelText: 'correu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${tempUser.address}',
                onChanged: (value) {
                  tempUser.address = value;
                  
                },
                decoration: InputDecoration(
                  labelText: 'address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${tempUser.phone}',
                onChanged: (value) {
                  tempUser.phone = value;
                  
                },
                decoration: InputDecoration(
                  labelText: 'phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              tempUser.photo != ""
                  ?
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.network(tempUser.photo),
                )
                  : TextFormField(
                initialValue: '${tempUser.photo}',
                onChanged: (value) {
                  tempUser.photo = value;
                  
                },
                decoration: InputDecoration(
                  labelText: 'URL de la foto',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      );
}
