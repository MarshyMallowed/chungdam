import 'package:flutter/material.dart';


class HanwooAlaCartePage extends StatelessWidget {
  final int index;

  HanwooAlaCartePage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HANWOO ALA CARTE'),
      ),
      body: Center(
        child: Text('Details Page $index'),
      ),
    );
  }
}