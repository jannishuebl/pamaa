// Auto-generated from folder-overview-element.html.
// DO NOT EDIT.

library folderOverviewElement;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'dart:async';
import 'dart:js';
import '../../../util/util.dart' as util;
import '../../../controller.dart';
import '../../main/menu-folder.dart';
import '../account-overview.dart';
import '../folder-overview.dart';
import '../add-account.dart';



/** Die Klasse ist das Model zu einem FolderItem in der SideBar **/
class FolderOverviewElement extends WebComponent with Observable  {
  /** Autogenerated from the template. */

  autogenerated.ScopedCssMapper _css;

  /** This field is deprecated, use getShadowRoot instead. */
  get _root => getShadowRoot("folder-overview-element");
  static final __shadowTemplate = new autogenerated.DocumentFragment.html('''
        <div class="icon">
          <i class="icon-folder fg-color-red"></i>
        </div>
        <div class="data" style="float:left; margin-left:20px;">
          <h4><div style="overflow:hidden; float: left;max-width: 140px; "></div><i class="icon-remove" style="width: 13px; height:13px;float: left;margin-left: 10px;"></i></h4>
          <p style="margin-top: 10px;float: left;"></p>
        </div>
      ''', treeSanitizer: autogenerated.nullTreeSanitizer);
  autogenerated.DivElement __e51;
  autogenerated.Element __e52;
  autogenerated.ParagraphElement __e54;
  autogenerated.Template __t;

  void created_autogenerated() {
    var __root = createShadowRoot("folder-overview-element");
    setScopedCss("folder-overview-element", new autogenerated.ScopedCssMapper({"folder-overview-element":"[is=\"folder-overview-element\"]"}));
    _css = getScopedCss("folder-overview-element");
    __t = new autogenerated.Template(__root);
    __root.nodes.add(__shadowTemplate.clone(true));
    __e51 = __root.nodes[3].nodes[1].nodes[0];
    var __binding50 = __t.contentBind(() => folder.data.name, false);
    __e51.nodes.add(__binding50);
    __e52 = __root.nodes[3].nodes[1].nodes[1];
    __t.listen(__e52.onClick, ($event) { delete(); });
    __e54 = __root.nodes[3].nodes[3];
    var __binding53 = __t.contentBind(() => folder.data.count, false);
    __e54.nodes.addAll([__binding53,
        new autogenerated.Text(' Accounts')]);
    __t.create();
  }

  void inserted_autogenerated() {
    __t.insert();
  }

  void removed_autogenerated() {
    __t.remove();
    __t = __e51 = __e52 = __e54 = null;
  }

  /** Original code from the component. */

  bool ini = true;
  MenuFolder __$folder;
  MenuFolder get folder {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'folder');
    }
    return __$folder;
  }
  set folder(MenuFolder value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'folder',
          __$folder, value);
    }
    __$folder = value;
  }

  bool isremove = false;
  bool isSelected = false;
  FolderOverviewElement(folder) : __$folder = folder {

  }
  
  init() {
    this.host.onClick.listen(open);
  }

  void open(e) {
    if(!isSelected && !isremove) {
      folder.open();
      if(folder.data.count == 0)  new Controller()..showPage(new AddAccountComponent()..selectedFolder=folder.data.id.toString());
      else new Controller()..showPage(new AccountOverview(folder.data.id));
    }
    isSelected = false;
    isremove = false;
  }
  void delete() {
    isremove = true;
    
    var dialog = new JsObject.fromBrowserObject({
      'title'      : 'Warning..!',
      'content'    : 'Are you sure to delete the folder and its accounts?',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new JsFunction.withThis(() {
            new Controller()..removeFolder(folder);
            new Controller()..showPage(new FolderOverview());
          })
        }
      }
    });
    context['jQuery'].Dialog(dialog);
    
    
  }
}



//# sourceMappingURL=folder-overview-element.dart.map