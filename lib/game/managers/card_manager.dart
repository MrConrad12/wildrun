class CardInfo {
  final String name;
  final String desc;
  final String urlImage;
  final Map<TypeTask, int> conditions;

  CardInfo(
      {required this.urlImage,
      required this.name,
      required this.desc,
      required this.conditions});

  bool _hasDone = false;
  get hasDone => _hasDone;
  set hasDone(value) {
    _hasDone = value;
  }
}

enum TypeTask {
  run,
  animal,
  plant,
  waste,
  enemy,
}

List<CardInfo> cards = [
  CardInfo(
      name: "Coureur de la nature",
      desc: "Some description",
      urlImage: 'images/cards/animal2.jpg',
      conditions: {
        TypeTask.run: 0,
        TypeTask.animal: 0,
        TypeTask.plant: 0,
        TypeTask.waste: 0,
        TypeTask.enemy: 0,
      }),
  CardInfo(
      name: "Echecs",
      desc: "Some description",
      urlImage: 'images/cards/bird2.jpg',
      conditions: {
        TypeTask.run: 0,
        TypeTask.animal: 0,
        TypeTask.plant: 0,
        TypeTask.waste: 0,
        TypeTask.enemy: 0,
      }),
  CardInfo(
    name: "Echecs",
    desc: "Some description",
    urlImage: 'images/cards/CO2.jpg',
    conditions: {
      TypeTask.run: 0,
      TypeTask.animal: 0,
      TypeTask.plant: 0,
      TypeTask.waste: 0,
      TypeTask.enemy: 0,
    },
  ),
  CardInfo(
    name: "Echecs",
    desc: "Some description",
    urlImage: 'images/cards/hog2.jpg',
    conditions: {
      TypeTask.run: 0,
      TypeTask.animal: 0,
      TypeTask.plant: 0,
      TypeTask.waste: 0,
      TypeTask.enemy: 0,
    },
  ),
  CardInfo(
    name: "Echecs",
    desc: "Some description",
    urlImage: 'images/cards/runner2.jpg',
    conditions: {
      TypeTask.run: 0,
      TypeTask.animal: 0,
      TypeTask.plant: 0,
      TypeTask.waste: 0,
      TypeTask.enemy: 0,
    },
  ),
  CardInfo(
    name: "Echecs",
    desc: "Some description",
    urlImage: 'images/cards/tree2.jpg',
    conditions: {
      TypeTask.run: 0,
      TypeTask.animal: 0,
      TypeTask.plant: 0,
      TypeTask.waste: 0,
      TypeTask.enemy: 0,
    },
  ),
  CardInfo(
    name: "Echecs",
    desc: "Some description",
    urlImage: 'images/cards/waste1.jpg',
    conditions: {
      TypeTask.run: 0,
      TypeTask.animal: 0,
      TypeTask.plant: 0,
      TypeTask.waste: 0,
      TypeTask.enemy: 0,
    },
  ),
  CardInfo(
    name: "Echecs",
    desc: "Some description",
    urlImage: 'images/cards/waste2.jpg',
    conditions: {
      TypeTask.run: 0,
      TypeTask.animal: 0,
      TypeTask.plant: 0,
      TypeTask.waste: 0,
      TypeTask.enemy: 0,
    },
  ),
  CardInfo(
    name: "Echecs",
    desc: "Some description",
    urlImage: 'images/cards/wolf1.jpg',
    conditions: {
      TypeTask.run: 0,
      TypeTask.animal: 0,
      TypeTask.plant: 0,
      TypeTask.waste: 0,
      TypeTask.enemy: 0,
    },
  ),
  CardInfo(
    name: "Echecs",
    desc: "Some description",
    urlImage: 'images/cards/wolf4.jpg',
    conditions: {
      TypeTask.run: 0,
      TypeTask.animal: 0,
      TypeTask.plant: 0,
      TypeTask.waste: 0,
      TypeTask.enemy: 0,
    },
  ),
];
