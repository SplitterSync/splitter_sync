import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter_sync/models/user_model.dart';
import 'package:splitter_sync/services/authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitter_sync/views/home/home_page.dart';
import 'package:splitter_sync/views/register_page.dart';
import '../state/user_provider.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 120.0, bottom: 20.0),
                child: Center(
                    child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.asset('lib/assets/logo.png'),
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Enter your email",
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.lock),
                    labelText: "Password",
                    hintText: "Enter valid password",
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              MaterialButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: MaterialButton(
                  onPressed: _login,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegisterPage()));
                },
                child: const Text(
                  'New here? Register',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await ApiService.login(
            _emailController.text, _passwordController.text);

        if (!mounted) return; // Check if the widget is still in the tree

        if (response['token'] != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', response['token']);

          Provider.of<UserProvider>(context, listen: false).setUser(UserModel(
              name: 'User', // Assuming you don't have the user's name here; adjust as necessary
              email: _emailController.text,
              token: response['token']));

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        } else {
          throw Exception(response["message"]);
        }
      } catch (e) {
        if (!mounted) return; // Again, check if the widget is still in the tree

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red,
            )
        );
      }
    }
  }

}
