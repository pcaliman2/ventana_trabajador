import 'package:flutter/material.dart';
import '../widgets/datos_basicos_form.dart';

class DatosBasicosPage extends StatelessWidget {
  DatosBasicosPage({super.key});

  final TextEditingController nombreCtrl = TextEditingController();
  final TextEditingController placaCtrl = TextEditingController();
  final TextEditingController telefonoCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos básicos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DatosBasicosForm(
          nombreCtrl: nombreCtrl,
          placaCtrl: placaCtrl,
          telefonoCtrl: telefonoCtrl,
          emailCtrl: emailCtrl,
        ),
      ),
    );
  }
}
