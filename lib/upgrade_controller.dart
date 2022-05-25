// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:ota_update/ota_update.dart';

class UpgradeController extends GetxController {
  RxInt progress = 0.obs;
  RxString message = ''.obs;
  final String url = 'http://192.168.1.64:8080/app-release.apk';
  // comando para gerar checksum no terminal linx: sha256sum app-release.apk
  final String checksum =
      "68252f5a9b3c646908ff3f61e390d7568cee95afbaeeef92cc5be59124b3e998";

  void upgrade() async {
    try {
      OtaUpdate()
          .execute(
            url,
            destinationFilename: 'app-release.apk',
            sha256checksum: checksum,
          )
          .listen((OtaEvent event) => _handleStatus(event));
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }

  void _handleStatus(OtaEvent event) {
    switch (event.status.toString()) {
      case 'OtaStatus.DOWNLOADING':
        message.value = 'Baixando';
        progress.value = int.parse(event.value.toString());
        update();
        break;
      case 'OtaStatus.INSTALLING':
        message.value = 'Instalando';
        update();
        break;
      case 'OtaStatus.ALREADY_RUNNING_ERROR':
        message.value = 'Erro';
        update();
        break;
      case 'OtaStatus.PERMISSION_NOT_GRANTED_ERROR':
        message.value = 'Permissão não garantida';
        update();
        break;
      case 'OtaStatus.INTERNAL_ERROR':
        message.value = 'Erro interno';
        update();
        break;
      case 'OtaStatus.DOWNLOAD_ERROR':
        message.value = 'Erro no download';
        update();
        break;
      case 'OtaStatus.CHECKSUM_ERROR':
        message.value = 'Erro de checksum';
        update();
        break;
      default:
    }
  }
}
