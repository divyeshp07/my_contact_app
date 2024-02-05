import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogueWidget extends StatelessWidget {
  const DialogueWidget({
    Key? key,
    required TextEditingController namecontroller,
    required TextEditingController numcontroller,
    required this.onPress,
    required this.formkey,
  })  : _namecontroller = namecontroller,
        _numcontroller = numcontroller,
        super(key: key);

  final TextEditingController _namecontroller;
  final TextEditingController _numcontroller;
  final void Function() onPress;
  final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Contact'),
      content: SizedBox(
        height: 250,
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                controller: _namecontroller,
                decoration: const InputDecoration(
                  helperText: 'Name',
                  hintText: 'Name',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.phone,
                maxLength: 10,
                controller: _numcontroller,
                decoration: const InputDecoration(
                  hintText: 'Number',
                  helperText: 'Number',
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Number cannot be empty';
                  } else if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    onPress();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
