import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehículos',
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Usuario: Pepe Perez')),
        ),
        body: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            buildVehicleCard('ERF888', 'Juan Carlos', 'XYZ'),
            buildVehicleCard('ERF888', 'Juan Carlos', 'XYZ'),
            buildVehicleCard('ERF888', 'Juan Carlos', 'XYZ'),
          ],
        ),
      ),
    );
  }

  Widget buildVehicleCard(String placa, String conductor, String empresa) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey,
                 
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Placa: $placa', style: TextStyle(fontSize: 16)),
                    Text('Conductor: $conductor', style: TextStyle(fontSize: 16)),
                    Text('Empresa: $empresa', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Acción del botón
                print('Botón presionado para vehículo $placa');
              },
              child: Text('Ver detalles'),
            )
          ],
        ),
      ),
    );
  }
}
