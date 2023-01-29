import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:event/event.dart';
import '../utils.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(TableEventsExample()));
}

class TableEventsExample extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          // color: Color(0xff261D1D),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)],
          )),
          child: SafeArea(
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 20),
              lastDay: DateTime.utc(2040, 10, 20),
              focusedDay: DateTime.now(),
              headerVisible: true,
              daysOfWeekVisible: true,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color(0xff2D2D2D).withOpacity(0.70),
                  height: 1.3333333333333333,
                ),
                weekendStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: const Color(0xff2D2D2D),
                  height: 1.3333333333333333,
                ),
              ),
              sixWeekMonthsEnforced: true,
              shouldFillViewport: false,
              headerStyle: HeaderStyle(
                headerPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                titleTextStyle: GoogleFonts.roboto(
                    fontSize: 18,
                    color: const Color(0xff0D83C6),
                    fontWeight: FontWeight.w400),
                leftChevronIcon: const Icon(
                  Icons.chevron_left,
                  color: Color(0xff000000),
                  size: 50,
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  color: Color(0xff000000),
                  size: 50,
                ),
                leftChevronVisible: true,
                rightChevronVisible: true,
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                todayTextStyle: GoogleFonts.roboto(
                    // decorationColor: Color(0xffC7DFBC),
                    fontSize: 20,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.bold),
                defaultTextStyle:
                    GoogleFonts.roboto(color: const Color(0xff2D2D2D)),
                weekendTextStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: const Color(0xff2D2D2D),
                  height: 1.3333333333333333,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
//     show CalendarCarousel;
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:intl/intl.dart' show DateFormat;

// class MyHomePage extends StatefulWidget {
//   MyHomePage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   //  firstDay: DateTime.utc(2010, 10, 20),
//   //             lastDay: DateTime.utc(2040, 10, 20),
//   //            focusedDay: DateTime.now(),
//   DateTime _currentDate = DateTime.utc(2010, 10, 20);
//   DateTime _currentDate2 = DateTime.utc(2010, 10, 20);
//   String _currentMonth = DateFormat.yMMM().format(DateTime.utc(2010, 10, 20));
//   DateTime _targetDateTime = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     final _calendarCarouselNoHeader = CalendarCarousel<Event>(
//       showHeader: false,
//       onDayPressed: (date, events) {
//         this.setState(() => _currentDate2 = date);
//         events.forEach((event) => print(event.title));
//       },
//       daysHaveCircularBorder: true,
//       showOnlyCurrentMonthDate: false,
//       thisMonthDayBorderColor: Colors.grey,
//       weekFormat: false,
//       height: 420.0,
//       selectedDateTime: _currentDate2,
//       targetDateTime: _targetDateTime,
//       customGridViewPhysics: NeverScrollableScrollPhysics(),
//       onCalendarChanged: (DateTime date) {
//         this.setState(() {
//           _targetDateTime = date;
//           _currentMonth = DateFormat.yMMM().format(_targetDateTime);
//         });
//       },
//       onDayLongPressed: (DateTime date) {
//         print('long pressed date $date');
//       },
//     );
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               margin: const EdgeInsets.only(
//                 top: 30.0,
//                 bottom: 16.0,
//                 left: 16.0,
//                 right: 16.0,
//               ),
//               child: new Row(
//                 children: <Widget>[
//                   Expanded(
//                       child: Text(
//                     _currentMonth,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24.0,
//                     ),
//                   )),
//                   FlatButton(
//                     child: Text('PREV'),
//                     onPressed: () {
//                       setState(() {
//                         _targetDateTime = DateTime(
//                             _targetDateTime.year, _targetDateTime.month - 1);
//                         _currentMonth =
//                             DateFormat.yMMM().format(_targetDateTime);
//                       });
//                     },
//                   ),
//                   FlatButton(
//                     child: Text('NEXT'),
//                     onPressed: () {
//                       setState(() {
//                         _targetDateTime = DateTime(
//                             _targetDateTime.year, _targetDateTime.month + 1);
//                         _currentMonth =
//                             DateFormat.yMMM().format(_targetDateTime);
//                       });
//                     },
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 16.0),
//               child: _calendarCarouselNoHeader,
//             ), //
//           ],
//         ),
//       ),
//     );
//   }
// }
