part of Controller;

class Crypt  {
  
  var toCall;
  String pw;

  /** fetchs masterpw form the user and after crypting the pw calls the toCall methode**/
  void cryptPassword(String pw, var toCall) {
    this.pw = pw;
    this.toCall = toCall;
    openDialog(cryptPasswordReplayCallback);
  }

  /** fetchs masterpw form the user and after decrypting the pw calls the toCall methode**/
  void decryptPassword(String pw, var toCall) {
    this.pw = pw;
    this.toCall = toCall;
    openDialog(decryptPasswordReplayCallback);
  }

  /** calls the callback mthode with the crypted pw**/
  void cryptPasswordReplayCallback(String pwHashed) {
    toCall(crypt(pwHashed, pw));
  }
  
  /** calls the callback mthode with the decrypted pw**/
  void decryptPasswordReplayCallback(String pwHashed) {
    toCall(decrypt(pwHashed, pw));
  }
  
  /** Crypts a pw with the hash **/
  String crypt(String pwHashed, String pw) {
    var pwObject = JSON.parse(context['sjcl'].encrypt(pwHashed, pw));
    return ['\"iv\":\"', pwObject.values.first,'\",\"salt\":\"', pwObject.values.elementAt(8), '\",\"ct\":\"', pwObject.values.last,'\"'].join();
  }

  /** Decrypts a pw with the hash **/
  String decrypt(String masterPwHashed , String pw) {
    var pwObject = ['{"v":1,"iter":1000,"ks":128,"ts":64,"mode":"ccm","adata":"", "cipher":"aes",',pw,"}"].join();
      return context['sjcl'].decrypt(masterPwHashed, pwObject);
  }
  
  
  /** Shows an Dialog to the user to get his masterpw, checkts it, and if its ok calls the overgiven callbackmethode**/
  void openDialog(var toCall) {
    Timer.run(() {
      // trys to close the Dialog
      bool test = context['jQuery'].Dialog.close();
    
      // test if the dialog is still open
      // if closed: open dialog to get masterpw
      // else close the dialog and recall this method to open the get masterpassword dialog
      if(test != null && !test) {
        var dialog = new JsObject.fromBrowserObject({
          'title'      : 'Enter Masterpassword',
          'content'    : 'Enter your Masterpassword:<br><br><div class="input-control text"><input autofocus="true" id="masterPw" type="password" /><button class="btn-clear"></button></div>',
          'draggable'  : true,
          'buttonsAlign': 'right',
          'closeButton' : true,
          'buttons'    : {
            'Cancel'    : {},
            'Ok'    : { 
              'action': new JsFunction.withThis(() {
                // fetch the masterPw from inputfield
                InputElement pwField = query('#masterPw');
                String pwHashed = util.hash(pwField.value);
                // test pw
                if(testMasterPw(pwHashed)) {
                  toCall(pwHashed);
               } else {
                  // if the masterpw is fals close the dialog and reopen it by recalling this methode
                  context['jQuery'].Dialog.close();
                  openDialog(toCall);
                }})
            }
          }
        });
        context['jQuery'].Dialog(dialog);
       } else {
        openDialog(toCall);
       }
    });
  }
  
  /** Sets the masterpw for the first time. **/
  void setMasterPw() {
    Timer.run(() {
      // trys to close the Dialog
      bool test = context['jQuery'].Dialog.close();
    
      // test if the dialog is still open
      // if closed: open dialog to get masterpw
      // else close the dialog and recall this method to open the get masterpassword dialog
      if(test != null && !test) {
    var dialog = new JsObject.fromBrowserObject({
      'title'      : 'Enter Masterpassword',
      'content'    : 'Enter your Masterpassword:<br><br><div class="input-control text"><input autofocus id="masterPw" type="password" /><button class="btn-clear"></button></div>Repeat your Masterpassword:<br><br><div class="input-control text"><input id="masterPw2" type="password" /><button class="btn-clear"></button></div>',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'Ok'    : {
          'action': new JsFunction.withThis(() {
            InputElement pwField = querySelector('#masterPw');
            String pwHashed = util.hash(pwField.value);
            
            InputElement pwField2 = querySelector('#masterPw2');
            String pwHashed2 = util.hash(pwField2.value);
            
            if(pwField.value.trim() != "" && pwHashed.compareTo(pwHashed2) == 0) {
              sendMasterPw(pwHashed);
            } else {
              context['jQuery'].Dialog.close();
              setMasterPw();
            }})
        }
        
      }
    });
    context['jQuery'].Dialog(dialog);
    context['jQuery']('#masterPw').focus();
      } else {
        setMasterPw();
       }
    });
  
  }
  
  void sendMasterPw(String pwHashed) {
    new Controller()..data.user.masterPw = crypt(pwHashed, new Controller().data.user.masterPwCryptText);
    util.sendJson('master', 'PUT','{"masterpw":"'+new Controller().data.user.masterPw.replaceAll(new RegExp('"'), '\\"') +'"}', (_){});
  }
  bool testMasterPw(String pwHashed) {
    try {
      var u0 = decrypt(pwHashed, new Controller().data.user.masterPw);
      return new Controller().data.user.masterPwCryptText.compareTo(u0) == 0;
    } catch (_) {
      return false;
    }
  }
}
