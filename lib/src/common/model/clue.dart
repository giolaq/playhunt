part of playhunt.common;

/*
"id": "droidcon1",
"type": "clue",
"shufflegroup": 0,
"displayName": "Let's Play!",
"displayText": "Scan the two tags you find next to it.",
"displayImage": "app0.jpg",
"tags": [
{
"id": "gdg0"
},
{
"id": "gdg1"
}
],
"question": {
"question": "What's the Class in Android SDK managing Audio/Video files and their encoding?",
"answers": [
"MediaRecorder",
"MediaFile",
"EncodeMedia"
],
"correctAnswer": 0,
"wrongMessage": "No, it's MediaRecorder!\n",
"rightMessage": "That's right!"
} */

@Entity()
class Clue {


  @Property()
  String id;
  @Property()
  String type;
  @Property()
  num shufflegroup;
  @Property()
  String displayName;
  @Property()
  String displayText;
  @Property()
  String displayImage;
  @Property()
  List<Tag> tags;
  @Property()
  Question question;


  static Clue fromJSON(input, [Clue instance]) {
    if (input == null) return null;

    if (instance == null) instance = new Clue();

    return instance
      ..id = input['id']
      ..type = input['type']
      ..shufflegroup = input['shufflegroup']
      ..displayName = input['displayName']
      ..displayText = input['displayText']
      ..tags = JSON.decode(input['tags'])
      ..question = input['question'];
  }

}

@Entity()
class Tag  {
  @Property()
  String id;


  static Tag fromJSON(input, [Tag instance]) {
    if (input == null) return null;

    if (instance == null) instance = new Tag();

    return instance
      ..id = input['id'];
  }



}

@Entity()
class Question  {

  @Property()
  String question;
  @Property()
  List<String> answers;
  @Property()
  String correctAnswer;
  @Property()
  String wrongMessage;
  @Property()
  String rightMessage;

  static Question fromJSON(input, [Question instance]) {
    if (input == null) return null;

    if (instance == null) instance = new Question();

    return instance
      ..question = input['question']
      ..answers  = JSON.decode(input['answers'])
      ..correctAnswer = input['correctAnswer']
      ..wrongMessage = input['wrongMessage']
      ..rightMessage = input['rightMessage'];
  }




}