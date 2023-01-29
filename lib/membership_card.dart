// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rsa_app/Gallery.dart';
import 'package:rsa_app/api/api_service.dart';
import 'package:rsa_app/choose_membership.dart';
import 'package:rsa_app/diets_plan.dart';
import 'package:rsa_app/invoice.dart';
import 'package:rsa_app/memberships_renewal.dart';
import 'dart:io';
import 'package:rsa_app/thankyou.dart';
import 'package:rsa_app/workout_plan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'franchise.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rsa_app/barcodescanner.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rsa_app/qrcode.dart';

_launchURLBrowser() async {
  var url = Uri.parse(
      "https://app.ramagyasportsacademy.com/api/user-invoice/eyJpdiI6ImRYekNPdU5GSHoyaTcrTkNmYmJ6bGc9PSIsInZhbHVlIjoieTlQT3BJQUJtV09KUUdZdE9ZMFFLS2ZtaHVtdDRONVZieDVkVXpQUVJLbz0iLCJtYWMiOiI5NjFlZmJiOGM3ZjFlZjE3ODRlYjI4Njk3ZmVkODM0YTFmNGM4NWNlOTM5OTNhZjVhNmQ5ZmJlNWQ3NGNiNmY2IiwidGFnIjoiIn0=?signature=363e56cb5e8d92b9b898a7d79c0732b235e917a972783b135d8b69ad529d594c");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURLApp() async {
  var url = Uri.parse(
      "https://app.ramagyasportsacademy.com/api/user-invoice/eyJpdiI6ImRYekNPdU5GSHoyaTcrTkNmYmJ6bGc9PSIsInZhbHVlIjoieTlQT3BJQUJtV09KUUdZdE9ZMFFLS2ZtaHVtdDRONVZieDVkVXpQUVJLbz0iLCJtYWMiOiI5NjFlZmJiOGM3ZjFlZjE3ODRlYjI4Njk3ZmVkODM0YTFmNGM4NWNlOTM5OTNhZjVhNmQ5ZmJlNWQ3NGNiNmY2IiwidGFnIjoiIn0=?signature=363e56cb5e8d92b9b898a7d79c0732b235e917a972783b135d8b69ad529d594c");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class MembershipCard extends StatefulWidget {
  final user_membership_id,
      membership_id,
      duration,
      membership_name,
      session,
      startdate,
      endtdate,
      status,
      session_used,
      personal;
  MembershipCard(
      this.user_membership_id,
      this.membership_id,
      this.duration,
      this.membership_name,
      this.session,
      this.startdate,
      this.endtdate,
      this.status,
      this.session_used,
      this.personal);

  @override
  State<MembershipCard> createState() => _MembershipCardState();
}

class _MembershipCardState extends State<MembershipCard> {
  List<dynamic> _memberships = [];

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  var user_membership_id;
  var membership_id;

  @override
  void initState() {
    super.initState();
    print("${widget.user_membership_id}");
    print("${widget.membership_id}");
    print("${widget.duration}");
    print("${widget.membership_name}");
    print("${widget.session}");
    print("${widget.startdate}");
    print("${widget.endtdate}");
    print("${widget.status}");
    print("${widget.session_used}");

    print('_membershipCardData1');
    MembershipCard(
        widget.user_membership_id,
        widget.membership_id,
        widget.duration,
        widget.membership_name,
        widget.session,
        widget.startdate,
        widget.endtdate,
        widget.status,
        widget.session_used,
        widget.personal);
    print("personal.widget" + widget.personal);
    _userInfo();
    _invoicedata(widget.user_membership_id);
    print("obptscanQRject");
    ptscanQR(widget.membership_id);

    var statusResult = widget.status;

    print("statusResult$statusResult");

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);
        });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.white,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = true;
  var data = [];
  _userInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiService.memberships(pref.getInt("user_id"), pref.getString("token"))
        .then((value) {
      data = value["data"];
      setState(() {
        print(data.length);
        isLoading = false;
      });
    });
  }

  String dval = "";
  _invoicedata(user_membership_id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("user_membership_id${pref.getInt("user_membership_id")}");
    print("membership_id_print${pref.getInt("membership_id")}");
    // print("user_membership_id");
    print(pref.getInt("user_membership_id"));
    ApiService.invoice(user_membership_id, pref.getInt("user_id"),
            pref.getInt("user_membership_id"), pref.getString("token"))
        .then((value) {
      setState(() {
        dval = value["data"];

        print("invoice111111$dval");
        isLoading = false;
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = dval;
      //final url = "https://pdfkit.org/docs/guide.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);

      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  // String Qrcode = "";
  // ptscanQR(user_membership_id) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   print("user_membership_id${pref.getInt("user_membership_id")}");
  //   print("membership_id_print${pref.getInt("membership_id")}");
  //   // print("user_membership_id");
  //   print(pref.getInt("user_membership_id"));
  //   ApiService.PtQrCode(user_membership_id, pref.getInt("user_id"),
  //           pref.getInt("user_membership_id"), pref.getString("token"))
  //       .then((value) {
  //     Qrcode = value["data"];
  //     if (value['success']) {
  //       print("valuemessageALL");
  //       return showDialog(
  //           context: context,
  //           builder: (context) {
  //             Future.delayed(Duration(seconds: 3), () {
  //               Navigator.of(context).pop();
  //             });
  //             return AlertDialog(
  //               backgroundColor: Color(0xffffffff),
  //               content: Text(
  //                 "${value["message"]}",
  //                 style: GoogleFonts.roboto(
  //                     color: Color(0xff314545), fontSize: 13),
  //               ),
  //             );
  //           });
  //     }
  //     setState(() {
  //       Qrcode = value["data"];
  //     });
  //   });
  // }
  var qRdata;
  Future<void> ptscanQR(membership_id) async {
    setState(() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      print("user_membership_idQR${pref.getInt("user_membership_id")}");
      print("membership_idQR${pref.getInt("membership_id")}");
      ApiService.PtQrCode(
              membership_id, pref.getInt("user_id"), pref.getString("token"))
          .then((value) {
        qRdata = value['data'];

        print("ALLqRdata$qRdata");
        print("qrcodedataupload5");

        print("${value["success"]}");
        var qrCodeImage = qRdata;
        print("qrCodeImageALLqRdata$qrCodeImage");

        // if (value['success']) {
        //   print("valuemessageALL");
        //   return showDialog(
        //       context: context,
        //       builder: (context) {
        //         Future.delayed(Duration(seconds: 3), () {
        //           Navigator.of(context).pop();
        //         });
        //         return AlertDialog(
        //           backgroundColor: Color(0xffffffff),
        //           content: Text(
        //             "${value["message"]}",
        //             style: GoogleFonts.roboto(
        //                 color: Color(0xff314545), fontSize: 13),
        //           ),
        //         );
        //       });
        // }
      });
    });
  }

  _launchURLApp() async {
    var url = Uri.parse(qRdata);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff000000)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Choose Membership",
          textAlign: TextAlign.left,
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)],
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 170,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Card(
                        color: const Color(0xff74c2e7),
                        margin: const EdgeInsets.only(
                            left: 40, right: 40, bottom: 0, top: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff34b9ee),
                                  Color(0xff74c2e7),
                                ],
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/icon/rsa_logo_old.png',
                                        fit: BoxFit.fill,
                                      ),
                                      iconSize: 60,
                                      onPressed: () {},
                                    ),
                                    Text(
                                      "${widget.duration} month",
                                      // '${data[i]["duration"]} month',
                                      style: GoogleFonts.roboto(
                                        color: const Color(0xffffffff),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "${widget.membership_name} | ${widget.session} Session",
                                    // '${data[i]["membership_name"]} | ${data[i]["session"]} Session',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xffffffff),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'From: ${DateFormat('d MMM, y').format(DateTime.parse(widget.startdate)).toString()}',
                                        // "From ${widget.startdate}",
                                        // 'From: ${data[i]["startdate"]}',
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xffffffff),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'To: ${DateFormat('d MMM, y').format(DateTime.parse(widget.endtdate)).toString()}',
                                        // "${widget.endtdate}",
                                        // 'To: ${data[i]["endtdate"]}',
                                        style: GoogleFonts.roboto(
                                          color: const Color(0xffffffff),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
              ),
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : widget.status != "expired"
                      ? InkWell(
                          onTap: () {
                            if (widget.status == "Expired") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // title: Text("Diet"),
                                    content:
                                        Text("please renew your membership"),
                                    actions: [
                                      FlatButton(
                                        child: Text("Cancel"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ChooseMemberships()));
                            }
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            width: 340,
                            height: 200,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: widget.status == "Ongoing"
                                  ? const Color(0xff26a96d).withOpacity(0.80)
                                  : widget.status == "Expired"
                                      ? const Color(0xffe27297)
                                      : const Color(0xff26a96d)
                                          .withOpacity(0.80),
                              child: Column(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(top: 15)),
                                  Text(
                                    'Status',
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xffFFFFFF),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${widget.status}",
                                    // 'Ongoing',
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xffFFFFFF),
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Sessions Used: ${widget.session_used}",
                                    // 'Sessions Used: 0/12',
                                    style: GoogleFonts.roboto(
                                      color: const Color(0xffFFFFFF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          isLoading
                                              ? CircularProgressIndicator()
                                              : widget.personal == "1" &&
                                                      widget.status != "Expired"
                                                  ? ButtonTheme(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                      minWidth: 350.0,
                                                      child: OutlinedButton(
                                                          onPressed:
                                                              _launchURLApp,

                                                          // () =>
                                                          //     showDialog<
                                                          //         String>(
                                                          //       context:
                                                          //           context,
                                                          //       builder:
                                                          //           (BuildContextcontext) =>
                                                          //               AlertDialog(
                                                          //         content:
                                                          //             Column(
                                                          //           children: [
                                                          //             Image.network(
                                                          //                 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                                                          //             Text(
                                                          //                 'AlertDialog description'),
                                                          //           ],
                                                          //         ),
                                                          //       ),
                                                          //     ),

                                                          // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
                                                          // {
                                                          // const Image(
                                                          //   image: NetworkImage(
                                                          //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                                                          // );

                                                          child: Text(
                                                            "Personal Traning",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              color: const Color(
                                                                  0xffFFFFFF),
                                                            ),
                                                          )),
                                                    )
                                                  : Container(),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (widget.status == "Expired") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Plan"),
                                content: Text("please renew your membership"),
                                actions: [
                                  FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      WorkoutPlan(widget.user_membership_id)));
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: Card(
                          color: const Color(0xff99D7FE),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child:
                                    Image.asset('assets/images/personal.png'),
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Plan",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xff314545),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChooseMemberships()));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: Card(
                          color: const Color(0xff99D7FE),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Image.asset('assets/images/credit.png'),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Renew",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xff2E4141),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                      onTap: () {
                        if (widget.status == "Expired") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Diet"),
                                content: Text("please renew your membership"),
                                actions: [
                                  FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DietsPlan(widget.user_membership_id)));
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: Card(
                          color: const Color(0xff99D7FE),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Image.asset('assets/images/diet.png'),
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Diet",
                                    style: GoogleFonts.poppins(
                                      color: Color(0xff314545),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        createFileOfPdfUrl().then((f) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      InvoicePage(f.path, dval)));
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: Card(
                          color: const Color(0xff99D7FE),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: Image.asset('assets/images/invoice.png'),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Invoice",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xff2E4141),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
