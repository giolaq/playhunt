part of playhunt.common;

/// Model class for a Hunt.
class Hunt extends Object with Serializable {

  /// Hunt ID
  String id;

  /// Full Hunt Name
  String name;


  /// Image url
  String imageUrl;

  List<Clue> clues;



  static Hunt fromJSON(input, [Hunt instance]) {
    if (input == null) return null;

    if (instance == null) instance = new Hunt();

    return instance
      ..name = input['displayName']
      ..id = input['id']
      ..imageUrl = input['imageUrl'];

  }


}