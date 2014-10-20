/**
 *--------------------------------------------------------------------+
 * Game.dart
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014
 *--------------------------------------------------------------------+
 *
 * This file is a part of Alien Zone
 *
 * Alien Zone is free software; you can copy, modify, and distribute
 * it under the terms of the GPLv3 License
 *
 *--------------------------------------------------------------------+
 *
 */
part of alienzone;

class Game  extends Dilithium {

  static const GEMSIZE    = 48;     // Gem size constant in pixels
  static const MARGINTOP  = 2;      // Margin top equal to 2 gems height
  static final List GEMTYPES = [    // All gem types:
      "blue",
      "cyan",
      "green",
      "magenta",
      "orange",
      "pink",
      "red",
      "yellow"
  ];

  AlienZoneApplication app;
  Li2Template template;

  /**
   * == New Game ==
   *   * Set the screen dimensions
   *   * Configure the game states
   *   * Start the game
   *
   * returns this
   */
  Game(config, this.template): super(config) {

    print("Class Game initialized");
    game.scale.fullScreenScaleMode = ScaleManager.EXACT_FIT;
  }

  /**
   * Define each of the game states
   */
  State levels() {

    game.state.add('Levels',       new Levels(config));
    game.state.add('Credits',      new Credits(config));
    game.state.add('Scores',       new Scores(config));
    game.state.add('Preferences',  new Preferences(config, template));
    game.state.add('GameOver',     new GameOver(config));


    querySelector('body')
      ..setAttribute('class', '')
      ..style.backgroundColor = 'black';

    return new Menu(config);

  }

}
