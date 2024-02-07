// import 'package:anim_search_bar/anim_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:using_objext_box/controller/contact_provider.dart';

// import 'package:using_objext_box/model/contact_model.dart';
// import 'package:using_objext_box/view/widgets/contact_app_widgets.dart';

// class ContactAppobbx extends ConsumerWidget {
//   ContactAppobbx({super.key});
//   final formKey = GlobalKey<FormState>();

//   final _namecontroller = TextEditingController();

//   final _numcontroller = TextEditingController();

//   final _searchcontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final contacts = ref.watch(contactProviderProvider);
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 70,
//         centerTitle: true,
//         title: const Text('My Contacts'),
//       ),
//       body: CustomScrollView(

//         slivers: [

//           contacts.isEmpty
//               ? const SliverFillRemaining(
//                   child: Center(
//                     child: Text('no Contacts available'),
//                   ),
//                 )
//               : SliverList.builder(
//                   itemCount: contacts.length,
//                   itemBuilder: (context, index) => Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: ListTile(
//                           title: Text(contacts[index].name),
//                           subtitle: Text(contacts[index].number),
//                           leading: CircleAvatar(
//                             backgroundColor: Colors.amber,
//                             child: Text(
//                               contacts[index].name[0].toUpperCase(),
//                             ),
//                           ),
//                           trailing: PopupMenuButton(
//                             itemBuilder: (context) {
//                               return [
//                                 PopupMenuItem(
//                                   value: 'Delete',
//                                   child: const Text('Delete'),
//                                   onTap: () {
//                                     ref
//                                         .read(contactProviderProvider.notifier)
//                                         .removecontact(contacts[index].id);
//                                   },
//                                 ),
//                                 PopupMenuItem(
//                                   value: 'Edit',
//                                   child: const Text('Edit'),
//                                   onTap: () {
//                                     _namecontroller.text = contacts[index].name;
//                                     _numcontroller.text =
//                                         contacts[index].number;
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) => DialogueWidget(
//                                           namecontroller: _namecontroller,
//                                           numcontroller: _numcontroller,
//                                           onPress: () {
//                                             ref
//                                                 .read(contactProviderProvider
//                                                     .notifier)
//                                                 .addcontact(
//                                                   ContactModel(
//                                                       name:
//                                                           _namecontroller.text,
//                                                       number:
//                                                           _numcontroller.text,
//                                                       id: contacts[index].id),
//                                                 );
//                                             _namecontroller.clear();
//                                             _numcontroller.clear();
//                                             Navigator.pop(context);
//                                           },
//                                           formkey: formKey),
//                                     );
//                                   },
//                                 )
//                               ];
//                             },
//                           )),
//                     ),
//                   ),
//                 )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) => DialogueWidget(
//                   formkey: formKey,
//                   onPress: () {
//                     ref.read(contactProviderProvider.notifier).addcontact(
//                         ContactModel(
//                             name: _namecontroller.text,
//                             number: _numcontroller.text));
//                     _namecontroller.clear();
//                     _numcontroller.clear();
//                     Navigator.pop(context);
//                   },
//                   namecontroller: _namecontroller,
//                   numcontroller: _numcontroller),
//             );
//           },
//           label: const Text('Add Contact')),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:using_objext_box/controller/contact_provider.dart';
import 'package:using_objext_box/model/contact_model.dart';
import 'package:using_objext_box/view/widgets/contact_app_widgets.dart';

class ContactAppobbx extends ConsumerWidget {
  ContactAppobbx({super.key});

  final formKey = GlobalKey<FormState>();

  final _namecontroller = TextEditingController();
  final _numcontroller = TextEditingController();
  final _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactProviderProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: const Text('My Contacts'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                    hintText: 'type something',
                    label: Text('Search'),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchcontroller.clear();
                        ref.read(contactProviderProvider.notifier).search('');
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    ref
                        .read(contactProviderProvider.notifier)
                        .search(value.trim());
                  },
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            sliver: Consumer(
              builder: (context, ref, child) {
                final contacts = ref.watch(contactProviderProvider);
                return contacts.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(child: Text('No contacts available')),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final contact = contacts[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  title: Text(contact.name),
                                  subtitle: Text(contact.number),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    child: Text(contact.name[0].toUpperCase()),
                                  ),
                                  trailing: PopupMenuButton(
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          value: 'Delete',
                                          child: const Text('Delete'),
                                          onTap: () {
                                            ref
                                                .read(contactProviderProvider
                                                    .notifier)
                                                .removecontact(contact.id);
                                          },
                                        ),
                                        PopupMenuItem(
                                          value: 'Edit',
                                          child: const Text('Edit'),
                                          onTap: () {
                                            _namecontroller.text = contact.name;
                                            _numcontroller.text =
                                                contact.number;
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DialogueWidget(
                                                namecontroller: _namecontroller,
                                                numcontroller: _numcontroller,
                                                onPress: () {
                                                  ref
                                                      .read(
                                                          contactProviderProvider
                                                              .notifier)
                                                      .addcontact(ContactModel(
                                                        name: _namecontroller
                                                            .text,
                                                        number:
                                                            _numcontroller.text,
                                                        id: contact.id,
                                                      ));
                                                  _namecontroller.clear();
                                                  _numcontroller.clear();
                                                  Navigator.pop(context);
                                                },
                                                formkey: formKey,
                                              ),
                                            );
                                          },
                                        )
                                      ];
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: contacts.length,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => DialogueWidget(
              formkey: formKey,
              onPress: () {
                ref.read(contactProviderProvider.notifier).addcontact(
                      ContactModel(
                        name: _namecontroller.text,
                        number: _numcontroller.text,
                      ),
                    );
                _namecontroller.clear();
                _numcontroller.clear();
                Navigator.pop(context);
              },
              namecontroller: _namecontroller,
              numcontroller: _numcontroller,
            ),
          );
        },
        label: const Text('Add Contact'),
      ),
    );
  }
}
