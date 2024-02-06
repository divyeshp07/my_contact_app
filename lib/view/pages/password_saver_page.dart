import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:using_objext_box/controller/password_saver_provider.dart';
import 'package:using_objext_box/model/password_saver_model.dart';
import 'package:using_objext_box/view/widgets/contact_app_widgets.dart';
import 'package:using_objext_box/view/widgets/password_saver_widgets.dart';

class PasswordSaverApp extends ConsumerWidget {
  PasswordSaverApp({super.key});
  final formKey = GlobalKey<FormState>();

  final appNamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mypass = ref.watch(passwordProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My PassWord'),
      ),
      body: CustomScrollView(
        slivers: [
          mypass.isEmpty
              ? const SliverFillRemaining(
                  child: Center(
                    child: Text('No passwords available'),
                  ),
                )
              : SliverList.builder(
                  itemCount: mypass.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(mypass[index].appName),
                        subtitle: PasswordDisplayWidget(
                          password: mypass[index].password,
                          isPasswordVisible: mypass[index].isPasswordVisible,
                        ),
                        leading: PasswordVisibilityToggle(
                          isPasswordVisible: mypass[index].isPasswordVisible,
                          onToggle: () {
                            ref
                                .read(passwordProvider.notifier)
                                .togglePasswordVisibility(index);
                          },
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 'Delete',
                                child: const Text('Delete'),
                                onTap: () {
                                  ref
                                      .read(passwordProvider.notifier)
                                      .deletepass(mypass[index].id);
                                },
                              ),
                              PopupMenuItem(
                                value: 'Edit',
                                child: const Text('Edit'),
                                onTap: () {
                                  appNamecontroller.text =
                                      mypass[index].appName;
                                  passwordcontroller.text =
                                      mypass[index].password;
                                  // mypass[index].id;
                                  showDialog(
                                    context: context,
                                    builder: (context) => DialogueWidget(
                                        namecontroller: appNamecontroller,
                                        numcontroller: passwordcontroller,
                                        onPress: () {
                                          ref
                                              .read(passwordProvider.notifier)
                                              .addpassword(PasswordAppModel(
                                                  appName:
                                                      appNamecontroller.text,
                                                  password:
                                                      passwordcontroller.text,
                                                  id: mypass[index].id));
                                          appNamecontroller.clear();
                                          passwordcontroller.clear();
                                          Navigator.pop(context);
                                        },
                                        formkey: formKey),
                                  );
                                },
                              ),
                            ];
                          },
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add PassWord Here..'),
              content: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextField(
                      controller: appNamecontroller,
                      decoration:
                          const InputDecoration(label: Text('App Name')),
                    ),
                    TextField(
                      controller: passwordcontroller,
                      decoration:
                          const InputDecoration(label: Text('Password')),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (passwordcontroller.text.isEmpty) {
                          Navigator.pop(context);
                        }
                        ref.read(passwordProvider.notifier).addpassword(
                              PasswordAppModel(
                                appName: appNamecontroller.text,
                                password: passwordcontroller.text,
                              ),
                            );
                        appNamecontroller.clear();
                        passwordcontroller.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        label: const Text('Add Contact'),
      ),
    );
  }
}
