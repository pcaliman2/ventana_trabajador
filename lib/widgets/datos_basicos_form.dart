import 'package:flutter/material.dart';

class DatosBasicosForm extends StatelessWidget {
  final TextEditingController nombreCtrl;
  final TextEditingController placaCtrl;
  final TextEditingController telefonoCtrl;
  final TextEditingController emailCtrl;

  const DatosBasicosForm({
    super.key,
    required this.nombreCtrl,
    required this.placaCtrl,
    required this.telefonoCtrl,
    required this.emailCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Información básica',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 12),

        // NOMBRE
        TextField(
          controller: nombreCtrl,
          decoration: const InputDecoration(labelText: 'Nombre'),
        ),

        const SizedBox(height: 16),

        // PLACA + TELÉFONO
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: placaCtrl,
                decoration: const InputDecoration(labelText: 'Placa'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: telefonoCtrl,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // EMAIL
        TextField(
          controller: emailCtrl,
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
