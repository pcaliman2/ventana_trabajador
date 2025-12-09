import 'package:flutter/material.dart';
import '../widgets/datos_basicos_form.dart';

// Importa tus colores
import '../main.dart'; // Asegúrate que este contiene los kAzulProfundo, etc.

class DatosBasicosPage extends StatelessWidget {
  DatosBasicosPage({super.key});

  final TextEditingController nombreCtrl = TextEditingController();
  final TextEditingController placaCtrl = TextEditingController();
  final TextEditingController telefonoCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrisFondo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kAzulProfundo,
        title: const Text('Datos básicos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          color: kCardFondo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // --- FORMULARIO ---
                DatosBasicosForm(
                  nombreCtrl: nombreCtrl,
                  placaCtrl: placaCtrl,
                  telefonoCtrl: telefonoCtrl,
                  emailCtrl: emailCtrl,
                ),

                const SizedBox(height: 24),

                // --- BOTONES ---
                Row(
                  children: [
                    // CANCELAR
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: kAzulSecundario),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: kAzulSecundario),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // ACEPTAR
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kAzulSecundario,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.pop(context, {
                            'nombre': nombreCtrl.text,
                            'placa': placaCtrl.text,
                            'telefono': telefonoCtrl.text,
                            'email': emailCtrl.text,
                          });
                        },
                        child: const Text('Aceptar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
