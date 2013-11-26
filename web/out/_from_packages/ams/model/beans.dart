
part of Controller;


class AccountData extends Observable  {
  String __$name;
  String get name {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'name');
    }
    return __$name;
  }
  set name(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'name',
          __$name, value);
    }
    __$name = value;
  }
  String id;
  String __$login;
  String get login {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'login');
    }
    return __$login;
  }
  set login(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'login',
          __$login, value);
    }
    __$login = value;
  }
  String __$pw;
  String get pw {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'pw');
    }
    return __$pw;
  }
  set pw(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'pw',
          __$pw, value);
    }
    __$pw = value;
  }
  int folder;
  
  
  AccountData(this.id, name, login, pw, this.folder) : __$name = name, __$login = login, __$pw = pw;
  
  String toString() {
    
    String str = ['{"folder":',       folder.toString(),
                  ',"accountname":"', name,
                 '","accountid":',    id.toString(),
                  ',"login":"',       login,
                 '","password":"',    pw.replaceAll(new RegExp('"'), '\\"') ,
                 '","note":""}'].join();
    return str;
  }
}

class User extends Observable  {

  String __$givenName;
  String get givenName {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'givenName');
    }
    return __$givenName;
  }
  set givenName(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'givenName',
          __$givenName, value);
    }
    __$givenName = value;
  }

  String masterPw;
  bool masterPwLocal = false;
  
  String masterPwCryptText;
  String id;
  
  String __$familyName;
  String get familyName {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'familyName');
    }
    return __$familyName;
  }
  set familyName(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'familyName',
          __$familyName, value);
    }
    __$familyName = value;
  }
  String token;
  String __$pictureLink = "";
  String get pictureLink {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'pictureLink');
    }
    return __$pictureLink;
  }
  set pictureLink(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'pictureLink',
          __$pictureLink, value);
    }
    __$pictureLink = value;
  }
  
}

class Data{
  List<MenuFolder> folder = new List();
  List<MenuAccount> account = new List();
  User user = new User();
}

class FolderData extends Observable  {
  String __$name;
  String get name {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'name');
    }
    return __$name;
  }
  set name(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'name',
          __$name, value);
    }
    __$name = value;
  }
  int id;
  int __$count = 0;
  int get count {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'count');
    }
    return __$count;
  }
  set count(int value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'count',
          __$count, value);
    }
    __$count = value;
  }
  FolderData(this.id, name) : __$name = name;
}

//# sourceMappingURL=beans.dart.map