import 'package:flutter/material.dart';
import 'dart:io';

import 'package:rsa_app/thankyou.dart';

import 'careerpoint.dart';
import 'franchise.dart';

class ShoppingBag extends StatefulWidget {
  const ShoppingBag({Key? key}) : super(key: key);

  @override
  State<ShoppingBag> createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      resizeToAvoidBottomInset:false,  
      body: Container(
        margin: const EdgeInsets.only(top: 20),
           decoration: const BoxDecoration(
     
         color: Color(0xffffffff),
        ),
        child: SingleChildScrollView(
            child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
               child: 
                Row(
                  children: [
                      IconButton(
                       icon: Icon(
                         Icons.arrow_back_rounded,
                         color: Colors.black.withOpacity(1),
                         size: 25,
                       ),
                        onPressed: () {
                   Navigator.of(context).pop();
              },
                       ),
                    Container(
                      margin: EdgeInsets.only(left:80),
                           alignment: Alignment.topCenter,
                      child: const Text(
                          'Shopping Bag ( 1 )',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                  const Spacer(),  
                  ],
                )),
         SizedBox(height: 20,),

             Container(
                   padding: EdgeInsets.only(left: 10.0, right: 10),
                      width: 390,
                      height: 170,
                       child: Card(
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.grey),
                        ),
                        color: Color(0xffffffff),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset('assets/images/shopping.png'),
                                        ),
                                       Container( 
                                         padding: EdgeInsets.only(left: 5.0,bottom: 40),
                                         child:const Text(
                                          'Revit Architecture 2021 Course-Practical\nApproach',
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 11.5,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),),
                                        Container(
                                          padding: EdgeInsets.only(bottom: 50),
                                          child: IconButton(
                                            onPressed: (){}, 
                                            icon: Icon(Icons.delete),
                                            iconSize: 24.0,
                                            color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: const Text(
                                          'Quantity: 1',
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 15,
                                          ),
                                        ),),
                                       
                                        Container(
                                          padding: EdgeInsets.only(left: 180),
                                          child: const Text(
                                          '\u{20B9} 1000',
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 15,
                                          ),
                                        ),),
                                        
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

               SizedBox(height: 20),
                Container(
                       alignment: Alignment.topLeft,
                  
                    padding: EdgeInsets.only(left: 20.0),
                    child: const Text(
                      'Payment Details',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                   SizedBox(height: 10),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),

                   SizedBox(height: 20),
                   Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: const Text(
                          'Subtotal:',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 13,
                          ),
                        ),),
                        
                        Container(
                          padding: EdgeInsets.only(left: 240),
                          child: const Text(
                          '\u{20B9} 1000',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 15,
                          ),
                        ),),
                        
                      ],
                    ),
                     SizedBox(height: 20),
                        Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: const Text(
                          'Grand Total:',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 13,
                          ),
                        ),),
                        
                        Container(
                          padding: EdgeInsets.only(left: 220),
                          child: const Text(
                          '\u{20B9} 1000',
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 15,
                          ),
                        ),),
                        
                      ],
                    ),
                    SizedBox(height: 40,),

              ButtonTheme(
  minWidth: 330.0,
  height: 50.0,
  child: RaisedButton(
       onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                           builder: (BuildContext context) => CareerPoint()));
                 },
      color: Color(0xff267693),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
      child: const Text(
                  "Enter Coupon Code",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xffffffff),
                  ),
                ),
  ),
),

 SizedBox(height: 15),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),

                       SizedBox(height:5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Column(children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 30),
                                          child: const Text(
                                          'Grand Total:',
                                          style: TextStyle(
                                            color: Color(0xff343434),
                                            fontSize: 13,
                                          ),
                                        ),
                                       
                                      ),
                                        Container(
                                       padding: EdgeInsets.only(left: 5),
                                          child: const Text(
                                          '\u{20B9} 1000',
                                          style: TextStyle(
                                            color: Color(0xff20C997),fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                    ),
                                    ],),
                                  Container(
                                          padding: EdgeInsets.only(right: 30),
                                          width: 150,
                                                 height: 30.0,
                                                  child: RaisedButton(  onPressed: () {
                                                                  //  Navigator.push(
                                                                  //     context,
                                                                  //     MaterialPageRoute(
                                                                  //          builder: (BuildContext context) => LetTalk()));
                                                                },
                                                      color: Color(0xff20C997),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(5)),
                                                      child: const Text(
                                                                  "Proceed \>",
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 15,
                                                                    color: Color(0xffffffff),
                                                                  ),
                                                                ),
                                                  ),  
                                        ),
                          
                                    ],
                                  ),
            ],
          ),
          ),
      ),
    );
  }

}