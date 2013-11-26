import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:ams/controller.dart';
import 'dart:async';
import 'dart:json';
import 'package:ams/views/page/add-account.dart';
import 'package:google_oauth2_client/google_oauth2_browser.dart';
import 'package:ams/util/util.dart' as util;

/**
 * Learn about the Web UI package by visiting
 * http://www.dartlang.org/articles/dart-web-components/.
 */
void main() {
  Controller controller = new Controller();
  String token = util.readCookie('token');
 if(token != null && !token.isEmpty && token != "null") {
    controller.data.user.token = util.readCookie('token');
   controller.loginUserAtServer();
 } 
  controller.init();
}


