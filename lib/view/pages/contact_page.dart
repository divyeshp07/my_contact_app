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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactProviderProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Contacts'),
      ),
      body: CustomScrollView(
        slivers: [
          contacts.isEmpty
              ? const SliverFillRemaining(
                  child: Center(
                    child: Text('no Contacts available'),
                  ),
                )
              : SliverList.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(contacts[index].name),
                    subtitle: Text(contacts[index].number),
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text(contacts[index].name[0].toUpperCase()),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              ref
                                  .read(contactProviderProvider.notifier)
                                  .removecontact(contacts[index].id);
                            },
                            icon: const Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () {
                              _namecontroller.text = contacts[index].name;
                              _numcontroller.text = contacts[index].number;
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DialogueWidget(
                                      // formkey: formKey,
                                      namecontroller: _namecontroller,
                                      numcontroller: _numcontroller,
                                      onPress: () {
                                        ref
                                            .read(contactProviderProvider
                                                .notifier)
                                            .addcontact(ContactModel(
                                                name: _namecontroller.text,
                                                number: _numcontroller.text,
                                                id: contacts[index].id));
                                        _namecontroller.clear();
                                        _numcontroller.clear();
                                        Navigator.pop(context);
                                      },
                                    );
                                  });
                            },
                            icon: const Icon(Icons.edit_square)),
                      ],
                    ),
                  ),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DialogueWidget(
                  // formkey: ,
                  onPress: () {
                    ref.read(contactProviderProvider.notifier).addcontact(
                        ContactModel(
                            name: _namecontroller.text,
                            number: _numcontroller.text));
                    _namecontroller.clear();
                    _numcontroller.clear();
                    Navigator.pop(context);
                  },
                  namecontroller: _namecontroller,
                  numcontroller: _numcontroller),
            );
          },
          label: const Text('Add Contact')),
    );
  }
}
