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


  static Hunt fromJSON(input, [Hunt instance]) {
    if (input == null) return null;

    if (instance == null) instance = new Hunt();

    return instance
      ..name = input['displayName']
      ..id = input['id']
      ..imageUrl = input['imageUrl'];
  }



}