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
class Clue {

  String id;
  String type;
  num shufflegroup;
  String displayName;
  String displayText;
  String displayImage;
  List<Tag> tags;
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


  String toJSON() {
    return JSON.encode({
      "id": id
    });
  }

}

class Tag {
  String id;



  static Tag fromJSON(input, [Tag instance]) {
    if (input == null) return null;

    if (instance == null) instance = new Tag();

    return instance
      ..id = input['id'];
  }


  String toJSON() {
    return JSON.encode({
      "id": id
    });
  }



}

class Question {

  String question;
  List<String> answers;
  String correctAnswer;
  String wrongMessage;
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


  String toJSON() {
    return JSON.encode({
      "question": question,
      "answers" : JSON.encode(answers),
      "correctAnswer" : correctAnswer,
      "wrongMessage" : wrongMessage,
      "rigthMessage" : rightMessage
    });
  }

}