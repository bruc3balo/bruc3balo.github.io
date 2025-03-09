import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openStringUri(
  String uri, {
  String? webViewName,
  LaunchMode launchMode = LaunchMode.platformDefault,
  WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
}) async {
  debugPrint("Launching URL");
  try {
    Uri u = Uri.parse(uri);
    return openUri(
      u,
      webViewName: webViewName,
      launchMode: launchMode,
      webViewConfiguration: webViewConfiguration,
    );
  } catch (e) {
    return false;
  }
}

Future<bool> openUri(
  Uri uri, {
  String? webViewName,
  LaunchMode launchMode = LaunchMode.platformDefault,
  WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
}) async {
  debugPrint("Launching URL");
  try {
    bool canLaunch = await canLaunchUrl(uri);
    if (!canLaunch) return false;
    return await launchUrl(
      uri,
      mode: launchMode,
      webViewConfiguration: webViewConfiguration,
      webOnlyWindowName: webViewName,
    );
  } catch (e) {
    return false;
  }
}

Future<bool> sendEmail({
  required String subject,
  required String brief,
  required String email,
}) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {
      'subject': subject,
      'body': brief,
    },
  );
  return openUri(emailUri);
}
