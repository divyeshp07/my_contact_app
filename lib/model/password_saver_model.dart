import 'package:objectbox/objectbox.dart';

@Entity()
class PasswordAppModel {
  @Id()
  int id;
  String appName;
  String password;
  bool isPasswordVisible;
  PasswordAppModel(
      {this.id = 0,
      required this.appName,
      required this.password,
      this.isPasswordVisible = false});
}
