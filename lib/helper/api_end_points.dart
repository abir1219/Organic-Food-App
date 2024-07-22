class ApiEndPoints {
  static const String BASE_LINK = "http://20.197.8.32/"; //prod

  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String login = 'customer/signin';
  final String warehouse = 'ware-house';
  final String products = 'ware-house/products';
  final String cart = 'cart';
  }