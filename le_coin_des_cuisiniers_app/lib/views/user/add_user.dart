import 'package:flutter/material.dart';
import 'package:le_coin_des_cuisiniers_app/components/buttons.dart';
import 'package:le_coin_des_cuisiniers_app/components/label.dart';
import 'package:le_coin_des_cuisiniers_app/components/textfields.dart';
import 'package:le_coin_des_cuisiniers_app/controller/users_controller.dart';
import 'package:le_coin_des_cuisiniers_app/models/users.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _fullName = TextEditingController();

  final TextEditingController _phoneNumber = TextEditingController();

  final TextEditingController _address = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  bool isLoading = false;

  Widget desktopBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Text(
                'LE COIN DES CUISINIERS',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 73, 71, 71)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Complétez ici les informations du nouveau utilisateur',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(right: 150.0),
                            child: MyLabel(
                                labelContent: 'Nom complet de l\'utilisateur')),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          controller: _fullName,
                          enabled: true,
                          hintText: '',
                          obscureText: false,
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Padding(
                            padding: EdgeInsets.only(right: 200.0),
                            child:
                                MyLabel(labelContent: 'Numero de téléphone')),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          controller: _phoneNumber,
                          enabled: true,
                          hintText: '',
                          obscureText: false,
                          prefixIcon: Icons.phone_android,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(right: 240.0),
                            child: MyLabel(labelContent: 'Adresse')),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          controller: _address,
                          enabled: true,
                          hintText: '',
                          obscureText: false,
                          prefixIcon: Icons.location_on_outlined,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Padding(
                            padding: EdgeInsets.only(right: 200.0),
                            child: MyLabel(labelContent: 'Password')),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          controller: _password,
                          enabled: true,
                          hintText: '',
                          obscureText: true,
                          prefixIcon: Icons.password,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(right: 260.0),
                            child: MyLabel(labelContent: 'Adresse email')),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                          controller: _email,
                          enabled: true,
                          hintText: '',
                          obscureText: false,
                          prefixIcon: Icons.email_outlined,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              MyButtons(
                  onPressed: () {
                    String fullName = _fullName.text;
                    String email = _email.text;
                    String address = _address.text;
                    String password = _password.text;
                    String phoneNumber = _phoneNumber.text;

                    User newUser = User(
                        fullName: fullName,
                        email: email,
                        address: address,
                        password: password,
                        phoneNumber: phoneNumber,
                        userStatus: 'NON AUTORISE');

                    UsersController().addUser(newUser, context);
                    _address.clear();
                    _email.clear();
                    _password.clear();
                    _fullName.clear();
                    _password.clear();
                  },
                  text: 'Ajouter')
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      body: desktopBody(),
    );
  }
}
