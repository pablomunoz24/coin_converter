import 'package:flutter/material.dart';

class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  // Monedas seleccionadas para convertir de y a
  String fromCurrency = 'COP';
  String toCurrency = 'USD';
  final _coininput = TextEditingController();
  double _convertedValue = 0.0;

  // Lista de monedas
  var items = ['COP', 'USD', 'EUR'];

  // Tasas de conversión de ejemplo
  final Map<String, Map<String, double>> conversionRates = {
    'COP': {'USD': 0.00027, 'EUR': 0.00023},
    'USD': {'COP': 4000.0, 'EUR': 0.85},
    'EUR': {'COP': 4400.0, 'USD': 1.18},
  };

  // Función para realizar la conversión de moneda
  void _convertCurrency() {
    setState(() {
    double input_double=double.tryParse(_coininput.text)?? 0.0;
      if(fromCurrency==toCurrency){
        _convertedValue =input_double;

      }
      else{
        _convertedValue=input_double*(conversionRates [fromCurrency]?[toCurrency]??1.00);

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Converter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              // Primer DropdownButtonFormField para seleccionar la moneda de origen
              DropdownButtonFormField(
                value: fromCurrency,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  labelText: 'Seleccione moneda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: items.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    fromCurrency = newValue!;
                    if (fromCurrency == toCurrency) {
                      // Si se selecciona la misma moneda en ambos menús, cambiar la moneda de destino
                      toCurrency = items.firstWhere((element) => element != fromCurrency);
                    }
                  });
                  _convertCurrency(); // Realizar la conversión después de cambiar la selección
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _coininput,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "Ingrese el valor de la moneda",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _convertCurrency(), // Realizar la conversión al cambiar el valor
              ),
              const SizedBox(
                height: 16.0,
              ),
              // Segundo DropdownButtonFormField para seleccionar la moneda a convertir
              DropdownButtonFormField(
                value: toCurrency,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: InputDecoration(
                  labelText: 'Seleccione moneda a convertir',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: items
                    .where((item) => item != fromCurrency)
                    .map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    toCurrency = newValue!;
                  });
                  _convertCurrency(); // Realizar la conversión después de cambiar la selección
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              // Mostrar el valor convertido
              Text(
                'Valor convertido: $_convertedValue $toCurrency',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
