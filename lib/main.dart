import 'package:flutter/material.dart';

void main() {
  runApp(const WeighingApp());
}

class WeighingApp extends StatelessWidget {
  const WeighingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nueva nota de pesaje',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF3F5F9), // gris-azulado suave
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F6FE5), // azul corporativo
          brightness: Brightness.light,
        ),
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFFF3F5F9),
          foregroundColor: Colors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD0D5DD)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF1F6FE5), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          labelStyle: const TextStyle(color: Color(0xFF4B5563)),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: const Color(0xFF1F6FE5)),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFD0D5DD)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1F6FE5),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      home: const WeighingNotePage(),
    );
  }
}

class WeighingNotePage extends StatefulWidget {
  const WeighingNotePage({super.key});

  @override
  State<WeighingNotePage> createState() => _WeighingNotePageState();
}

class _WeighingNotePageState extends State<WeighingNotePage> {
  String tipo = 'COMPRA';
  String sucursal = 'Sucursal A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nueva nota de pesaje',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeaderSection(),
              const SizedBox(height: 16),
              _buildMaterialsSection(),
              const SizedBox(height: 16),
              _buildWeighingDetailSection(),
              const SizedBox(height: 16),
              _buildBottomSection(),
              const SizedBox(height: 24),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  // BLOQUE 2: Datos generales
  Widget _buildHeaderSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tipo / Sucursal
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: tipo,
                    decoration: const InputDecoration(labelText: 'Tipo'),
                    items: const [
                      DropdownMenuItem(value: 'COMPRA', child: Text('COMPRA')),
                      DropdownMenuItem(value: 'VENTA', child: Text('VENTA')),
                    ],
                    onChanged: (v) => setState(() => tipo = v ?? tipo),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: sucursal,
                    decoration: const InputDecoration(labelText: 'Sucursal'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Sucursal A',
                        child: Text('Sucursal A'),
                      ),
                      DropdownMenuItem(
                        value: 'Sucursal B',
                        child: Text('Sucursal B'),
                      ),
                    ],
                    onChanged: (v) => setState(() => sucursal = v ?? sucursal),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Identificación del Trabajador
            const TextField(
              decoration: InputDecoration(
                labelText: 'Identificación del Trabajador',
              ),
            ),
            const SizedBox(height: 16),

            // Proveedor / Cliente
            Row(
              children: const [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Proveedor'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Cliente'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Placa / email / Teléfono + Capturar datos básicos
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Placa'),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'email'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Teléfono'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Capturar datos básicos',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // BLOQUE 3: Materiales
  Widget _buildMaterialsSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Encabezados
            Row(
              children: const [
                Expanded(flex: 2, child: _HeaderCell('Material')),
                Expanded(flex: 2, child: _HeaderCell('Tipo de precio compra')),
                Expanded(flex: 2, child: _HeaderCell('Precio compra/kg')),
                Expanded(flex: 2, child: _HeaderCell('Kilos totales')),
                Expanded(flex: 2, child: _HeaderCell('Importe total')),
              ],
            ),
            const SizedBox(height: 8),
            // Fila de datos (ejemplo)
            Row(
              children: const [
                Expanded(flex: 2, child: _ValueCell('Acero')),
                Expanded(flex: 2, child: _ValueCell('Regular')),
                Expanded(flex: 2, child: _ValueCell('12.50')),
                Expanded(flex: 2, child: _ValueCell('500.00')),
                Expanded(flex: 2, child: _ValueCell('6250.00')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // BLOQUE 4: Detalle de pesajes del material
  Widget _buildWeighingDetailSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detalle de pesajes del material',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            // Encabezados
            Row(
              children: const [
                Expanded(child: _HeaderCell('Peso bruto (kg)')),
                Expanded(child: _HeaderCell('Tierra (kg)')),
                Expanded(child: _HeaderCell('Humedad (kg)')),
                Expanded(child: _HeaderCell('Basura (kg)')),
                Expanded(child: _HeaderCell('Peso neto (kg)')),
                SizedBox(width: 110), // espacio para botón Examinar
              ],
            ),
            const SizedBox(height: 8),
            // Fila de datos (ejemplo)
            Row(
              children: [
                const Expanded(child: _ValueCell('520.00')),
                const Expanded(child: _ValueCell('8.00')),
                const Expanded(child: _ValueCell('5.00')),
                const Expanded(child: _ValueCell('7.00')),
                const Expanded(child: _ValueCell('500.00')),
                SizedBox(
                  width: 110,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Examinar…'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // BLOQUE 5: Fecha + foto + resumen
  Widget _buildBottomSection() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Columna izquierda
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fecha registro',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const TextField(
                    readOnly: true,
                    decoration: InputDecoration(hintText: '24/04/2024'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.upload),
                    label: const Text('Subir foto'),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFE5E7EB),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Foto balanza',
                      style: TextStyle(color: Color(0xFF4B5563)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Columna derecha
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  _SummaryRow('Kilos brutos totales', '520.00'),
                  SizedBox(height: 4),
                  _SummaryRow('Descuentos totales', '20.00'),
                  SizedBox(height: 4),
                  _SummaryRow('Kilos netos totales', '500.00'),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Importe total',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '6250.00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BLOQUE 6: Botones finales
  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('Guardar en borrador'),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('Enviar a revisión'),
            ),
          ),
        ),
      ],
    );
  }
}

// Widgets auxiliares para celdas y resumen

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: Color(0xFF111827),
      ),
    );
  }
}

class _ValueCell extends StatelessWidget {
  final String text;
  const _ValueCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD0D5DD)),
      ),
      child: Text(text, style: const TextStyle(color: Color(0xFF111827))),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF111827))),
        Text(value, style: const TextStyle(color: Color(0xFF111827))),
      ],
    );
  }
}
