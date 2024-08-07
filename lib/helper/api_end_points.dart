class ApiEndPoints {
  static const String BASE_LINK = "http://20.197.8.32/"; //prod
  // static const String BASE_LINK = "http://192.168.1.254:5000/"; //local

  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String login = 'customer/signin';
  final String warehouse = 'ware-house';
  final String products = 'ware-house/products';
  final String cart = 'cart';
  final String addresses = 'customer/address-list';
  final String placeOrder = 'order';
  final String orderList = 'order/history';
  final String orderDetail = 'order/order-details';
  }