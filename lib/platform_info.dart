import 'package:flutter/material.dart';

class DefinePlatform extends StatelessWidget {
  final Widget widget;

  const DefinePlatform({
    Key? key,
    required this.widget,
  }) : super(key: key);

  static bool isMacOS(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    return platform.name == 'macOS' ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    if (platform.name == 'macOS') {
      return const CustomAlertWidget();
    }
    return widget;
  }
}

class CustomAlertWidget extends StatelessWidget {
  const CustomAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              focusColor: Colors.amber,
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: const Text(
                        'Snif',
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 75.0, 0.0, 0.0),
                      child: const Text(
                        'Platform Unsupported yet',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(325.0, 110.0, 0.0, 0.0),
                      child: const Text(
                        'Click to back',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(430.0, 45.0, 0.0, 0.0),
                      child: const Text(
                        '\u00A1',
                        style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
