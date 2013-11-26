
part of Controller;


class AccountData {
  @observable
  String name;
  String id;
  @observable
  String login;
  @observable
  String pw;
  int folder;
  
  
  AccountData(this.id, this.name, this.login, this.pw, this.folder);
  
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

class User {

  @observable
  String givenName;

  String masterPw;
  bool masterPwLocal = false;
  
  String masterPwCryptText;
  String id;
  
  @observable
  String familyName;
  String token;
  @observable
  String pictureLink = "";
  
}

class Data{
  List<MenuFolder> folder = new List();
  List<MenuAccount> account = new List();
  User user = new User();
}

class FolderData {
  @observable
  String name;
  int id;
  @observable
  int count = 0;
  FolderData(this.id, this.name);
}
