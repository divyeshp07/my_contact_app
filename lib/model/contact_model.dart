import 'package:objectbox/objectbox.dart';

@Entity()
class ContactModel {
  @Id()
  int id;
  String name;
  String number;
  ContactModel({this.id = 0, required this.name, required this.number});
}
