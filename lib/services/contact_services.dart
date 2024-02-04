import 'package:path/path.dart' as pathhh;
import 'package:path_provider/path_provider.dart';
import 'package:using_objext_box/model/contact_model.dart';
import 'package:using_objext_box/objectbox.g.dart';

class ContactServices {
  late final Store store;
  static late final Box<ContactModel> mybox;
  ContactServices._create(this.store) {
    mybox = store.box<ContactModel>();
  }

  static Future<ContactServices> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final storee =
        await openStore(directory: pathhh.join(docsDir.path, 'contact'));
    return ContactServices._create(storee);
  }
}
