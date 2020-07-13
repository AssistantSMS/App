class AppImage {
  static const String base = 'assets/img/';
  static const String rating = 'rating/';
  static const String tile = 'tile/';
  static const String raid = 'raid/';

  static const String dark = 'dark/';
  static const String light = 'light/';

  static const String drawer = base + 'drawerHeader.png';
  static const String steamNewsDefault = base + 'steamNewsDefault.jpg';
  static const String dimensionsCube = base + 'dimensionsCube.png';
  static const String dimensionsCylinder = base + 'dimensionsCylinder.png';

  static String _darkLightFolder(bool isDark) => isDark ? dark : light;
  static String buoyancy(bool isDark) =>
      base + rating + _darkLightFolder(isDark) + 'buoyancy.png';
  static String durability(bool isDark) =>
      base + rating + _darkLightFolder(isDark) + 'durability.png';
  static String flammable(bool isDark) =>
      base + rating + _darkLightFolder(isDark) + 'flammable.png';
  static String friction(bool isDark) =>
      base + rating + _darkLightFolder(isDark) + 'friction.png';
  static String weight(bool isDark) =>
      base + rating + _darkLightFolder(isDark) + 'weight.png';

  static const String block = base + tile + 'block.png';
  static const String cookingTile = base + tile + 'cooking.png';
  static const String craftTile = base + tile + 'craft.png';
  static const String dressTile = base + tile + 'dress.png';
  static const String raidTile = base + tile + 'raid.png';
  static const String refinerTile = base + tile + 'refiner.png';
  static const String resourceTile = base + tile + 'resource.png';
  static const String traderTile = base + tile + 'trader.png';
  static const String workshopTile = base + tile + 'workshop.png';

  static const String customLoading = base + 'loading.png';
  static const String translate = base + 'translate.png';

  static const String totebot = base + raid + 'totebot.png';
  static const String haybot = base + raid + 'haybot.png';
  static const String tapebot = base + raid + 'tapebot.png';
  static const String farmbot = base + raid + 'farmbot.png';
}
