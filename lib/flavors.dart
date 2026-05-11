enum Flavor {
  dev,
  prod,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Base app Dev';
      case Flavor.prod:
        return 'Base app';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://dev-api.example.com/v1';
      case Flavor.prod:
        return 'https://api.example.com/v1';
    }
  }

  static bool get enableLogging => appFlavor != Flavor.prod;
}
