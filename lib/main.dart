import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrade_teste/upgrade_controller.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTA Upgrad',
      home: Home(),
      defaultTransition: Transition.fade,
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final upgrade = Get.put(UpgradeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTA upgrade'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
                      color: Colors.green,
                      value: (upgrade.progress.value / 100),
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: upgrade.message.value.isNotEmpty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(upgrade.message.value),
                          Text(' ${upgrade.progress.value}%'),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: upgrade.message.value.isEmpty,
                      child: TextButton.icon(
                        onPressed: () => upgrade.upgrade(),
                        icon: const Icon(Icons.download),
                        label: const Text('Upgrade'),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
