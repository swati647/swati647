import 'package:flutter/material.dart';
import 'dart:io';

import 'package:rsa_app/thankyou.dart';

import 'careerpoint.dart';
import 'franchise.dart';

class Franchise extends StatefulWidget {
  const Franchise({Key? key}) : super(key: key);

  @override
  State<Franchise> createState() => _FranchiseState();
}

class _FranchiseState extends State<Franchise> {
 List<String> _stats = ["Uttar Pradesh", "Bihar", "Assam", "Arunachal Pradesh"];

  String? _selectedColor;

  final sugars = [
    'Select Metal',
    'Gold',
    'Silver',
  ];
  String _currentSugars = 'Select Metal';

 String dropdownvalue = 'Item 1';  
 
  @override
  Widget build(BuildContext context) {
    var _addInvestment;
    var size;
    return Scaffold( 
      resizeToAvoidBottomInset:false,  
      body: Container(
        margin: const EdgeInsets.only(top: 20),
           decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff252424), Color(0xff203e3c)],
        )),
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
                         color: Colors.white.withOpacity(1),
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
                          'Become a Franchise',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                  const Spacer(),
                
                  
                  ],
                )),

         SizedBox(height: 20,),
              Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("Full Name",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              Container(
                 height: 80.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                decoration:InputDecoration(
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                    ),
                       filled: true,
                      fillColor: Color(0xff2e4141),                    
                      hintText: 'Full Name',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                          ),
                ),
                alignment: Alignment.center,
              ),
             
              Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("Email",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              Container(
                 height: 80.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                  decoration:InputDecoration(
                     border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                      ),
                       filled: true,
                      fillColor: const Color(0xff2e4141),                    
                      hintText: 'Email',                      
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold)),
                ),
                alignment: Alignment.center,
              ),

               Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("Mobile Number",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              Container(
                 height: 80.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                decoration:InputDecoration(
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                    ),
                       filled: true,
                      fillColor: Color(0xff2e4141),                    
                      hintText: 'Mobile Number',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                          ),
                ),
                alignment: Alignment.center,
              ),

               Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("Place of interest",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              Container(
                 height: 80.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                decoration:InputDecoration(
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                    ),
                       filled: true,
                      fillColor: Color(0xff2e4141),                    
                      hintText: 'Place of interest',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                          ),
                ),
                alignment: Alignment.center,
              ),


               Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("City/Town",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              Container(
                 height: 80.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                decoration:InputDecoration(
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                    ),
                       filled: true,
                      fillColor: Color(0xff2e4141),                    
                      hintText: 'City/Town',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                          ),
                ),
                alignment: Alignment.center,
              ),


               Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("State",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
                          SizedBox(height: 10,),

//               Container(
//                  padding: EdgeInsets.only(left:20, right: 20),
//                  height: 55.0,
// //  color: Color(0xff2e4141),
//   child: FormField<String>(
//     builder: (FormFieldState<String> state) {
//         Color: Color(0xff2e4141);
//       var currentSelectedValue;
//       var deviceTypes;
//       return InputDecorator(
//         decoration: InputDecoration(
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5.0)),
//                 ),
//      child: DropdownButton<String>(
//             onChanged: (value) {
//               setState(() {
//                 _selectedColor = value;
//               });
//             },
//             value: _selectedColor,
//             underline: Container(),
//             hint: Container(
//                 child: Text(
//               'Select State',
//               style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
//             )),
//             icon: Icon(
//               Icons.keyboard_arrow_down,
//               color: Colors.white,
//             ),
            
//             isExpanded: true,
//             items: _stats
//                 .map((e) => DropdownMenuItem(
//                       child: Container(
//                         alignment: Alignment.topLeft,
//                         child: Text(
//                           e,
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                       value: e,
//                     ))
//                 .toList(),
//                 // Customize the selected item
//             selectedItemBuilder: (BuildContext context) => _stats
                
//                      .map((e) =>  Text(
//                         e,
//                         style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.white,
//                             // fontStyle: FontStyle.italic,
//                             fontWeight: FontWeight.w300),
//                       ),
//                     )
//                 .toList(),
//           ),
//       );
//     },
//   ),
// ),
Container(
   padding: EdgeInsets.only(left:20, right: 20),
                        // width: size.width * 0.8,
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Color(0xff2e4141),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            filled: true,
                            fillColor: Color(0xff2e4141),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:Color(0xff2e4141),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:Color(0xff2e4141),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                            ),
                          ),
                          value: _currentSugars,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == 'Select State') {
                              return 'Please Select State';
                            }
                            return null;
                          },
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          items: sugars.map((sugar) {
                            return DropdownMenuItem(
                              value: sugar,
                              child: Text(
                                '$sugar',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode()),
                                _currentSugars = val!,
                                if (val.toString() == "Gold")
                                  {
                                    _addInvestment.scrip = "Gold",
                                    _addInvestment.symbol = "GC=F",
                                    getPriceAccordingDateCommodity(
                                        _addInvestment.symbol,
                                        _addInvestment.invesDate)
                                  }
                                else
                                  {
                                    _addInvestment.scrip = "Gold",
                                    _addInvestment.symbol = "SI=F",
                                    getPriceAccordingDateCommodity(
                                        _addInvestment.symbol,
                                        _addInvestment.invesDate)
                                  }
                              }),
                        ),
                      ),

SizedBox(height: 20,),

               Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("Background",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
                          SizedBox(height: 10,),
                         Container(
   padding: EdgeInsets.only(left:20, right: 20),
                        // width: size.width * 0.8,
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Color(0xff2e4141),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            filled: true,
                            fillColor: Color(0xff2e4141),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:Color(0xff2e4141),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                              color:Color(0xff2e4141),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                            ),
                          ),
                          value: _currentSugars,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == 'Service/Job') {
                              return 'Please Service/Job';
                            }
                            return null;
                          },
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          items: sugars.map((sugar) {
                            return DropdownMenuItem(
                              value: sugar,
                              child: Text(
                                '$sugar',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode()),
                                _currentSugars = val!,
                                if (val.toString() == "Gold")
                                  {
                                    _addInvestment.scrip = "Gold",
                                    _addInvestment.symbol = "GC=F",
                                    getPriceAccordingDateCommodity(
                                        _addInvestment.symbol,
                                        _addInvestment.invesDate)
                                  }
                                else
                                  {
                                    _addInvestment.scrip = "Gold",
                                    _addInvestment.symbol = "SI=F",
                                    getPriceAccordingDateCommodity(
                                        _addInvestment.symbol,
                                        _addInvestment.invesDate)
                                  }
                              }),
                        ),
                      ),
SizedBox(height: 10,),
                            Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("Minimum Investment",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
                             Container(
                 height: 80.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                decoration:InputDecoration(
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                    ),
                       filled: true,
                      fillColor: Color(0xff2e4141),                    
                      hintText: 'Minimum Investment',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                          ),
                ),
                alignment: Alignment.center,
              ),

              Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("Maximum Investment",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
               Container(
                 height: 80.0,
                padding:
                    const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
                child: TextFormField(               
                decoration:InputDecoration(
                border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none,
                    ),
                       filled: true,
                      fillColor: Color(0xff2e4141),                    
                      hintText: 'Maximum Investment',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                          ),
                ),
                alignment: Alignment.center,
              ),
                          
      Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text("How did you hear about us?",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
             SizedBox(height: 10,),
              Container(
   padding: EdgeInsets.only(left:20, right: 20),
                        // width: size.width * 0.8,
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Color(0xff2e4141),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            filled: true,
                            fillColor: Color(0xff2e4141),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:Color(0xff2e4141),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:Color(0xff2e4141),
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                            ),
                          ),
                          value: _currentSugars,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == 'Google ad') {
                              return 'Please Google ad';
                            }
                            return null;
                          },
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          items: sugars.map((sugar) {
                            return DropdownMenuItem(
                              value: sugar,
                              child: Text(
                                '$sugar',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode()),
                                _currentSugars = val!,
                                if (val.toString() == "Gold")
                                  {
                                    _addInvestment.scrip = "Gold",
                                    _addInvestment.symbol = "GC=F",
                                    getPriceAccordingDateCommodity(
                                        _addInvestment.symbol,
                                        _addInvestment.invesDate)
                                  }
                                else
                                  {
                                    _addInvestment.scrip = "Gold",
                                    _addInvestment.symbol = "SI=F",
                                    getPriceAccordingDateCommodity(
                                        _addInvestment.symbol,
                                        _addInvestment.invesDate)
                                  }
                              }),
                        ),
                      ),
SizedBox(height: 10,),

              ButtonTheme(
  minWidth: 300.0,
  height: 50.0,
  child: RaisedButton(
       onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                           builder: (BuildContext context) => CareerPoint()));
                 },
      color: Color(0xff324444),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
      child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
  ),
),
              
   SizedBox(height: 10,) ,          
            ],
          ),
          ),
      ),
    );
  }
  
  getPriceAccordingDateCommodity(symbol, invesDate) {}

}

class Provinces {
}