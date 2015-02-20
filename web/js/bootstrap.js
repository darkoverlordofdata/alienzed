// Generated by CoffeeScript 1.8.0

/*
 * callback from the web view with state
 */
var Boot, Game, Splash, game, game_start;

game_start = function() {
  return game.eraseSplash();
};

Game = (function() {
  Game.prototype.VERSION = '0.0.36';

  Game.prototype.width = 320;

  Game.prototype.height = 512;

  Game.prototype.base = 'app/packages/alienzone/res/';

  Game.prototype.objects = [];

  Game.prototype.game = Phaser.Game;

  function Game() {
    this.objects = [];
    this.game = new Phaser.Game(this.width, this.height, Phaser.CANVAS, "");
    this.game.state.add("Boot", new Boot(this, this.game));
    this.game.state.add("Splash", new Splash(this, this.game));
    this.game.state.start("Boot");
    Cocoon.App.WebView.on('load', {
      success: function() {
        return Cocoon.App.showTheWebView(0, 0, window.innerWidth * window.devicePixelRatio, window.innerHeight * window.devicePixelRatio);
      },
      error: function() {
        return console.log(JSON.stringify(arguments));
      }
    });
    Cocoon.App.loadInTheWebView("app/index.html");
  }

  Game.prototype.eraseSplash = function() {
    var obj, _i, _len, _ref, _results;
    _ref = this.objects;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      obj = _ref[_i];
      this.game.add.tween(obj).to({
        alpha: 0
      }, 2000).start();
      _results.push(window.setTimeout(function() {
        return obj.destroy();
      }, 3000));
    }
    return _results;
  };

  return Game;

})();


/*
 * Boot
 *   Load the logo image,
 *   configure the game
 */

Boot = (function() {
  function Boot(app, game) {
    this.app = app;
    this.game = game;
    console.log('Initialized Class Boot');
  }


  /*
   * load the logo
   */

  Boot.prototype.preload = function() {
    return this.game.load.image('logo', "" + this.app.base + "images/d16a.png");
  };


  /*
   * configure the game
   */

  Boot.prototype.create = function() {
    this.game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
    this.game.scale.pageAlignHorizontally = true;
    this.game.scale.pageAlignVertically = true;
    this.game.scale.setScreenSize(true);
    this.game.physics.startSystem(Phaser.Physics.ARCADE);
    return this.game.state.start("Splash");
  };

  return Boot;

})();


/*
 * Splash
 *   Display the logo splash
 */

Splash = (function() {
  function Splash(app, game) {
    this.app = app;
    this.game = game;
    console.log('Initialized Class Splash');
  }


  /*
   * Load reemaining sprites and text elements
   */

  Splash.prototype.preload = function() {
    var build, copyright, obj, style10, style40, title;
    title = 'Alien Zone';
    copyright = 'Copyright 2014 Dark Overlord of Data';
    build = "Build " + this.app.VERSION;
    style10 = {
      fill: 'yellow',
      font: '10pt opendyslexic'
    };
    style40 = {
      fill: 'orange',
      font: '40pt opendyslexic'
    };
    obj = this.game.add.sprite(this.app.width / 2, this.app.height / 2, 'logo');
    obj.anchor.setTo(0.5, 0.5);
    this.app.objects.push(obj);
    obj = this.game.add.text(this.app.width / 2, 80, title, style40);
    obj.anchor.setTo(0.5);
    this.app.objects.push(obj);
    obj = this.game.add.text(this.app.width / 2, 400, build, style10);
    obj.anchor.setTo(0.5);
    this.app.objects.push(obj);
    obj = this.game.add.text(this.app.width / 2, 480, copyright, style10);
    obj.anchor.setTo(0.5);
    return this.app.objects.push(obj);
  };


  /*
   * Fire the particle emitters, Number One
   * (Say it like you're Patrick Stewart)
   */

  Splash.prototype.create = function() {

    /*
     * star particles
     */

    /*
     * buckyball particles
     */

    /*
     * signal the game to start
     */
    return Cocoon.App.forwardAsync("D16A_WAIT=false;window.dispatchEvent(new CustomEvent('D16A_START'))");
  };

  return Splash;

})();

game = new Game();

//# sourceMappingURL=bootstrap.js.map
