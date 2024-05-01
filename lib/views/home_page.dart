import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter_sync/views/login_page.dart';
import '../state/user_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome! User: ${userProvider.token}'),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
            }, child: Text("Log out"))
          ],
        ),
      ),
    );
  }
}
