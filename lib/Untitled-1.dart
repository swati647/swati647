import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

// import 'package:gofundleaf/screens/profile.dart';
// import 'package:gofundleaf/services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 3, right: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/small.png'),
                  const Text('leaf')
                ],
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: _loading
            ? const CupertinoActivityIndicator()
            : ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                },
              ),
      ),
    );
  }
}
