import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:using_objext_box/model/contact_model.dart';
import 'package:using_objext_box/objectbox.g.dart';
import 'package:using_objext_box/services/contact_services.dart';

part 'contact_provider.g.dart';

@riverpod
class ContactProvider extends _$ContactProvider {
  @override
  List<ContactModel> build() {
    return sortedlist();
  }

  void addcontact(ContactModel ooo) {
    ContactServices.mybox.put(ooo);
    state = List.from(sortedlist());
  }

  void removecontact(int id) {
    ContactServices.mybox.remove(id);
    state = List.from(sortedlist());
  }

  List<ContactModel> sortedlist() {
    final Query<ContactModel> query =
        ContactServices.mybox.query().order(ContactModel_.name).build();
    return query.find();
  }
}
