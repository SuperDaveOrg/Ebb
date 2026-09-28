import 'package:url_launcher/url_launcher.dart';

/// Ebb's website and its feedback form.
///
/// Ebb has no internet permission, so it never loads these itself: it hands
/// the address to the phone's browser, and only when someone taps a link.
final Uri websiteUri = Uri.parse('https://ebb.superdavelab.com/');
final Uri feedbackUri = Uri.parse('https://ebb.superdavelab.com/#feedback');

const String websiteLabel = 'ebb.superdavelab.com';

/// Opens [uri] in the browser. False if nothing on the phone could open it.
Future<bool> openInBrowser(Uri uri) async {
  try {
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    return false;
  }
}
