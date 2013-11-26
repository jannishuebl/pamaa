library util;


import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'dart:async'; 
import 'package:crypto/crypto.dart';
import 'dart:js';

import 'package:ams/controller.dart';

// Sendet ein Json an den Server wenn erfolgreich wird die Callback methode succ aufgerufen
void sendJson(String path, String methode, var data, var succ, {bool fullPathSet: false}) {
  path = createUrl(path, fullPathSet);

  HttpRequest request = new HttpRequest();
  request.open(methode, path);
  request.setRequestHeader('Content-type', 
      'application/json');
  request.send(data);

  request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE &&
        (request.status == 200 || request.status == 0)) {
      succ(request);   
      } else {
      if(request.status != 200) {
      handelFail(request.status);
      }
      }
      });
}

handelFail(int status) {
  Timer.run(() {
      // trys to close the Dialog
      bool test = context["jQuery"].Dialog.close();

      // test if the dialog is still open
      // if closed: open dialog to get masterpw
      // else close the dialog and recall this method to open the get masterpassword dialog
      if(test != null && !test) {
      var dialogData = {
      'title'      : 'Error',
      'content'    : '',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
      'Ok'    : {
      'action': new JsFunction.withThis((){})
      }
      }
      };

      switch (status) {
        case 400: {
                    dialogData['content'] = 'Sorry, authentification failed.';
                    query('#start').style.display="block";
                    query('#app').style.display="none";
                    new Controller().data = new Data();
                  }
                  break;
        default: {
                   dialogData['content'] = 'Sorry, an error occurred.';
                 }
      }
      var dialog = new JsObject.fromBrowserObject(dialogData);  
      context["jQuery"].Dialog(dialog);
      } else {
        handelFail(status);
      }
  });
}

String createUrl(String path, bool fullPathSet) {
  if(!fullPathSet){
    path = 'api/user/' + new Controller().data.user.id.toString() +'/'+path +'/'+new Controller().data.user.token;
  }
  else path = path +'/'+new Controller().data.user.token;
  return 'https://localhost:8443/'+path.replaceAll(new RegExp('//'), '/');
}

// Sendet ein Json an den Server wenn erfolgreich wird die Callback methode succ aufgerufen
void sendRequest(String path, String methode, var succ, {bool fullPathSet: false, var requestFailed: null}) {
  path = createUrl(path, fullPathSet);

  var dialog = {
      'title'      : '',
      'content'    : '<img style="margin-top:20px;margin-left:20px"src="style/metro/images/preloader-w8-cycle-black.gif">',
      'draggable'  : false,
      'empty' : true,
      'buttons'    : {}
      };
  
 context["jQuery"].Dialog(new JsObject.fromBrowserObject(dialog));

  HttpRequest request = new HttpRequest();
  request.open(methode, path);
  request.send();
  request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE &&
        (request.status == 200 || request.status == 0)) {

      context['jQuery'].Dialog.close();
      succ(request);   

      } else {
      if(request.status != 200) {
      if(requestFailed != null) requestFailed(request);
      handelFail(request.status);
      }
      }
      });
}


// Fügt ein html element zum Dom hinzu und auch zum lifecycle von dart damit des auch mit dart angesprochen werden kann
void addComponent(identifyer, component, [bool clear , var follower]) {
  if(clear != null && clear) identifyer.children.clear();

  ComponentItem lifecycleCaller = new ComponentItem(component)..create();
  if(follower != null) identifyer.insertBefore(component.host, follower.host);
  else identifyer.children.add(component.host);
  lifecycleCaller.insert();

  // wenn die Klasse eine init methode hat soll diese aufgerufen werden7
  // funktioniert nur in der DartVM da der dart2js compiler noch keine reflection unterstützt (29.06.2013)
  if(component.ini == true) component.init();
  //    InstanceMirror componentMirror = reflect(component);
  //    if(componentMirror.type.members.keys.contains(new Symbol('init'))) component.init();

}

/** Verschiebt Elemente die beim seiten aufbau für dart bereits vorhanden sein müssen,
 *  aber noch nicht an der stelle wo sie am ende angezeigt werden sollen, weil erst mit jquery 
 *  die container position des Parentelements der Parktelements festgelegt werden muss **/
void moveParkedElements() {
  List elm = new List();
  query('#placeholderElements').children.forEach((e) {
      elm.add(e);
      });
  elm.forEach((e) {
      query('#'+e.id+'Wrapper').insertAdjacentElement("afterBegin", e);
      });
}

String hash(String str) {
  SHA256 sha = new SHA256();
  sha.add(str.codeUnits);
  return digestToString(sha.close());
}

String digestToString(List<int> digest) {
  var buf = "";
  for (var part in digest) {
    buf += ("${(part < 16) ? "0" : ""}${part.toRadixString(16).toLowerCase()}");
  }
  return buf;
} 
String readCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i=0;i < ca.length;i++) {
    var c = ca[i].trim();
    //while (c.codeUnitAt(0)==' ') c = c.substring(1,c.length);
    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
}
void createCookie(name,value,days) {
  var expires; 
  if (days) {
    var date = new DateTime.now();
    date.millisecond = date.millisecond +(days*24*60*60*1000);
    expires = "; expires="+date.toUtc().toString();
  }
  else expires = "";
  document.cookie = name+"="+value+expires+"; path=/";
}
void eraseCookie(name) {
  createCookie(name,"",-1);
}
