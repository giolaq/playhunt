library playhunt.example;

import 'package:polymer/polymer.dart';

import '../../packages/playhunt/browser.dart';


@CustomTag('new-hunt')
class NewHuntElement extends PolymerElement {
  @observable int count = 0;

  NewHuntElement.created() : super.created() {
    /* Creates a PlayHunt Client */
    var playhunt = createPlayHuntClient();

    Hunt aHunt = new Hunt();
    aHunt.id = "ssss";
    aHunt.name = "Giovanni";
    aHunt.imageUrl = "immaggginne!";

    playhunt.hunts.createHunt(aHunt).then((hunt) {
      print(hunt);
    }
    );
  }


}