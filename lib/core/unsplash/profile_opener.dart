import 'package:url_launcher/url_launcher.dart';

Future<void> launchUnsplashUrl(String unsplashUrl) async {
  if (!await launchUrl(Uri.parse(unsplashUrl))) {
    throw Exception('Could not launch $unsplashUrl');
  }
}