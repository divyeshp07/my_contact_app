import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:using_objext_box/model/password_saver_model.dart';
import 'package:using_objext_box/services/password_saver_service.dart';

part 'password_saver_provider.g.dart';

@riverpod
class Password extends _$Password {
  @override
  List<PasswordAppModel> build() {
    return PasswordappObjectboxServices.passbox.getAll();
  }

  void addpassword(PasswordAppModel pass) {
    PasswordappObjectboxServices.passbox.put(pass);
    state = PasswordappObjectboxServices.passbox.getAll();
  }

  void deletepass(int id) {
    PasswordappObjectboxServices.passbox.remove(id);
    state = PasswordappObjectboxServices.passbox.getAll();
  }

  // Toggle password visibility
  void togglePasswordVisibility(int index) {
    // final password = state[index];
    state[index].isPasswordVisible = !state[index].isPasswordVisible;
    PasswordappObjectboxServices.passbox.put(state[index]);
    state = PasswordappObjectboxServices.passbox.getAll();
  }
}
