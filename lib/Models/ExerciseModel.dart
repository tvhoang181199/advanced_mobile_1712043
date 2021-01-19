import 'dart:convert';

ExerciseModel exerciseModelFromJson(String str) => ExerciseModel.fromJson(json.decode(str));

String exerciseModelToJson(ExerciseModel data) => json.encode(data.toJson());

class ExerciseModel {
  ExerciseModel({
    this.id,
    this.numberQuestion,
    this.title,
    // this.exercisesQuestions,
    // this.usersDoExercises,
  });

  String id;
  int numberQuestion;
  String title;
  // List<ExercisesQuestion> exercisesQuestions;
  // List<UsersDoExercise> usersDoExercises;

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
    id: json["id"],
    numberQuestion: json["numberQuestion"],
    title: json["title"],
    // exercisesQuestions: List<ExercisesQuestion>.from(json["exercises_questions"].map((x) => ExercisesQuestion.fromJson(x))),
    // usersDoExercises: List<UsersDoExercise>.from(json["users_do_exercises"].map((x) => UsersDoExercise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "numberQuestion": numberQuestion,
    "title": title,
    // "exercises_questions": List<dynamic>.from(exercisesQuestions.map((x) => x.toJson())),
    // "users_do_exercises": List<dynamic>.from(usersDoExercises.map((x) => x.toJson())),
  };
}

class ExercisesQuestion {
  ExercisesQuestion({
    this.id,
  });

  String id;

  factory ExercisesQuestion.fromJson(Map<String, dynamic> json) => ExercisesQuestion(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class UsersDoExercise {
  UsersDoExercise({
    this.score,
  });

  int score;

  factory UsersDoExercise.fromJson(Map<String, dynamic> json) => UsersDoExercise(
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "score": score,
  };
}
