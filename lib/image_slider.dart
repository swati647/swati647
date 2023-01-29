// // Copyright 2017, the Flutter project authors.  Please see the AUTHORS file
// // for details. All rights reserved. Use of this source code is governed by a
// // BSD-style license that can be found in the LICENSE file.

// import 'dart:math';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(new MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       home: new MyHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// /// An indicator showing the currently selected page of a PageController
// class DotsIndicator extends AnimatedWidget {
//   DotsIndicator({
//     required this.controller,
//     required this.itemCount,
//     required this.onPageSelected,
//     this.color: Colors.white,
//   }) : super(listenable: controller);

//   /// The PageController that this DotsIndicator is representing.
//   final PageController controller;

//   /// The number of items managed by the PageController
//   final int itemCount;

//   /// Called when a dot is tapped
//   final ValueChanged<int> onPageSelected;

//   /// The color of the dots.
//   ///
//   /// Defaults to `Colors.white`.
//   final Color color;

//   // The base size of the dots
//   static const double _kDotSize = 8.0;

//   // The increase in the size of the selected dot
//   static const double _kMaxZoom = 2.0;

//   // The distance between the center of each dot
//   static const double _kDotSpacing = 25.0;

//   Widget _buildDot(int index) {
//     double selectedness = Curves.easeOut.transform(
//       max(
//         0.0,
//         1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
//       ),
//     );
//     double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
//     return new Container(
//       width: _kDotSpacing,
//       child: new Center(
//         child: new Material(
//           color: color,
//           type: MaterialType.circle,
//           child: new Container(
//             width: _kDotSize * zoom,
//             height: _kDotSize * zoom,
//             child: new InkWell(
//               onTap: () => onPageSelected(index),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget build(BuildContext context) {
//     return new Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: new List<Widget>.generate(itemCount, _buildDot),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State createState() => new MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {

//   final _controller = new PageController();

//   static const _kDuration = const Duration(milliseconds: 300);

//   static const _kCurve = Curves.ease;

//   final _kArrowColor = Colors.black.withOpacity(0.8);

//   final List<Widget> _pages = <Widget>[
//     new ConstrainedBox(
//       constraints: const BoxConstraints.expand(),
//         child:Container(
//           // width: MediaQuery.of(context).size.width,
//           margin: EdgeInsets.symmetric(horizontal: 5.0),
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                                   image:
//                                       AssetImage("assets/images/rectangle.png"),
//                                   fit: BoxFit.cover),
//           ),
//           // child: Text('text $i', style: TextStyle(fontSize: 16.0),)
//         ),
//     ),
//     new ConstrainedBox(
//       constraints: const BoxConstraints.expand(),
//       child:Container(
//           // width: MediaQuery.of(context).size.width,
//           margin: EdgeInsets.symmetric(horizontal: 5.0),
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                                   image:
//                                       AssetImage("assets/images/rectangle.png"),
//                                   fit: BoxFit.cover),
//           ),
//           // child: Text('text $i', style: TextStyle(fontSize: 16.0),)
//         )),
//     new ConstrainedBox(
//       constraints: const BoxConstraints.expand(),
//        child:Container(
//           // width: MediaQuery.of(context).size.width,
//           margin: EdgeInsets.symmetric(horizontal: 5.0),
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                                   image:
//                                       AssetImage("assets/images/rectangle.png"),
//                                   fit: BoxFit.cover),
//           ),
//           // child: Text('text $i', style: TextStyle(fontSize: 16.0),)
//         )),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: new IconTheme(
//         data: new IconThemeData(color: _kArrowColor),
//         child: new Stack(
//           children: <Widget>[
//             new PageView.builder(
//               physics: new AlwaysScrollableScrollPhysics(),
//               controller: _controller,
//               itemBuilder: (BuildContext context, int index) {
//                 return _pages[index % _pages.length];
//               },
//             ),
//             new Positioned(
//               bottom: 0.0,
//               left: 0.0,
//               right: 0.0,
//               child: new Container(
//                 // color: Colors.grey[800].withOpacity(0.5),
//                 padding: const EdgeInsets.all(20.0),
//                 child: new Center(
//                   child: new DotsIndicator(
//                     controller: _controller,
//                     itemCount: _pages.length,
//                     onPageSelected: (int page) {
//                       _controller.animateToPage(
//                         page,
//                         duration: _kDuration,
//                         curve: _kCurve,
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
 
class CustomIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomIndicatorState();
  }
}
 
class CustomIndicatorState extends State<CustomIndicator> {

 int currentPos = 0;
  List<String> listPaths = [
   
    'https://cdn.pixabay.com/photo/2020/11/01/23/22/breakfast-5705180_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/18/19/00/breads-1836411_1280.jpg',
    'https://cdn.pixabay.com/photo/2019/01/14/17/25/gelato-3932596_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/04/04/18/07/ice-cream-2202561_1280.jpg',
    'https://cdn.pixabay.com/photo/2019/01/14/17/25/gelato-3932596_1280.jpg'
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              itemCount: listPaths.length,
              options: CarouselOptions(
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPos = index;
                    });
                  }
              ),
              itemBuilder: (BuildContext context, int Index, int pageViewIndex){
                return MyImageView(listPaths[Index]);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listPaths.map((url) {
                int index = listPaths.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPos == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ]
        )
      ),
    );
  }
}
 
class MyImageView extends StatelessWidget{
 
  String imgPath;
 
  MyImageView(this.imgPath);
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(imgPath),
        )
    );
  }
 
}