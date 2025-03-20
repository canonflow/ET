class Question {
  String narration;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String answer;
  String photo;

  Question(this.narration, this.optionA, this.optionB, this.optionC, this.optionD, this.answer, this.photo);
}

List<Question> questions = [
  Question("Not a member of Avenger ", 'Ironman','Spiderman', 'Thor', 'Hulk Hogan', 'Hulk Hogan', "https://static1.colliderimages.com/wordpress/wp-content/uploads/2023/02/avengers-the-first-avenger-mcu.jpeg"),
  Question("Not a member of Teletubbies", 'Dipsy', 'Patrick','Laalaa', 'Poo', 'Patrick', "https://i.ytimg.com/vi/IZtW6mGREhc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAL-rhH7jW0LWfLysL2rAaNGn3V9A"),
  Question("Not a member of justice league", 'batman', 'aquades','superman', 'flash', 'aquades', "https://variety.com/wp-content/uploads/2016/07/justiceleague_photo.jpg"),
  Question("Not a member of BTS", 'Jungkook','Jimin', 'Gong Yoo', 'Suga', 'Gong Yoo', "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWQ4OlWxWBrPpt8xtRwrenu9PpEb6NSZCZvw&s"),
  Question("Not a member of the Power Rangers", 'Red Ranger', 'Blue Ranger', 'Green Ranger', 'Ben 10', 'Ben 10', "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNyuFrH0nsPzer-oFEfY__MHdqApETO7VpLQ&s"), 
  Question("Not a Pokémon", 'Pikachu', 'Charmander', 'Bulbasaur', 'Godzilla', 'Godzilla', "https://news.ncrsport.com/wp-content/uploads/2022/12/TgMW6Z6iDK.jpg"),
  Question("Not a character from Harry Potter", 'Hermione', 'Ron', 'Dobby', 'Gandalf', 'Gandalf', "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3oxiKS-0NgYnsVd-WnpWba052J8DvRWNlVg&s"),
  Question("Not a Disney Princess", 'Cinderella', 'Snow White', 'Elsa', 'Wonder Woman', 'Wonder Woman', "https://imgsrv2.voi.id/f0pZdbmLSZvwUITFTmR4aOMcg1hP_8SRyC_V_ap9H6Q/auto/1200/675/sm/1/bG9jYWw6Ly8vcHVibGlzaGVycy80MTkxNjgvMjAyNDA5MjQxNTA1LW1haW4uY3JvcHBlZF8xNzI3MTY4NTcyLmpwZWc.jpg"),
  Question("Not a football player", 'Messi', 'Ronaldo', 'Neymar', 'John Cena', 'John Cena', "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkBjHi_9nXpYAI9SSfTVl9hbluKfQbpvO5uQ&s"),
  Question("Not a Marvel character", 'Iron Man', 'Captain America', 'Loki', 'Shrek', 'Shrek', "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh9JRD9V2w7tnNqL16nYpf3GWEGUJajlSVwQ&s"),
  Question("Not a DC Comics character", 'Batman', 'Superman', 'Joker', 'Optimus Prime', 'Optimus Prime', "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0uP2peXtiSKb-H6Jr6i74mE1hGF3RBggSTw&s"),
  Question("Not a character from SpongeBob SquarePants", 'SpongeBob', 'Patrick', 'Squidward', 'Mickey Mouse', 'Mickey Mouse', "https://img10.hotstar.com/image/upload/f_auto/sources/r1/cms/prod/2159/1736416462159-i"),
  Question("Not a video game character", 'Mario', 'Sonic', 'Lara Croft', 'Sherlock Holmes', 'Sherlock Holmes', "https://cdn.mos.cms.futurecdn.net/krniDkpHJKbzdmM3bBCzeK-1200-80.jpg"),
  Question("Not a member of BLACKPINK", 'Jisoo', 'Lisa', 'Jennie', 'IU', 'IU',"https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/20240809_Blackpink_Pink_Carpet_09.png/1200px-20240809_Blackpink_Pink_Carpet_09.png")
];
int question_no = 0;
int point = 0;

int maxQuestionNo = 5;

List<Question> getQuestions() {
  List<Question> temp = List.from(questions)..shuffle();

  return temp.take(5).toList();
}

// List<Question> getQuestions() {
//   // List<Question> _questions = [];
//   _questions.add(Question("Not a member of Avenger ", 'Ironman','Spiderman', 'Thor', 'Hulk Hogan', 'Hulk Hogan'));
//   _questions.add(Question("Not a member of Teletubbies", 'Dipsy', 'Patrick','Laalaa', 'Poo', 'Patrick'));
//   _questions.add(Question("Not a member of justice league", 'batman', 'aquades','superman', 'flash', 'aquades'));
//   _questions.add(Question("Not a member of BTS", 'Jungkook','Jimin', 'Gong Yoo', 'Suga', 'Gong Yoo'));

//   return _questions;
// }