library playhunt.example;

import 'package:polymer/polymer.dart';

import '../../packages/playhunt/browser.dart';


@CustomTag('hunt-list')
class HuntListElement extends PolymerElement {
  @observable int count = 0;
  @observable List<Hunt> listhunts = toObservable([]);

  HuntListElement.created() : super.created() {
    /* Creates a PlayHunt Client */
    var playhunt = createPlayHuntClient();

    playhunt.hunts.listHunts().toList().then((hunts) {
      for (Hunt hunt in hunts) {
        listhunts.add(hunt);
        print('Hunt ' + hunt.name);
        print('Hunt ' + hunt.id);
        print('Hunt ' + hunt.imageUrl);
      }
      print(listhunts);
    }
    );
  }



}