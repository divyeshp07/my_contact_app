import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DialogueWidget extends ConsumerWidget {
  const DialogueWidget({
    super.key,
    required TextEditingController namecontroller,
    required TextEditingController numcontroller,
    required this.onPress,
    // required this.formkey
  })  : _namecontroller = namecontroller,
        _numcontroller = numcontroller;

  final TextEditingController _namecontroller;
  final TextEditingController _numcontroller;
  final void Function() onPress;
  // final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Create Contact'),
      content: SizedBox(
        height: 250,
        // child: Form(
        // key: formkey,
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
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.phone,
              controller: _numcontroller,
              decoration: const InputDecoration(
                  hintText: 'Number', helperText: 'Number'),
            ),
            ElevatedButton(onPressed: onPress, child: const Text('Save'))
          ],
        ),
      ),
      //   ),
    );
  }
}
