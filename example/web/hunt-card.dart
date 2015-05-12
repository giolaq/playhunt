library playhunt.example;

import 'package:polymer/polymer.dart';
import 'dart:html';



@CustomTag('hunt-card')
class HuntCardElement extends PolymerElement {
  @observable int count = 0;

  HuntCardElement.created() : super.created();

  void increment(Event e, var detail, Node target) {
    count += 1;
  }
}