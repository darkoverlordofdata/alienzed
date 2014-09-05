/*+--------------------------------------------------------------------+
#| Levels.dart
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2014
#+--------------------------------------------------------------------+
#|
#| This file is a part of alienzed
#|
#| alienzed is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# Alien Zed
#
#   Match 3 Style Game
*/
part of alienzed;

class Intro extends State {

  /**
   * Levels
   */
  var level = 1;

  create() {
    add // ui components
      ..sprite(0, 0, 'splashScreen')
      ..button(140, 200, 'playButton', startGame, this)
      ..button(140, 240, 'creditsButton', showCredits, this)
      ..button(140, 280, 'scoreButton', showScores, this);

  }


  startGame(source, input, flag) {
    state.start("Levels", true, false);
  }

  showCredits(source, input, flag) {
    state.start("Credits", true, false);
  }

  showScores(source, input, flag) {
    state.start("Scores", true, false);
  }


}