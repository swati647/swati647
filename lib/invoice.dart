// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class InvoicePage extends StatefulWidget {
  InvoicePage(this.filepath, this.dval);

  late final String filepath;
  late final String dval;

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool loading = true;
  String last = '';

  String url = "";
  String remotePDFpath = "";

  var Download;

  @override
  void initState() {
    super.initState();
    print("dvalurl3");
    print(widget.filepath);
    url = widget.filepath;

    remotePDFpath = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Invoice",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
          ),
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color(0xffFFFFFF),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  FileDownloader.downloadFile(
                      url: widget.dval,
                      name: "invoice",
                      onDownloadCompleted: (path) {
                        //final File file = File(path);
                        //This will be the path of the downloaded file
                      });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'invoice download successfully',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.download_rounded),
                color: const Color(0xff000000)),
          ],
        ),
        body: SafeArea(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: loading
              ?
              //  WebView(
              //     initialUrl:
              //         ('https://docs.google.com/gview?embedded=true&url=$url'),
              //     javascriptMode: JavascriptMode.unrestricted,
              //   )
              // : SpinKitCircle(),
              PDFView(
                  filePath: remotePDFpath,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  onRender: (_pages) {},
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print('pdfprint$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    //_controller.complete(pdfViewController);
                  })
              : SpinKitCircle(),
        )));
  }

  Future<File> createFileOfPdfUrl(String remotePDFpath) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url = remotePDFpath;

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
      if (!await file.exists()) {
        await file.create(recursive: true);
      }
      if (await file.exists()) {
        var saveFile;
        await Dio().download(
          url,
          saveFile.path,
        );
      }
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  handleLoad() {
    loading = false;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _shareUrl(String url) async {
    await Share.share(url);
  }
}

SpinKitCircle() {}
