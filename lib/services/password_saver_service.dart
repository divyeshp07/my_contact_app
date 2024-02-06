import 'package:path_provider/path_provider.dart';
import 'package:using_objext_box/model/password_saver_model.dart';
import 'package:using_objext_box/objectbox.g.dart';
import 'package:path/path.dart' as passpath;

class PasswordappObjectboxServices {
  late final Store storepass;
  static late final Box<PasswordAppModel> passbox;
  PasswordappObjectboxServices._createpass(this.storepass) {
    passbox = storepass.box<PasswordAppModel>();
  }
  static Future<PasswordappObjectboxServices> createpass() async {
    final docsDirPas = await getApplicationDocumentsDirectory();
    final storeepass =
        await openStore(directory: passpath.join(docsDirPas.path, 'password'));
    return PasswordappObjectboxServices._createpass(storeepass);
  }
}
