import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              fillColor: Theme.of(context).colorScheme.surface,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0),
              )),
        ),
        if (errorText != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  errorText!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ],
          ),
        if (errorText == null) const SizedBox(height: 15.0),
      ],
    );
  }
}
