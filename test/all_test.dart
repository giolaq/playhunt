// Copyright (c) 2015, Giovanni Laquidara All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library playhunt.test;

import 'package:unittest/unittest.dart';
import 'package:playhunt/playhunt.dart';

main() {
  group('A group of tests', () {
    Awesome awesome;

    setUp(() {
      awesome = new Awesome();
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
