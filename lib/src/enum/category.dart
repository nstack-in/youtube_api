// Based on this list: https://gist.github.com/dgp/1b24bf2961521bd75d6c
import 'package:collection/collection.dart';

enum Category {
  autosAndVehicles(2),
  filmAndAnimation(1),
  music(10),
  petsAndAnimals(15),
  sports(17),
  shortMovies(18),
  travelAndEvents(19),
  gaming(20),
  videoblogging(21),
  peopleAndBlogs(22),
  comedy(23),
  entertainment(24),
  newsAndPolitics(25),
  howToAndStyle(26),
  education(27),
  scienceAndTechnology(28),
  nonprofitsAndActivism(29),
  movies(30),
  animeAndAnimation(31),
  actionAndAdventure(32),
  classics(33),
  comedy2(34),
  documentary(35),
  drama(36),
  family(37),
  foreign(38),
  horror(39),
  scifiAndFantasy(40),
  thriller(41),
  shorts(42),
  shows(43),
  trailers(44);

  const Category(this.categoryId);

  final int categoryId;

  static Category? fromCategoryId(int id) =>
      Category.values.firstWhereOrNull((e) => e.categoryId == id);
}
