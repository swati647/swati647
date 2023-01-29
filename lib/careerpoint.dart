import 'package:flutter/material.dart';
import 'package:rsa_app/Gallery.dart';
import 'dart:io';

import 'package:rsa_app/thankyou.dart';

import 'franchise.dart';

class CareerPoint extends StatefulWidget {
  const CareerPoint({Key? key}) : super(key: key);

  @override
  State<CareerPoint> createState() => _CareerPointState();
}

class _CareerPointState extends State<CareerPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset:false,
      appBar: AppBar(
        title: const Text("Career Point"),
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff252424), Color(0xff203e3c)],
            ),
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff252424), Color(0xff203e3c)],
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   margin: EdgeInsets.only(top: 20),
              //  child:
              //   Row(
              //     children: [
              //         IconButton(
              //          icon: Icon(
              //            Icons.arrow_back_rounded,
              //            color: Colors.white.withOpacity(1),
              //            size: 25,
              //          ),
              //           onPressed: () {
              //      Navigator.of(context).pop();
              // },
              //          ),
              //       Container(
              //         margin: EdgeInsets.only(left:80),
              //              alignment: Alignment.topCenter,
              //         child: const Text(
              //             'Career Point',
              //             style: TextStyle(fontSize: 18, color: Colors.white),
              //           ),
              //         ),
              //     const Spacer(),
              //     ],
              //   )),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                //  padding: EdgeInsets.only(left: 10.0, right: 10),
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.26,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: const Color(0xffC7DFBC),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //         builder: (BuildContext context) => Gallery()));
                                    },
                                    child: Container(
                                      child: const Text(
                                        'Sports Director  \nRamagya Sports Academy',
                                        style: TextStyle(
                                          color: Color(0xff223231),
                                          fontSize: 15,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 85,
                                    ),
                                    child: Image.asset(
                                        'assets/images/ramagyalogo.png'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset('assets/images/age.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: const Text(
                                      '10-15 Yrs',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset('assets/images/map.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: const Text(
                                      'Noida NCR',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: const Text(
                                  'phD/M.Phil',
                                  style: TextStyle(
                                    color: Color(0xff223231),
                                    fontSize: 15,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        color: Color(0xff223231),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Image.asset(
                                                  'assets/images/duration.png'),
                                            ),
                                            Container(
                                              // padding: EdgeInsets.only(left: 10),
                                              // minWidth: 20.0,
                                              height: 25.0,

                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  primary: Colors.white,
                                                  textStyle: const TextStyle(
                                                      fontSize: 10),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                onPressed: () {},
                                                child: const Text('2 days ago'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 140)),
                                  Row(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                  'assets/images/star.png'),
                                            ),
                                            Container(
                                              height: 25.0,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  primary: Color(0xff232B2A),
                                                  textStyle: const TextStyle(
                                                      fontSize: 13),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                onPressed: () {},
                                                child: const Text('Save'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10),
                width: 400,
                height: 210,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xffC7DFBC),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: const Text(
                                      'Sports Director  \nRamagya Sports Academy',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 85,
                                    ),
                                    child: Image.asset(
                                        'assets/images/ramagyalogo.png'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset('assets/images/age.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: const Text(
                                      '10-15 Yrs',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset('assets/images/map.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: const Text(
                                      'Noida NCR',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: const Text(
                                  'phD/M.Phil',
                                  style: TextStyle(
                                    color: Color(0xff223231),
                                    fontSize: 15,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        color: Color(0xff223231),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Image.asset(
                                                  'assets/images/duration.png'),
                                            ),
                                            Container(
                                              // padding: EdgeInsets.only(left: 10),
                                              // minWidth: 20.0,
                                              height: 25.0,

                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  primary: Colors.white,
                                                  textStyle: const TextStyle(
                                                      fontSize: 10),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                onPressed: () {},
                                                child: const Text('2 days ago'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 140)),
                                  Row(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                  'assets/images/star.png'),
                                            ),
                                            Container(
                                              height: 25.0,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  primary: Color(0xff232B2A),
                                                  textStyle: const TextStyle(
                                                      fontSize: 13),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                onPressed: () {},
                                                child: const Text('Save'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10),
                width: 400,
                height: 210,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xffC7DFBC),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: const Text(
                                      'Sports Director  \nRamagya Sports Academy',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 85,
                                    ),
                                    child: Image.asset(
                                        'assets/images/ramagyalogo.png'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset('assets/images/age.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: const Text(
                                      '10-15 Yrs',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset('assets/images/map.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: const Text(
                                      'Noida NCR',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: const Text(
                                  'phD/M.Phil',
                                  style: TextStyle(
                                    color: Color(0xff223231),
                                    fontSize: 15,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        color: Color(0xff223231),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Image.asset(
                                                  'assets/images/duration.png'),
                                            ),
                                            Container(
                                              // padding: EdgeInsets.only(left: 10),
                                              // minWidth: 20.0,
                                              height: 25.0,

                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  primary: Colors.white,
                                                  textStyle: const TextStyle(
                                                      fontSize: 10),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                onPressed: () {},
                                                child: const Text('2 days ago'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 140)),
                                  Row(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                  'assets/images/star.png'),
                                            ),
                                            Container(
                                              height: 25.0,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  primary: Color(0xff232B2A),
                                                  textStyle: const TextStyle(
                                                      fontSize: 13),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                onPressed: () {},
                                                child: const Text('Save'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10),
                width: 400,
                height: 210,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xffC7DFBC),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: const Text(
                                      'Sports Director  \nRamagya Sports Academy',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 85,
                                    ),
                                    child: Image.asset(
                                        'assets/images/ramagyalogo.png'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset('assets/images/age.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: const Text(
                                      '10-15 Yrs',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset('assets/images/map.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: const Text(
                                      'Noida NCR',
                                      style: TextStyle(
                                        color: Color(0xff223231),
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: const Text(
                                  'phD/M.Phil',
                                  style: TextStyle(
                                    color: Color(0xff223231),
                                    fontSize: 15,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        color: Color(0xff223231),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Image.asset(
                                                  'assets/images/duration.png'),
                                            ),
                                            Container(
                                              // padding: EdgeInsets.only(left: 10),
                                              // minWidth: 20.0,
                                              height: 25.0,

                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  primary: Colors.white,
                                                  textStyle: const TextStyle(
                                                      fontSize: 10),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                onPressed: () {},
                                                child: const Text('2 days ago'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 140)),
                                  Row(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                  'assets/images/star.png'),
                                            ),
                                            Container(
                                              height: 25.0,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  primary: Color(0xff232B2A),
                                                  textStyle: const TextStyle(
                                                      fontSize: 13),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                onPressed: () {},
                                                child: const Text('Save'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
