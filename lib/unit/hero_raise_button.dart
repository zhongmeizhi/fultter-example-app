import 'package:flutter/material.dart';

class HeroRaiseButton extends StatelessWidget {
  
  final String text;
  HeroRaiseButton({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'routeHero',
      child: RaisedButton(
        disabledColor: Colors.blue,
        child: Text('当前在$text', style: TextStyle(color: Colors.white),),
        onPressed: null
      ),
      placeholderBuilder: (context, widget) {
        return Container(
          height: 150.0,
          width: 150.0,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}