// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library playhunt.example;

import 'package:playhunt/browser.dart';

main() {
  /* Creates a PlayHunt Client */
  var playhunt = createPlayHuntClient();

  playhunt.hunts.listHunts();
}