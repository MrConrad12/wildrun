import 'package:flame/components.dart';
import 'wildrun.dart';

class CardGame {
  final String name;
  final String desc;
  final Map<TypeTask, int> conditions;
  final String urlImage;
  final player;
  CardGame(
      {this.player,
      required this.urlImage,
      required this.name,
      required this.desc,
      required this.conditions});

  get complete {
    bool completed = true;
    conditions.forEach((key, value) {
      if (player.data.key < value) {
        completed = false;
      }
    });
    return completed;
  }
}

enum TypeTask {
  run,
  animal,
  plant,
  waste,
  enemy,
}

class CardManager extends Component with HasGameReference<WildRun> {
// list of all cards with there data
  List<CardGame> cards = [
    CardGame(
        name: "Planteur expert",
        desc: "Vous etes un vrai planteur",
        urlImage: '',
        conditions: {
          TypeTask.run: 10000,
          TypeTask.animal: 50,
          TypeTask.plant: 500,
          TypeTask.waste: 10,
          TypeTask.enemy: 5,
        }),
    CardGame(
        name: "Echecs",
        desc: "Some description",
        urlImage: '',
        conditions: {
          TypeTask.run: 1000,
          TypeTask.animal: 600,
          TypeTask.plant: 500,
          TypeTask.waste: 0,
          TypeTask.enemy: 0,
        }),
    CardGame(
        name: "Echecs",
        desc: "Some description",
        urlImage: '',
        conditions: {
          TypeTask.run: 1000,
          TypeTask.animal: 600,
          TypeTask.plant: 500,
          TypeTask.waste: 0,
          TypeTask.enemy: 0,
        }),
    CardGame(
        name: "Echecs",
        desc: "Some description",
        urlImage: '',
        conditions: {
          TypeTask.run: 1000,
          TypeTask.animal: 600,
          TypeTask.plant: 500,
          TypeTask.waste: 0,
          TypeTask.enemy: 0,
        }),
    CardGame(
      name: "Echecs",
      desc: "Some description",
      urlImage: '',
      conditions: {
        TypeTask.run: 1000,
        TypeTask.animal: 600,
        TypeTask.plant: 500,
        TypeTask.waste: 0,
        TypeTask.enemy: 0,
      },
    ),
  ];
}
