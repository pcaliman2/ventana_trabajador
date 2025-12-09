import 'package:flutter/material.dart';
import 'screens/datos_basicos_page.dart';

const Color kAzulProfundo = Color(0xFF152238);
const Color kAzulSecundario = Color(0xFF1E3A5F);
const Color kDorado = Color(0xFFCFAF6B);

const Color kGrisFondo = Color(0xFFE5E7EB);
const Color kCardFondo = Color(0xFFF8F9FB);

const Color kGrisBorde = Color(0xFFD1D5DB);
const Color kGrisDeshabilitado = Color(0xFFE5E7EB);

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

  // ====== MATERIALES ======
  final Map<String, MaterialInfo> _materiales = const {
    'Acero': MaterialInfo(tipoPrecio: 'Regular', precioKg: 12.50),
    'Cobre': MaterialInfo(tipoPrecio: 'Premium', precioKg: 25.00),
    'Aluminio': MaterialInfo(tipoPrecio: 'Regular', precioKg: 8.75),
  };

  String _materialSeleccionado = 'Acero';

  // ====== CONTROLADORES PESAJES ======
  late TextEditingController _pesoBrutoCtrl;
  late TextEditingController _tierraCtrl;
  late TextEditingController _humedadCtrl;
  late TextEditingController _basuraCtrl;
  late TextEditingController _pesoNetoCtrl;

  // ====== FECHA REGISTRO ======
  DateTime? _fechaRegistro;
  late TextEditingController _fechaCtrl;

  @override
  void initState() {
    super.initState();

    _pesoBrutoCtrl = TextEditingController(text: '0.00');
    _tierraCtrl = TextEditingController(text: '0.00');
    _humedadCtrl = TextEditingController(text: '0.00');
    _basuraCtrl = TextEditingController(text: '0.00');
    _pesoNetoCtrl = TextEditingController(text: '0.00');

    _fechaCtrl = TextEditingController();
    // Si quieres iniciar con hoy:
    // _fechaRegistro = DateTime.now();
    // _fechaCtrl.text = _formatDate(_fechaRegistro!);

    _recalcularPesoNeto();
  }

  @override
  void dispose() {
    _pesoBrutoCtrl.dispose();
    _tierraCtrl.dispose();
    _humedadCtrl.dispose();
    _basuraCtrl.dispose();
    _pesoNetoCtrl.dispose();
    _fechaCtrl.dispose();
    super.dispose();
  }

  // ====== HELPERS NUMÉRICOS Y FECHA ======
  double _parse(String s) => double.tryParse(s.replaceAll(',', '.')) ?? 0.0;

  String _formatDate(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString();
    return '$dd/$mm/$yyyy';
  }

  void _recalcularPesoNeto() {
    final bruto = _parse(_pesoBrutoCtrl.text);
    final tierra = _parse(_tierraCtrl.text);
    final humedad = _parse(_humedadCtrl.text);
    final basura = _parse(_basuraCtrl.text);

    final neto = bruto - (tierra + humedad + basura);
    _pesoNetoCtrl.text = neto.toStringAsFixed(2);

    setState(() {}); // refresca Materiales y Resumen
  }

  Future<void> _seleccionarFecha() async {
    final hoy = DateTime.now();
    final seleccionada = await showDatePicker(
      context: context,
      initialDate: _fechaRegistro ?? hoy,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (seleccionada != null) {
      setState(() {
        _fechaRegistro = seleccionada;
        _fechaCtrl.text = _formatDate(seleccionada);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  // ============================================================
  // BLOQUE 1: DATOS GENERALES
  // ============================================================

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

            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: const [
                SizedBox(
                  width: 220,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Placa'),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                ),
                SizedBox(
                  width: 220,
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

  // ============================================================
  // BLOQUE 2: MATERIALES (tabla sin scroll horizontal)
  // ============================================================

  Widget _buildMaterialsSection() {
    final info = _materiales[_materialSeleccionado]!;
    final kilosTotales = _parse(_pesoNetoCtrl.text);
    final importe = info.precioKg * kilosTotales;

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
              children: [
                Expanded(
                  flex: 2,
                  child: _DropdownCell(
                    value: _materialSeleccionado,
                    options: _materiales.keys.toList(),
                    onChanged: (nuevo) {
                      if (nuevo == null) return;
                      setState(() {
                        _materialSeleccionado = nuevo;
                      });
                    },
                  ),
                ),
                Expanded(flex: 2, child: _ValueCell(info.tipoPrecio)),
                Expanded(
                  flex: 2,
                  child: _ValueCell(info.precioKg.toStringAsFixed(2)),
                ),
                Expanded(
                  flex: 2,
                  child: _ValueCell(kilosTotales.toStringAsFixed(2)),
                ),
                Expanded(
                  flex: 2,
                  child: _ValueCell(importe.toStringAsFixed(2)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BLOQUE 3: DETALLE DE PESAjes (inputs, sin scroll horizontal)
  // ============================================================

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
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _InputCell(
                    controller: _pesoBrutoCtrl,
                    onChanged: (_) => _recalcularPesoNeto(),
                  ),
                ),
                Expanded(
                  child: _InputCell(
                    controller: _tierraCtrl,
                    onChanged: (_) => _recalcularPesoNeto(),
                  ),
                ),
                Expanded(
                  child: _InputCell(
                    controller: _humedadCtrl,
                    onChanged: (_) => _recalcularPesoNeto(),
                  ),
                ),
                Expanded(
                  child: _InputCell(
                    controller: _basuraCtrl,
                    onChanged: (_) => _recalcularPesoNeto(),
                  ),
                ),
                Expanded(
                  child: _InputCell(controller: _pesoNetoCtrl, readOnly: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BLOQUE 4: FECHA + FOTO + RESUMEN DINÁMICO
  // ============================================================

  Widget _buildBottomSection() {
    final bruto = _parse(_pesoBrutoCtrl.text);
    final tierra = _parse(_tierraCtrl.text);
    final humedad = _parse(_humedadCtrl.text);
    final basura = _parse(_basuraCtrl.text);
    final neto = _parse(_pesoNetoCtrl.text);

    final descuentos = tierra + humedad + basura;
    final precioKg = _materiales[_materialSeleccionado]!.precioKg;
    final importeTotal = precioKg * neto;

    return Card(
      elevation: 3,
      color: kCardFondo,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Columna izquierda: fecha + foto
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
                  TextField(
                    controller: _fechaCtrl,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'dd/mm/aaaa',
                      suffixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    onTap: _seleccionarFecha,
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
            // Columna derecha: resumen
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _SummaryRow('Kilos brutos totales', bruto.toStringAsFixed(2)),
                  const SizedBox(height: 4),
                  _SummaryRow(
                    'Descuentos totales',
                    descuentos.toStringAsFixed(2),
                  ),
                  const SizedBox(height: 4),
                  _SummaryRow('Kilos netos totales', neto.toStringAsFixed(2)),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Importe total',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      importeTotal.toStringAsFixed(2),
                      style: const TextStyle(
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

  // ============================================================
  // BLOQUE 5: BOTONES FINALES
  // ============================================================

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

// ============================================================
// MODELO MATERIAL
// ============================================================

class MaterialInfo {
  final String tipoPrecio;
  final double precioKg;

  const MaterialInfo({required this.tipoPrecio, required this.precioKg});
}

// ============================================================
// WIDGETS AUXILIARES
// ============================================================

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: const BoxDecoration(
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
        Text(label, style: const TextStyle(fontSize: 13)),
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

class _DropdownCell extends StatelessWidget {
  final String value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const _DropdownCell({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGrisBorde)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          items: options
              .map(
                (m) => DropdownMenuItem(
                  value: m,
                  child: Text(m, style: const TextStyle(fontSize: 13)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _InputCell extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  const _InputCell({
    required this.controller,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGrisBorde)),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
        ),
        style: const TextStyle(fontSize: 13),
        onChanged: onChanged,
      ),
    );
  }
}
