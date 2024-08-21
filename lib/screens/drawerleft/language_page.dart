import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  // List of languages limited to English and Korean
  final List<String> languages = [
    'English',
    'Korean'
  ];

  // Currently selected language
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0c2344), // Adjust the color as per your theme
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.separated(
        itemCount: languages.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.grey, // Color of the divider
          thickness: 1.0, // Thickness of the divider
          height: 1.0, // Height of the divider
        ),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              languages[index],
              style: TextStyle(
                color: Colors.black, // Text remains black
              ),
            ),
            leading: Radio<String>(
              value: languages[index],
              groupValue: selectedLanguage,
              activeColor: Color(0xFF0c2344), // Change radio button color to dark blue on selection
              onChanged: (String? value) {
                setState(() {
                  selectedLanguage = value;
                });
                // Handle language selection change if needed
              },
            ),
            onTap: () {
              setState(() {
                selectedLanguage = languages[index];
              });
            },
          );
        },
      ),
    );
  }
}
