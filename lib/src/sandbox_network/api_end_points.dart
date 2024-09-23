
class ApiEndPoints {
  static const String _segmentUrl = "api";
  static const String _versionUrl = "v1";

  static String get baseUrl =>
      'https://basgate-sandbox.com/$_segmentUrl/$_versionUrl/mobile/';

  static const String fetchAuth ='fetchAuth';
  static const String payment ='payment';
}
