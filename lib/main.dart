import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prestaciones_unitec/components/TextBox.dart';

import './components/TextDate.dart';
import './components/TextBox.dart';
import 'components/DropDown.dart';

class Salarios {
  int? id;
  double? salario;
  double? horas_extras;
  double? comisiones;
  double? bonificaciones;
  double? total;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prestaciones',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.green,
        ),
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.purple)),
      ),
      home: MyLandingPage(),
    );
  }
}

class MyLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Prestaciones')),
      body: const Center(child: FormDates()),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Text('Encabezado'),
            )
          ],
        ),
      ),
    );
  }
}

class FormDates extends StatefulWidget {
  const FormDates({Key? key}) : super(key: key);
  @override
  _FormDatesState createState() => _FormDatesState();
}

class _FormDatesState extends State<FormDates> {
  final List<String> _ReasonsQuit = [
    'Despido',
    'Renuncia',
    'Muerte Natural',
    'Calculo Por auxilio Cesantía'
  ];
  String _name = "";
  String _identidad = "";
  String _motivoSalida = "";
  String _fechaIngreso = "";
  String _fechaSalida = "";

  List<Salarios> _salarios = [];

  void _SalariosOnAdd(value) {
    _salarios.add(value);
    setState(() {});
  }

  void _SalariosOnDelete(value) {
    _salarios.removeWhere((element) => element.id = value.id);
    setState(() {});
  }

  void _SalariosOnEdit(value) {
    Salarios _temporal =
        _salarios.firstWhere((element) => element.id = value.id);
    _salarios.removeWhere((element) => element.id = value.id);
/*    _salarios.insert(_temporal.id, _temporal);*/
    setState(() {});
  }

  void _fechaSalidaHandler(value) {
    _fechaSalida = value;
    setState(() {});
  }

  void _fechaIngresoHandler(value) {
    _fechaIngreso = value;
    setState(() {});
  }

  void _motivoSalidaHandler(value) {
    _motivoSalida = value;
    setState(() {});
  }

  void _identidadHandler(value) {
    _identidad = value;
    setState(() {});
  }

  void _nameHandler(value) {
    _name = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    void _showModalSalarios() {
      double _salario = 0.00;
      double _horas_extras = 0.00;
      double _bonificaciones = 0.00;
      double _comisiones = 0.00;
      double _total = 0.00;

      void _totalHandler() {
        print("AQUI TOTAL HANDLER");
        _total = _salario + _horas_extras + _comisiones + _bonificaciones;
      }

      void _salarioHandler(value) {
        print("ANTES DE SALARIO");
        _salario = value;
        _totalHandler();
        setState(() {});
      }

      void _horas_extrasHandler(value) {
        _horas_extras = value;
        _totalHandler();
        setState(() {});
      }

      void _bonificacionesHandler(value) {
        _bonificaciones = value;
        _totalHandler();
        setState(() {});
      }

      void _comisionesHandler(value) {
        _comisiones = value;
        _totalHandler();
        setState(() {});
      }

      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: Column(
                  children: [
                    Text(
                      'Salarios',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    TextBox(
                      label: 'Salario',
                      text: '$_salario',
                      keyboardType: TextInputType.number,
                      valueHandler: _salarioHandler,
                    ),
                    TextBox(
                      label: 'Horas Extras',
                      text: '$_horas_extras',
                      valueHandler: _horas_extrasHandler,
                      keyboardType: TextInputType.number,
                    ),
                    TextBox(
                      label: 'Bonificaciones',
                      text: '$_bonificaciones',
                      valueHandler: _bonificacionesHandler,
                      keyboardType: TextInputType.number,
                    ),
                    TextBox(
                      label: 'Comisiones',
                      text: '$_comisiones',
                      valueHandler: _comisionesHandler,
                      keyboardType: TextInputType.number,
                    ),
                    Text(
                      '$_total',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return ListView(padding: const EdgeInsets.all(10), children: <Widget>[
      TextBox(
        label: 'Nombre',
        text: _name,
        valueHandler: _nameHandler,
      ),
      TextBox(
        label: 'Identidad',
        text: _identidad,
        valueHandler: _identidadHandler,
      ),
      DropDown(
        label: 'Motivo salida',
        items: _ReasonsQuit,
        valueHandler: _motivoSalidaHandler,
      ),
      TextDate(
          label: 'Fecha ingreso',
          text: _fechaIngreso,
          valueHandler: _fechaIngresoHandler),
      TextDate(
          label: 'Fecha salida',
          text: _fechaSalida,
          valueHandler: _fechaSalidaHandler),
      Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              'Salarios',
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Ink(
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.green,
                ),
                child: SizedBox(
                  height: 32.0,
                  width: 32.0,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => {_showModalSalarios()},
                    icon: const Icon(Icons.add),
                    iconSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: DataTable(
              columnSpacing: 10,
              columns: [
                DataColumn(
                    label: Container(
                  width: 10,
                  child: Text("#"),
                )),
                DataColumn(
                    label: Container(
                      width: 70,
                      child: Text("Salario"),
                    ),
                    numeric: true),
                DataColumn(label: Text("Horas extras")),
                DataColumn(label: Text("Bonificaciones")),
                DataColumn(label: Text("Comisiones")),
                DataColumn(label: Text("Total")),
              ],
              rows: [
                DataRow(
                  onLongPress: () => {print('presiono largo')},
                  cells: [
                    DataCell(Text("1")),
                    DataCell(Text("12,030.00")),
                    DataCell(Text("2,000.00")),
                    DataCell(Text("12.00")),
                    DataCell(Text("0.00")),
                    DataCell(Text("15,340.0")),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
