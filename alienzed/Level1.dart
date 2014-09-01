/*+--------------------------------------------------------------------+
#| Level1.coffee
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
#
#
# Game Level One
*/
part of alienzed;

class Level1 extends State {

  /**
   * Members
   */
  Sprite background;
  Sprite board;
  Grid grid;
  Sprite startButton;
  var cells           = null;
  var discoveredGems  = null;
  Text text            = null;
  var gemGroup        = null;
  var score           = 0;
  var rnd             = new Random();

  /**
   * == Create the game level
   *   * set the background and game board
   *   * draw the text
   *   * wire up the buttons
   *
   * return none
   */
  create() {

    time.advancedTiming = true;
    score = 0;
    background = add.sprite(0, 0, 'background');
    board = add.sprite(0, 0, 'board');
    board.alpha = 0.7;

    text = add.text(100, 20, "Score: 0", new TextStyle(font: "bold 30px Acme",fill: "#e0e0e0"));
    grid = new Grid(width: 6, height: 7, gravity: 'down');
    discoveredGems = [Alienzed.GEMTYPES[0], Alienzed.GEMTYPES[1], Alienzed.GEMTYPES[2]];

    newGemGroup();
    add.button(  0, 420, 'arrow_left',   leftButton,  this);
    add.button( 50, 420, 'arrow_down',   dropButton,  this);
    add.button(100, 420, 'arrow_right',  rightButton, this);
    add.button(210, 420, 'arrow_lrot',   lrotButton,  this);
    add.button(260, 420, 'arrow_rrot',   rrotButton,  this);
  }
  
  /**
   * Directional Handlers
   *
   * return none
   */
  leftButton(source, input, flag) {
    gemGroup.move(-1);
  }
  
    
  rightButton(source, input, flag) {
    gemGroup.move(1);
  }
    
  lrotButton(source, input, flag) {
    gemGroup.rotate(-1);
  }
    
  rrotButton(source, input, flag) {
    gemGroup.rotate(1);
  }
    
  dropButton(source, input, flag) {
    gemGroup.drop();
    gemGroup = null;
  }


  /**
   * New Gem Group
   *
   * return Gem Group
   */
  newGemGroup() {
    gemGroup = new GemGroup(this);
  }

  /**
   * Handle Matches
   *
   * return none
   */
  handleMatches() {

    var piecesToUpgrade;
    // Get all matches
    // If matches have been found
    var matches = grid.getMatches();
    if (matches != null) {
      // Initialize the array of pieces to upgrade
      piecesToUpgrade = [];
      // Reference to the current game
      // For each match found
      grid.forEachMatch((matchingPieces, type) {
        // Add to score
        addToScore((Alienzed.GEMTYPES.indexOf(type) + 1) * matchingPieces.length);
        // For each match take the first piece to upgrade it
        piecesToUpgrade.add({
          'piece'   : matchingPieces[0],
          'type'    : type
        });
        matchingPieces.forEach((matchingPiece) {
          var gem = matchingPiece.object;
          // Remove gem bitmap from stage
          gem.sprite.destroy();
        });
      });

      // Remove matches and apply Gravity
      grid.clearMatches();
      // Upgrade pieces
      handleUpgrade(piecesToUpgrade);
    }
    handleFalling();
  }

  /**
   ^ Handle Falling
   ^
   ^ return none
   */
  handleFalling() {

    // Apply gravity and get falling Pieces
    var fallingPieces = grid.applyGravity();
    var hasFall;

    if (fallingPieces.length > 0) {
      // Falling counter
      hasFall = 0;
      // For each falling pieces
      fallingPieces.forEach((piece) {
        piece.object.fall(piece.x, piece.y, (Sprite s) {
          hasFall += 1;
          if (hasFall == fallingPieces.length)
            handleMatches();
        });
      });
    } else {
      // Create a new gem if no falling pieces
      newGemGroup();
    }
  }
  /**
   * Handle Upgrade
   *
   * return none
  */
  handleUpgrade(piecesToUpgrade) {

    // For each piece to upgrade
    piecesToUpgrade.forEach((pieceToUpgrade) {
      // Get the upgraded type
      var upgradedType = Alienzed.GEMTYPES[Alienzed.GEMTYPES.indexOf(pieceToUpgrade['type']) + 1];
      // If the type is defined
      if (upgradedType != null) {
        // And if the type is not already discovered
        if (discoveredGems.indexOf(upgradedType) == -1)
          // Push it to discovered gems array
          discoveredGems.add(upgradedType);
      }
    });
  }

  /**
   * Random Gem Type
   *
   * return string - random gem type
   */
  randomGemType() {

    var i = rnd.integerInRange(0, discoveredGems.length-1);
    return discoveredGems[i];
  }

  /**
   * Add to Score
   *
   * return none
   */
  addToScore(points) {
    score += points;
    text.text = "Score: $score";
    text.updateText();
  }

  /**
   * Game Over
   *
   * return none
   */
  gameOver() {
    state.start("GameOver", false, false);
  }

}