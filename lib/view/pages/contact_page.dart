import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:using_objext_box/controller/contact_provider.dart';
import 'package:using_objext_box/model/contact_model.dart';

class ContactAppobbx extends ConsumerWidget {
  ContactAppobbx({super.key});

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
                      child: Text(contacts[index].name[0]),
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
                            icon: const Icon(Icons.delete_forever_rounded)),
                        IconButton(
                            onPressed: () {},
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
              builder: (context) => AlertDialog(
                title: const Text('Create Contact'),
                content: SizedBox(
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextField(
                        controller: _namecontroller,
                        decoration: const InputDecoration(
                          helperText: 'Name',
                          hintText: 'Name',
                        ),
                      ),
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.phone,
                        controller: _numcontroller,
                        decoration: const InputDecoration(
                            hintText: 'Number', helperText: 'Number'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            ref
                                .read(contactProviderProvider.notifier)
                                .addcontact(ContactModel(
                                    name: _namecontroller.text,
                                    number: _numcontroller.text));
                          },
                          child: const Text('Save'))
                    ],
                  ),
                ),
              ),
            );
          },
          label: const Text('Add Contact')),
    );
  }
}
