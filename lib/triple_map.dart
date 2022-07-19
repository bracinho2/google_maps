import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_maps/controller_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripleMap extends StatefulWidget {
  const TripleMap({Key? key}) : super(key: key);

  @override
  State<TripleMap> createState() => _TripleMapState();
}

class _TripleMapState extends State<TripleMap> {
  @override
  Widget build(BuildContext context) {
    final _mapcontroller = MapController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Google Maps',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: ScopedBuilder.transition(
        store: _mapcontroller,
        transition: (_, child) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: child,
          );
        },
        onLoading: (_) => const Center(child: LinearProgressIndicator()),
        onState: (_, GoogleMap map) => map,
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.amber,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _mapcontroller.getInitialMap();
        print('botao');
      }),
    );
  }
}
