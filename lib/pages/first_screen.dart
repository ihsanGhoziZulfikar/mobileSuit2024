import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/pages/second_screen.dart';
import 'package:flutter_application_1/provider/name_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _palindromeController = TextEditingController();
  String? _nameError;
  String? _palindromeError;

  @override
  void dispose() {
    _nameController.dispose();
    _palindromeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0X90787878),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(30.0),
                child: Icon(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  Icons.person_add_alt_1_rounded,
                ),
              ),
              const SizedBox(height: 51.0),
              MyTextField(
                controller: _nameController,
                hintText: "Name",
                errorText: _nameError,
              ),
              // const SizedBox(height: 15.0),
              MyTextField(
                controller: _palindromeController,
                hintText: "Palindrome",
                errorText: _palindromeError,
              ),
              const SizedBox(height: 30.0),
              MyButton(text: "CHECK", onTap: _onCheckPalindrome),
              const SizedBox(height: 15.0),
              MyButton(
                text: "NEXT",
                onTap: _onNext,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isNameEmpty() {
    return _nameController.text.trim().isEmpty;
  }

  void _onNext() {
    setState(() {
      _nameError = _isNameEmpty() ? "Name could not be empty" : null;
    });

    if (!_isNameEmpty()) {
      context.read<NameProvider>().inputName(_nameController.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SecondScreen(),
        ),
      );
    }
  }

  bool _isPalindromeEmpty() {
    return _palindromeController.text.trim().isEmpty;
  }

  bool isPalindrome(String text) {
    String cleanedText = text.replaceAll(RegExp(r'[\W_]+'), '').toLowerCase();
    int left = 0;
    int right = cleanedText.length - 1;

    while (left < right) {
      if (cleanedText[left] != cleanedText[right]) {
        return false;
      }
      left++;
      right--;
    }

    return true;
  }

  void _showPalindromeDialog(BuildContext context, bool isPalindrome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isPalindrome ? "True" : "False"),
          content: Text(isPalindrome
              ? "The text is a palindrome."
              : "The text is not a palindrome."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onCheckPalindrome() {
    setState(() {
      _palindromeError =
          _isPalindromeEmpty() ? "Palindrome could not be empty" : null;
    });
    if (!_isPalindromeEmpty()) {
      String text = _palindromeController.text;
      bool palindrome = isPalindrome(text);
      _showPalindromeDialog(context, palindrome);
    }
  }
}
