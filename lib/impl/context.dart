class Context {
  static bool serverConnectionFailed = false;
  static Map<String, dynamic> toJson() {
    return {'serverConnectionFailed': serverConnectionFailed};
  }
}
