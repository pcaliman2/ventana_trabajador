import 'package:flutter/material.dart';
import 'screens/datos_basicos_page.dart';

const Color kAzulProfundo = Color(0xFF152238);
const Color kAzulSecundario = Color(0xFF1E3A5F);
const Color kDorado = Color(0xFFCFAF6B);

// Gris de fondo corporativo (fondo general de la app)
const Color kGrisFondo = Color(0xFFE5E7EB);

// Bordes / estados
const Color kGrisBorde = Color(0xFFD1D5DB);
const Color kGrisDeshabilitado = Color(0xFFE5E7EB);

// Fondo de los Cards corporativos
const Color kCardFondo = Color(0xFFF8F9FB);

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
        scaffoldBackgroundColor: kGrisFondo,

        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kGrisBorde),
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kGrisDeshabilitado),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kAzulSecundario, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kAzulSecundario,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: kAzulSecundario,
            side: const BorderSide(color: kAzulSecundario),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
  bool proveedorEnabled = true;
  bool clienteEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR CON DEGRADADO
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [kAzulProfundo, Color(0xFF0F1A2E)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Row(
              children: const [
                Icon(Icons.scale, color: kDorado, size: 26),
                SizedBox(width: 8),
                Text(
                  'Nueva nota de pesaje',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeaderSection(context),
            const SizedBox(height: 16),
            _buildMaterialsSection(),
            const SizedBox(height: 16),
            _buildWeighingDetailSection(),
            const SizedBox(height: 16),
            _buildBottomSection(),
            const SizedBox(height: 16),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  // BLOQUE 1: Datos generales
  Widget _buildHeaderSection(BuildContext context) {
    return Card(
      elevation: 3,
      color: kCardFondo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TÍTULO DEL BLOQUE
            Row(
              children: const [
                Icon(Icons.person_outline, color: kAzulProfundo),
                SizedBox(width: 8),
                Text(
                  'Datos generales',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kAzulProfundo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: kGrisBorde),

            const SizedBox(height: 16),

            // Tipo y Sucursal
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
                    onChanged: (v) {
                      setState(() {
                        tipo = v!;
                        proveedorEnabled = tipo == 'COMPRA';
                        clienteEnabled = tipo == 'VENTA';
                      });
                    },
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
                    onChanged: (v) => setState(() => sucursal = v!),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const TextField(
              decoration: InputDecoration(
                labelText: 'Identificación del trabajador',
              ),
            ),

            const SizedBox(height: 16),

            // PROVEEDOR / CLIENTE
            Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: proveedorEnabled,
                    decoration: InputDecoration(
                      labelText: 'Proveedor',
                      fillColor: proveedorEnabled
                          ? Colors.white
                          : kGrisDeshabilitado,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    enabled: clienteEnabled,
                    decoration: InputDecoration(
                      labelText: 'Cliente',
                      fillColor: clienteEnabled
                          ? Colors.white
                          : kGrisDeshabilitado,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // BOTÓN CAPTURAR DATOS BÁSICOS
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DatosBasicosPage()),
                  );
                },
                icon: const Icon(Icons.person_search, color: kAzulSecundario),
                label: const Text(
                  'Capturar datos básicos',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: kAzulSecundario,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Placa / email / teléfono
            Row(
              children: const [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Placa'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Teléfono'),
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
      color: kCardFondo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
      color: kCardFondo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detalle de pesajes del material',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: kAzulProfundo,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(child: _HeaderCell('Peso bruto (kg)')),
                Expanded(child: _HeaderCell('Tierra (kg)')),
                Expanded(child: _HeaderCell('Humedad (kg)')),
                Expanded(child: _HeaderCell('Basura (kg)')),
                Expanded(child: _HeaderCell('Peso neto (kg)')),
                SizedBox(width: 110),
              ],
            ),
            const SizedBox(height: 8),
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
      color: kCardFondo,
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
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: kAzulProfundo,
                    ),
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
                      color: kGrisFondo,
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
            const Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                        color: kAzulProfundo,
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

// ====== WIDGETS AUXILIARES PARA TABLAS Y RESÚMENES ======

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: kGrisBorde)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: kAzulProfundo,
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGrisBorde)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
      ),
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
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: kAzulProfundo,
          ),
        ),
      ],
    );
  }
}
