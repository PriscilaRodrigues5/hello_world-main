import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu mapa',
      home: const MapaPage(),
    );
  }
}

class MapaPage extends StatelessWidget {
  const MapaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu mapa')),

      body: FlutterMap(//componete responsavel pelo mapa
        options: MapOptions(//definição iniciais do mapa
          initialCenter: LatLng(-21.470000, -47.030000), 
          initialZoom: 13,
        ),

        children: [
          TileLayer(//camada de tiles do mapa
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.mapa_flutter',
          ),
        ]
      ),
    );
  }
}