class TutoInfo {
  final String name;
  final String desc;
  final String urlImage;

  TutoInfo({required this.urlImage, required this.name, required this.desc});
}

List<TutoInfo> tutos = [
  TutoInfo(
    name: "The player - The Eco-Hero",
    desc:
        "Welcome to Wildrun! Embark oqn an eco-adventure as the mighty Eco-Hero, where you'll leap over obstacles, collect fruits, and recycle waste to restore nature's balance. Are you ready to save the environment and become a champion in this thrilling journey?",
    urlImage: 'assets/images/tutos/play.png',
  ),
  TutoInfo(
    name: "The player - Attack",
    desc:
        "Tap the left side to launch orbs and attack polluting enemies. It takes 2 orbs to kill an enemy.",
    urlImage: 'assets/images/tutos/attack.png',
  ),
  TutoInfo(
    name: "The player - Jump",
    desc:
        "Tap the right side of the screen or use the up arrow to make the Eco-Hero leap over obstacles.",
    urlImage: 'assets/images/tutos/jump.png',
  ),
  TutoInfo(
    name: "The player - Double jump",
    desc:
        "Double jump: Tap the right side of the screen twice or use the up arrow to perform a double jump.",
    urlImage: 'assets/images/tutos/double_jump.png',
  ),
  TutoInfo(
    name: "The fruits - Nature's rewards",
    desc:
        "Fruit collection: Simply walk over a fruit to collect it and gain a life point.",
    urlImage: 'assets/images/tutos/fruit.png',
  ),
  TutoInfo(
    name: "The waste - Recycling to continue",
    desc:
        "Waste collection: Collect and recycle waste to recharge your powers and defeat enemies.",
    urlImage: 'assets/images/tutos/waste.png',
  ),
  TutoInfo(
    name: "The seeds - Nature's rebirth",
    desc:
        "Automatic planting: When you pass by a fertile area indicated by an arrow, the Eco-Hero automatically plants a seed to grow a tree.",
    urlImage: 'assets/images/tutos/plant_tree.png',
  ),
  TutoInfo(
    name: "The birds - Wings of freedom",
    desc:
        "Flying with birds: Approach a bird to receive the ability to fly and reach high areas.",
    urlImage: 'assets/images/tutos/fly.png',
  ),
  TutoInfo(
    name: "The squirrels - Agile gardeners",
    desc:
        "Instant seed generation: Approach a squirrel to receive a seed to plant.",
    urlImage: 'assets/images/tutos/squirrel.png',
  ),
  TutoInfo(
    name: "The wolves - Forces of nature",
    desc:
        "Attack recharge: Approach a wolf, and it will fully recharge your attacks.",
    urlImage: 'assets/images/tutos/wolf.png',
  ),
  TutoInfo(
    name: "The enemies - Smogs and Blubles",
    desc:
        "Fighting pollution: Tap the left side to dissipate smogs and purify slimes.",
    urlImage: 'assets/images/tutos/enemies.png',
  ),
  TutoInfo(
    name: "Challenges for the Eco-Hero",
    desc:
        "As you conclude this tutorial, remember that every action counts in the fight to protect our environment. With your newfound skills as the Eco-Hero, venture forth into the Wildlands, where your dedication to sustainability will make a tangible difference. Let the journey begin, and may your efforts pave the way for a greener, cleaner world!",
    urlImage: 'assets/images/tutos/end.png',
  ),
];
