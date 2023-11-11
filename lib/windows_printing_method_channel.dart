import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:windows_printing/models/printer.dart';

import 'windows_printing_platform_interface.dart';

/// An implementation of [WindowsPrintingPlatform] that uses method channels.
class MethodChannelWindowsPrinting extends WindowsPrintingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('windows_printing');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<Printer>?> getPrinterList() async {
    final List<dynamic>? printerList =
        await methodChannel.invokeMethod('getPrinterList');

    if (printerList != null) { 
      final List<Printer> typedPrinterList =
          printerList.map((e) => Printer.fromMap(e)).toList();

      return typedPrinterList;
    }

    return null;
  }
}
