import 'package:flutter/material.dart';






class WagyuSetPage extends StatelessWidget {
  final int index;

  WagyuSetPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WAGYU SET'),
      ),
      body: Center(
        child: Text('Details Page $index'),
      ),
    );
  }
}

class SamgyeopsalPage extends StatelessWidget {
  final int index;

  SamgyeopsalPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SAMGYEOPSAL'),
      ),
      body: Center(
        child: Text('Details Page $index'),
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
