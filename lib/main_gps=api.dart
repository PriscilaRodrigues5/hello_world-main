import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Mapa',
      home: MapaPage(),
    );
  }
}

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Position? posicao;
  final MapController mapaControler = MapController();

  Future<void> buscarLocalizacao() async {
    // Verifica se o serviço de localização está ativo
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if (!servicoAtivo) {
      await Geolocator.openLocationSettings();
      return;
    }

    // Verifica a permissão
    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }

    // Se a permissão foi negada
    if (permissao == LocationPermission.denied ||
        permissao == LocationPermission.deniedForever) {
      return;
    }

    // Pega a localização atual
    Position pos = await Geolocator.getCurrentPosition();

    setState(() {
      posicao = pos;
    });

    // Centraliza o mapa na localização encontrada
    mapaControler.move(
      LatLng(pos.latitude, pos.longitude),
      15.0,
    );

    print('Latitude: ${pos.latitude}');
    print('Longitude: ${pos.longitude}');
  }

  @override
  void initState() {
    super.initState();
    buscarLocalizacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Mapa'),
      ),
      body: FlutterMap(
        mapController: mapaControler,
        options: const MapOptions(
          initialCenter: LatLng(-21.3568364608751, -46.93302746441793),
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.mapa_flutter',
          ),
          if (posicao != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(posicao!.latitude, posicao!.longitude),
                  width: 50,
                  height: 50,
                  child: const Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 160, 17, 232),
                    size: 40,
                  ),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: buscarLocalizacao,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}