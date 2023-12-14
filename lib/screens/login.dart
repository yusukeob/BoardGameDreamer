import 'package:board_game_dreamer/screens/create_account.dart';
import 'package:board_game_dreamer/screens/projects.dart';
import 'package:flutter/material.dart';
import 'package:board_game_dreamer/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String pageName = "Login";
  final String title = "$pageName -  ${MyApp.appName}";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _username = "yob";
  String? _password = "yob";
  final _formKey = GlobalKey<FormState>();

  void _validateLogin() {
    _formKey.currentState?.save();
    if (_username == "yob" && _password == "yob") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProjectsPage(),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateAccountPage(),
            ),
          );
        },
        label: const Text('Create Account'),
        icon: const Icon(Icons.add_outlined),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                        labelText: 'Enter your username',
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
                      onPressed: _validateLogin,
                      child: const Text('Login'),
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
