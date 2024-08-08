import 'package:flutter/material.dart';






class WagyuSetPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WAGYU SET'),
      ),
      body: Center(
        child: Text('Details Page 3'),
      ),
    );
  }
}

class SamgyeopsalPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SAMGYEOPSAL'),
      ),
      body: Center(
        child: Text('Details Page 4'),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Error")),
      body: Center(child: Text("Page not found!")),
    );
  }
}
