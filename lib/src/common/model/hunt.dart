part of playhunt.common;

/// Model class for a Hunt.
class Hunt {

  /// Hunt ID
  @ApiName("id")
  String id;

  /// Full Hunt Name
  @ApiName("displayName")
  String name;


  /// Image url
  @ApiName("imageUrl")
  String imageUrl;

  @ApiName("clues")
  List<Clue> clues;


  static Hunt fromJSON(input, [Hunt instance]) {
    if (input == null) return null;

    if (instance == null) instance = new Hunt();

    return instance
      ..name = input['displayName']
      ..id = input['id']
      ..imageUrl = input['imageUrl'];

  }


  String toJSON() {
    var cluesJson = [];
    cluesJson.add(clues[0].toJSON());
    return JSON.encode({
      "displayName": name,
      "id": id,
      "imageUrl": imageUrl,
      "clues" : cluesJson
    });
  }



}