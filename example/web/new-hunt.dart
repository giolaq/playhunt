library playhunt.example;

import 'package:polymer/polymer.dart';
import 'dart:html';

import '../../packages/playhunt/browser.dart';



@CustomTag('new-hunt')
class NewHuntElement extends PolymerElement {
  @observable String id = '';
  @observable String name = '';
  @observable String imageUrl = '';
  @observable String clues = '';

  var playhunt;

  NewHuntElement.created() : super.created() {
    /* Creates a PlayHunt Client */
    playhunt = createPlayHuntClient();


  }

  void saveHunt(Event e, var detail, Node target) {

    Hunt aHunt = new Hunt();
    aHunt.id = id;
    aHunt.name = name;
    aHunt.imageUrl = imageUrl;

    Clue clu1 = new Clue();

    clu1.id  = "1";
    clu1.type = "clue";
    clu1.displayName = "Let's Play!";
    clu1.displayText = "Play";
    clu1.displayImage = "img.jpg";

    aHunt.clues = new List<Clue>();
    aHunt.clues.add(clu1);

    playhunt.hunts.createHunt(aHunt).then((hunt) {
      print(hunt);
    }
    );
  }


}