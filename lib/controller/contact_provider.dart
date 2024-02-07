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

  void search(String searchtext) {
    if (searchtext.isEmpty) {
      state = sortedlist();
    } else {
      final query = ContactServices.mybox
          .query(ContactModel_.name
              .startsWith(searchtext, caseSensitive: false)
              .or(ContactModel_.number
                  .startsWith(searchtext, caseSensitive: false)))
          .order(ContactModel_.name)
          .build();
      state = query.find();
    }
  }
}

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:using_objext_box/model/contact_model.dart';
// import 'package:using_objext_box/services/contact_services.dart';

// import '../objectbox.g.dart';

// class ContactProvider extends StateNotifier<List<ContactModel>> {
//   ContactProvider() : super([]);

//   void addcontact(ContactModel contact) {
//     ContactServices.mybox.put(contact);
//     state = sortedlist();
//   }

//   void removecontact(int id) {
//     ContactServices.mybox.remove(id);
//     state = sortedlist();
//   }

//   List<ContactModel> sortedlist() {
//     final query = ContactServices.mybox.query().order(ContactModel_.name).build();
//     return query.find();
//   }

//   void search(String searchtext) {
//     if (searchtext.isEmpty) {
//       state = sortedlist();
//     } else {
//       final query = ContactServices.mybox
//           .query(ContactModel_.name.contains(searchtext, caseSensitive: false)
//               .or(ContactModel_.number.contains(searchtext, caseSensitive: false)))
//           .order(ContactModel_.name)
//           .build();
//       state = query.find();
//     }
//   }
// }

