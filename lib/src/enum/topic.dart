enum Topic {
// **Music topics**
  /// Music (parent topic)
  music('/m/04rlf', parent: true),

  /// Christian music
  cristianMusic('/m/02mscn'),

  /// Classical music
  classicalMusic('/m/0ggq0m'),

  /// Country
  country('/m/01lyv'),

  /// Electronic music
  electronicMusic('/m/02lkt'),

  /// Hip hop music
  hipHopMusic('/m/0glt670'),

  /// Independent music
  independentMusic('/m/05rwpb'),

  /// Jazz
  jazz(r'/m/03\_d0'),

  /// Music of Asia
  musicOfAsia('/m/028sqc'),

  /// Music of Latin America
  musicOfLatinAmerica('/m/0g293'),

  /// Pop music
  popMusic('/m/064t9'),

  /// Reggae
  reggae('/m/06cqb'),

  /// Rhythm and blues
  rhythmAndBlues('/m/06j6l'),

  /// Rock music
  rockMusic('/m/06by7'),

  /// Soul music
  soulMusic('/m/0gywn'),
// **Gaming topics**

  /// Gaming (parent topic)
  gaming('/m/0bzvm2', parent: true),

  /// Action game
  actionGame('/m/025zzc'),

  /// Action-adventure game
  actionAdventureGame('/m/02ntfj'),

  /// Casual game
  casualGame('/m/0b1vjn'),

  /// Music video game
  musicVideoGame('/m/02hygl'),

  /// Puzzle video game
  puzzleVideoGame('/m/04q1x3q'),

  /// Racing video game
  racingVideoGame('/m/01sjng'),

  /// Role-playing video game
  rolePlayingVideoGame('/m/0403l3g'),

  /// Simulation video game
  simulationVideoGame('/m/021bp2'),

  /// Sports game
  sportsGame('/m/022dc6'),

  /// Strategy video game
  strategyVideoGame(r'/m/03hf\_rm'),
// **Sports topics**

  /// Sports (parent topic)
  sports('/m/06ntj', parent: true),

  /// American football
  americanFootball(r'/m/0jm\_'),

  /// Baseball
  baseball('/m/018jz'),

  /// Basketball
  basketball('/m/018w8'),

  /// Boxing
  boxing('/m/01cgz'),

  /// Cricket
  cricket(r'/m/09xp\_'),

  /// Football
  football('/m/02vx4'),

  /// Golf
  golf('/m/037hz'),

  /// Ice hockey
  iceHockey('/m/03tmr'),

  /// Mixed martial arts
  mixedMartialArts('/m/01h7lh'),

  /// Motorsport
  motorsport('/m/0410tth'),

  /// Tennis
  tennis('/m/07bs0'),

  /// Volleyball
  volleyball(r'/m/07\_53'),
// **Entertainment topics**

  /// Entertainment (parent topic)
  entertainment('/m/02jjt', parent: true),

  /// Humor
  humor('/m/09kqc'),

  /// Movies
  movies('/m/02vxn'),

  /// Performing arts
  performingArts('/m/05qjc'),

  /// Professional wrestling
  professionalWrestling('/m/066wd'),

  /// TV shows
  tvShows('/m/0f2f9'),

// **Lifestyle topics**

  /// Lifestyle (parent topic)
  lifestyle(r'/m/019\_rr', parent: true),

  /// Fashion
  fashion('/m/032tl'),

  /// Fitness
  fitness('/m/027x7n'),

  /// Food
  food('/m/02wbm'),

  /// Hobby
  hobby('/m/03glg'),

  /// Pets
  pets('/m/068hy'),

  /// Physical attractiveness \[Beauty\]
  beauty('/m/041xxh'),

  /// Technology
  technology('/m/07c1v'),

  /// Tourism
  tourism('/m/07bxq'),

  /// Vehicles
  vehicles('/m/07yv9'),
// **Society topics**

  /// Society (parent topic)
  society('/m/098wr', parent: true),

  /// Business
  business('/m/09s1f'),

  /// Health
  health('/m/0kt51'),

  /// Military
  military('/m/01h6rj'),

  /// Politics
  politics('/m/05qt0'),

  /// Religion
  religion('/m/06bvp'),

// **Other topics**

  /// Knowledge
  knowledge('/m/01k8wb'),
  ;

  const Topic(this.id, {this.parent = false});
  final String id;
  final bool parent;

  Set<Topic>? get children {
    switch (this) {
      case music:
        return {
          cristianMusic,
          classicalMusic,
          country,
          electronicMusic,
          hipHopMusic,
          independentMusic,
          jazz,
          musicOfAsia,
          musicOfLatinAmerica,
          popMusic,
          reggae,
          rhythmAndBlues,
          rockMusic,
          soulMusic,
        };
      case gaming:
        return {
          actionGame,
          actionAdventureGame,
          casualGame,
          musicVideoGame,
          puzzleVideoGame,
          racingVideoGame,
          rolePlayingVideoGame,
          simulationVideoGame,
          sportsGame,
          strategyVideoGame,
        };
      case sports:
        return {
          americanFootball,
          baseball,
          basketball,
          boxing,
          cricket,
          football,
          golf,
          iceHockey,
          mixedMartialArts,
          motorsport,
          tennis,
          volleyball,
        };
      case entertainment:
        return {
          humor,
          movies,
          performingArts,
          professionalWrestling,
          tvShows,
        };
      case lifestyle:
        return {
          fashion,
          fitness,
          food,
          hobby,
          pets,
          beauty,
          technology,
          tourism,
          vehicles,
        };
      case society:
        return {
          business,
          health,
          military,
          politics,
          religion,
        };
      default:
        return null;
    }
  }
}
