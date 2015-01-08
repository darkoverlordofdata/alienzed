/**
 *--------------------------------------------------------------------+
 * system_factory.dart
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

class SystemFactory {

  BaseLevel level;

  SystemFactory(this.level);

//  ArcadePhysicsSystem arcadePhysics()       => new ArcadePhysicsSystem(level);
  ButtonRenderSystem buttonRender()         => new ButtonRenderSystem(level);
  LegendRenderSystem legendRender()         => new LegendRenderSystem(level);
  OptionControlSystem optionControl()       => new OptionControlSystem(level);
  PlayerControlSystem playerControl()       => new PlayerControlSystem(level);
  ScoreRenderSystem scoreRender()           => new ScoreRenderSystem(level);
  SpriteRenderSystem spriteRender()         => new SpriteRenderSystem(level);
  StringRenderSystem stringRender()         => new StringRenderSystem(level);

  /**
   * Mirrors aren't stable in compiled js,
   * so we do this the old-fashioned way.
   */
  Artemis.EntitySystem invoke(String methodName) {
    switch(methodName) {
//      case 'arcadePhysics':     return arcadePhysics(); // *UNUSED*
      case 'buttonRender':      return buttonRender();
      case 'legendRender':      return legendRender();
      case 'optionControl':     return optionControl();
      case 'playerControl':     return playerControl();
      case 'scoreRender':       return scoreRender();
      case 'spriteRender':      return spriteRender();
      case 'stringRender':      return stringRender();
      default:                  return null;
    }
  }
}