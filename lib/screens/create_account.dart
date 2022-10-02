import 'package:board_game_dreamer/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  static const String pageName = "Create Account";
  final String title = "$pageName -  ${MyApp.appName}";

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String? _username = "";
  String? _password = "";
  String? _checkPassword = "";
  final _formKey = GlobalKey<FormState>();

  void _validateCreateAccount() {
    _formKey.currentState?.save();
    if (_username != "" && _password != "" && _password == _checkPassword) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _username,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your username(email)',
                      ),
                      onSaved: (String? value) {
                        _username = value;
                      },
                    ),
                    TextFormField(
                      initialValue: _password,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                      onSaved: (String? value) {
                        _password = value;
                      },
                    ),
                    TextFormField(
                      initialValue: _checkPassword,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Re-enter your password',
                      ),
                      onSaved: (String? value) {
                        _checkPassword = value;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: _validateCreateAccount,
                      child: const Text('Create Account'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
