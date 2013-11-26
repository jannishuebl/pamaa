library folderOverview;

import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'dart:async';
import 'package:js/js.dart' as js;
import 'package:ams/util/util.dart' as util;
import 'package:ams/controller.dart';
import 'package:ams/views/page/elements/folder-overview-element.dart';

/** Die Klasse ist das Model der Seite Account anzeigen**/
class FolderOverview extends WebPage {
  
  /** Variablen des Interface **/
  bool ini = true;
static  String pageUrl = 'folderOverview';
  
       
  String getPageUrl() {
    return pageUrl;
  }

void init() {
  new Controller().data.folder.reversed.forEach((e) {
      LIElement host = new LIElement();
      host.id = 'folder'+e.data.id.toString();
      
      
    var ul = querySelector('.page-region ul');
    
    FolderOverviewElement folderElement = new FolderOverviewElement(e)..host = host;
    util.addComponent(ul, folderElement );
    
    });
}


}

