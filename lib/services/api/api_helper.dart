import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:xml/xml.dart' as xml;

import '../../constants/api_param_const.dart';
import '../../constants/api_param_const.dart';
import '../../constants/middleware.dart';
import '../../constants/shared_preference_const.dart';
import '../../constants/shared_preference_helper.dart';

class ApiHandler {
  MiddleWare middleWare = MiddleWare();
  var soapHeader = {
    'Content-type': 'text/xml',
  };
  requestRestApi(BuildContext context,req) async {
    try {
      var requestSend =await req.send();
      var response = await http.Response.fromStream(requestSend);
      middleWare.showLog('REST Request: Url:${req.url} params${response} request ${req}');
      middleWare.showLog('ApiHandler :: Response :: ${response.body}');

      if (response.statusCode != null && response.statusCode == 200) {
        return response.body;
      } else {
        middleWare.showToastMsg(
            "${middleWare.validString(response.statusCode.toString())} ${middleWare.validString(response.body)}",
            13.00,
            Colors.red,
            Colors.yellow,
            Toast.LENGTH_SHORT);
        return response.body;
      }
    } on SocketException {
      middleWare.showLog('No network connection');
      // if (isForeground) {
      //   if (context != null) {
      //     middleWare.showToastMsg("You are Offline", 13.00, Colors.red,
      //         Colors.yellow, Toast.LENGTH_SHORT);
      //     //showOfflineSnackBar(context);
      //   }
      // }
    }
  }

  getXmlFromMap(String methodName, Map<String, dynamic> map) {
    final builder = xml.XmlBuilder();
    builder.element('Envelope', nest: () {
      builder.attribute('xmlns', "http://schemas.xmlsoap.org/soap/envelope/");
      builder.element('Body', nest: () {
        builder.element('$methodName', nest: () {
          builder.attribute(
              'xmlns', "http://www.ulektz.com/soap/EdulektzWebServices");
          map.forEach((key, value) {
            builder.element('$key', nest: '$value');
          });
        });
      });
    });
    return builder.buildDocument().toString();
  }

  // Future<String> uploadImage(String apiName) async {
  //   var request = new http.MultipartRequest("POST", Uri.parse(apiName));
  //   request.headers.addAll({"Authorization": "Bearer ${await PreferenceHelper.getString(PreferenceConst.token)}"});
  //   var file1 = await PreferenceHelper.getString(PreferenceConst.userAadharFront);
  //   var file2 = await PreferenceHelper.getString(PreferenceConst.userAadharBack);
  //   var file3 = await PreferenceHelper.getString(PreferenceConst.userPanFront);
  //   var file4 = await PreferenceHelper.getString(PreferenceConst.userSelfiewithId);
  //   request.files.add(await http.MultipartFile.fromPath("images[]", file1,filename: PreferenceConst.userAadharFront));
  //   request.files.add(await http.MultipartFile.fromPath("images[]", file2,filename: PreferenceConst.userAadharBack));
  //   request.files.add(await http.MultipartFile.fromPath("images[]", file3,filename: PreferenceConst.userPanFront));
  //   request.files.add(await http.MultipartFile.fromPath("images[]", file4,filename: PreferenceConst.userSelfiewithId));
  //   print("Request Files ${request.files}");
  //   //for completeing the request
  //   var response =await request.send();
  //
  //   //for getting and decoding the response into json format
  //   var responsed = await http.Response.fromStream(response);
  //
  //   middleWare.showLog('REST Request: Url:$apiName params${responsed}');
  //   middleWare.showLog('ApiHandler :: uploadImage() :: ${responsed.statusCode} :: ${responsed.body}');
  //   return responsed.body;
  // }

  Future<String> uploadAttachment(String apiName,File file) async {
    var request = new http.MultipartRequest("POST", Uri.parse(apiName));
    request.headers.addAll({"Authorization": "Bearer ${await PreferenceHelper.getString(PreferenceConst.token)}"});
    var file1 = file.path;
    request.files.add(await http.MultipartFile.fromPath("images[]", file1,filename: "Attachment"));
    //for completeing the request
    var response =await request.send();
    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    middleWare.showLog('REST Request: Url:$apiName params${responsed}');

    middleWare.showLog('ApiHandler :: uploadImage() :: ${responsed.statusCode} :: ${responsed.body}');
    return responsed.body;
  }
}

class NoInternetView extends StatelessWidget {
  final Function onTap;

  NoInternetView({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 36.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/no_internet.webp',
                  width: 163,
                  height: 163,
                ),
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    "No internet connections",
                    style: TextStyle(
                      fontSize: 17.3,
                      fontWeight: FontWeight.w300,
                      //color: Colors.black.withOpacity(0.45),
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MultipartRequest extends http.MultipartRequest {
  MultipartRequest(
    String method,
    Uri url, {
    required this.onProgress,
  }) : super(method, url);

  final void Function(int bytes, int totalBytes) onProgress;

  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = this.contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress(bytes, total);
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}

typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

enum MethodType { POST, GET }
