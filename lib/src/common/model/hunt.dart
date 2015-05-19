part of playhunt.common;

/// Model class for a Hunt.
///
@Entity()
class Hunt  {

  /// Hunt ID
  @Property()
  String id;

  /// Full Hunt Name
  @Property()
  String name;


  /// Image url
  @Property()
  String imageUrl;

  @Property()
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