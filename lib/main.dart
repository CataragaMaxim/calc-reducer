import 'dart:math';
import 'package:flutter/material.dart';
import 'theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Reducere',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const CalculatorReducere(),
    );
  }
}

class CalculatorReducere extends StatefulWidget {
  const CalculatorReducere({super.key});

  @override
  State<CalculatorReducere> createState() => _CalculatorReducereState();
}

class _CalculatorReducereState extends State<CalculatorReducere> {
  String _modSelectat = 'Reduceri Standard';
  final List<String> _moduri = [
    'Reduceri Standard',
    'Reduceri Kg',
    'Logaritm',
  ];

  final TextEditingController _pretController = TextEditingController();
  final TextEditingController _procentController = TextEditingController();

  final TextEditingController _pretKgController = TextEditingController();
  final TextEditingController _grameController = TextEditingController();
  final TextEditingController _procentKgController = TextEditingController();

  final TextEditingController _logBazaController = TextEditingController();
  final TextEditingController _logNumarController = TextEditingController();

  String _rezultat1 = '';
  String _rezultat2 = '';
  String _rezultat1Label = 'Valoare reducere:';
  String _rezultat2Label = 'Preț final:';

  void _reseteaza() {
    setState(() {
      _pretController.clear();
      _procentController.clear();
      _pretKgController.clear();
      _grameController.clear();
      _procentKgController.clear();
      _logBazaController.clear();
      _logNumarController.clear();
      _rezultat1 = '';
      _rezultat2 = '';
    });
  }

  void _calculeazaStandart() {
    final pretText = _pretController.text.trim();
    final procentText = _procentController.text.trim();

    if(pretText.isEmpty || procentText.isEmpty) {
      setState(() {
        _rezultat1Label = 'Valoare reducere:';
        _rezultat2Label = 'Pret final:';
        _rezultat1 = 'Completați toate câmpurile!';
        _rezultat2 = '';
      });
      return;
    }

    try {
      final double pret = double.parse(pretText);
      final double procent = double.parse(procentText);

      if (pret < 0 || procent < 0 || procent > 100) {
        setState(() {
          _rezultat1Label = 'Valoare reducere:';
          _rezultat2Label = 'Pret final:';
          _rezultat1 = 'Valori invalide';
          _rezultat2 = '';
        });
        return;
      }

      final double valoareaReducere = pret * (procent / 100);
      final double pretFinal = pret - valoareaReducere;

      setState(() {
        _rezultat1Label = 'Valoare reducere:';
        _rezultat2Label = 'Pret final:';
        _rezultat1 = '${valoareaReducere.toStringAsFixed(2)} lei';
        _rezultat2 = '${pretFinal.toStringAsFixed(2)} lei';
      });
    } catch(e) {
      setState(() {
        _rezultat1 = 'Eroarea la calcul!';
        _rezultat2 = '';
      });
    }
  }

  void _calculeazaKg() {
    final pretKgText = _pretKgController.text.trim();
    final grameText = _grameController.text.trim();
    final procentKgText = _procentKgController.text.trim();

    if (pretKgText.isEmpty || grameText.isEmpty) {
      setState(() {
        _rezultat1Label = 'Pret total:';
        _rezultat2Label = 'Pret final:';
        _rezultat1 = 'Completați toate câmpurile!';
        _rezultat2 = '';
      });
      return;
    }

    try {
      final double pretKg = double.parse(pretKgText);
      final double grame = double.parse(grameText);
      final double procentKg = procentKgText.isEmpty
          ? 0
          : double.parse(procentKgText);

      if (pretKg < 0 || grame < 0 || procentKg < 0 || procentKg > 100) {
        setState(() {
          _rezultat1Label = 'Pret total:';
          _rezultat2Label = 'Pret final:';
          _rezultat1 = 'Valori invalide!';
          _rezultat2 = '';
        });
        return;
      }

      final double kg = grame / 1000;
      final double pretTotal = pretKg * kg;
      final double valoareaReducere = pretTotal * (procentKg/100);
      final double pretFinal = pretTotal - valoareaReducere;

      setState(() {
        if (procentKg == 0) {
          _rezultat1Label = 'Pret initial:';
          _rezultat2Label = 'Preț final ($kg kg):';
          _rezultat1 = '${pretKg.toStringAsFixed(2)} lei';
          _rezultat2 = '${pretFinal.toStringAsFixed(2)} lei';
        } else {
          _rezultat1Label = 'Pret total($kg kg):';
          _rezultat2Label = 'Preț final ($procentKg% reducere):';
          _rezultat1 = '${pretTotal.toStringAsFixed(2)} lei';
          _rezultat2 = '${pretFinal.toStringAsFixed(2)} lei';
        }
      });
    } catch(e) {
      setState(() {
        _rezultat1 = 'Eroare la calcul!';
        _rezultat2 = '';
      });
    }
  }

  void _calculeazaLogaritm() {
    final bazaText = _logBazaController.text.trim();
    final numarText = _logNumarController.text.trim();

    if(bazaText.isEmpty || numarText.isEmpty) {
      setState(() {
        _rezultat1Label = 'Rezultat log:';
        _rezultat2Label = 'Verificare:';
        _rezultat1 = 'Completați toate câmpurile!';
        _rezultat2 = '';
      });
      return;
    }

    try {
      final double baza = double.parse(bazaText);
      final double numar = double.parse(numarText);

      if (baza <= 0 || baza == 1) {
        setState(() {
          _rezultat1Label = 'Rezultat log:';
          _rezultat2Label = 'Verificare:';
          _rezultat1 = 'Baza trebuie > 0 și ≠ 1!';
          _rezultat2 = '';
        });
        return;
      }

      if (numar <= 0) {
        setState(() {
          _rezultat1Label = 'Rezultat log:';
          _rezultat2Label = 'Verificare:';
          _rezultat1 = 'Numarul trebuie > 0!';
          _rezultat2 = '';
        });
        return;
      }

      final double rezultat = log(numar) / log(baza);
      final double verificare = pow(baza, rezultat).toDouble();

      setState(() {
        _rezultat1Label = 'Rezultat log:';
        _rezultat2Label = 'Verificare (baza^rezultat):';
        _rezultat1 = 'log$baza($numar) = ${rezultat.toStringAsFixed(6)}';
        _rezultat2 = verificare.toStringAsFixed(6);
      });
    } catch(e) {
      setState(() {
        _rezultat1 = 'Eroarea la calcul!';
        _rezultat2 = '';
      });
    }
  }

  void _calculeaza() {
    if(_modSelectat == 'Reduceri Standard'){
      _calculeazaStandart();
    } else if (_modSelectat == 'Reduceri Kg') {
      _calculeazaKg();
    } else if (_modSelectat == 'Logaritm') {
      _calculeazaLogaritm();
    }
  }

  @override
  void dispose() {
    _pretController.dispose();
    _procentController.dispose();
    _pretKgController.dispose();
    _grameController.dispose();
    _procentKgController.dispose();
    _logBazaController.dispose();
    _logNumarController.dispose();
    super.dispose();
  }

  Widget _eticheta(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.blancPur,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _campText({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool esteNumar = true,
}) {
    return TextField(
      controller: controller,
      keyboardType: esteNumar
      ? const TextInputType.numberWithOptions(decimal: true)
      : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.bronzeLux),
      ),
    );
  }

  List<Widget> _construiesteCampuri() {
    if(_modSelectat == 'Reduceri Standard'){
      return[
        _eticheta('Preț inițial (lei)'),
        _campText(
            controller: _pretController,
            hint: 'Introduceți prețul...',
            icon: Icons.attach_money,
        ),
        const SizedBox(height: 16),
        _eticheta('Procent reducere (%)'),
        _campText(
            controller: _procentController,
            hint: 'Introduceți procentul...',
            icon: Icons.percent,
        ),
      ];
    } else if (_modSelectat == 'Reduceri Kg') {
      return [
        _eticheta('Preț per kg (lei/kg)'),
        _campText(
          controller: _pretKgController,
          hint: 'Ex: 25.50',
          icon: Icons.attach_money,
        ),
        const SizedBox(height: 16),
        _eticheta('Cantitate (grame)'),
        _campText(
          controller: _grameController,
          hint: 'Ex: 750',
          icon: Icons.scale,
        ),
        const SizedBox(height: 16),
        _eticheta('Procent reducere (%)'),
        _campText(
          controller: _procentKgController,
          hint: 'Ex: 15 (lasă gol pentru 0%)',
          icon: Icons.percent,
        ),
      ];
    } else {
      return[
        _eticheta('Baza logaritmului'),
        _campText(
          controller: _logBazaController,
          hint: 'Ex: 2, 10, e (2.718)',
          icon: Icons.functions,
        ),
        const SizedBox(height: 16),
        _eticheta('Numărul (argumentul)'),
        _campText(
          controller: _logNumarController,
          hint: 'Ex: 8, 100, 1000',
          icon: Icons.numbers,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.bleuNuit.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.bronzeLux.withValues(alpha: 0.3)
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: AppTheme.bronzeLux, size: 20),
              SizedBox(width: 8),
              Expanded(
                  child: Text(
                    'Formula: log_bază(număr) = ln(număr) / ln(bază)',
                    style: TextStyle(
                      color: AppTheme.grisClair,
                      fontSize: 12,
                    ),
                  ),
              )
            ],
          ),
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator Reducere'),
        backgroundColor: AppTheme.bleuNuit,
        foregroundColor: AppTheme.blancPur,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mod de calcul',
                style: TextStyle(
                  color: AppTheme.blancPur,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.charcoal,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.crisArdois),
                ),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _modSelectat,
                      dropdownColor: AppTheme.charcoal,
                      style: const TextStyle(
                        color: AppTheme.blancPur,
                        fontSize: 16,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppTheme.bronzeLux,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12),
                      items: _moduri.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            children: [
                              Icon(
                                item == 'Reduceri Standard'
                                    ? Icons.local_offer
                                    : item == 'Reduceri Kg'
                                      ? Icons.scale
                                      : Icons.functions,
                                color: AppTheme.bronzeLux,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(item),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _modSelectat = newValue;
                            _rezultat1 = '';
                            _rezultat2 = '';
                          });
                        }
                      },
                    ),
                ),
              ),

              const SizedBox(height: 24),

              ..._construiesteCampuri(),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calculeaza,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.bronzeLux,
                        foregroundColor: AppTheme.noirProfound,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Calculează',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _reseteaza,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.crisArdois,
                        foregroundColor: AppTheme.blancPur,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Resetează',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.charcoal,
                      AppTheme.bleuNuit.withValues(alpha: 0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.bronzeLux.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'REZULTATE',
                      style: TextStyle(
                        color: AppTheme.taupeChic,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                    const Divider(
                      color: AppTheme.crisArdois,
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _rezultat1Label,
                            style: const TextStyle(
                              color: AppTheme.grisClair,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          _rezultat1.isEmpty ? '___' : _rezultat1,
                          style: TextStyle(
                            color: _esteEroare(_rezultat1)
                                ? Colors.red
                                : AppTheme.bronzeLux,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _rezultat2Label,
                            style: TextStyle(
                              color: AppTheme.grisClair,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          _rezultat2.isEmpty ? '___' : _rezultat2,
                          style: TextStyle(
                            color: _rezultat2.isEmpty
                                ? AppTheme.grisClair
                                : AppTheme.blancPur,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _esteEroare(String text) {
    return text.contains('Eroare') ||
        text.contains('Completați') ||
        text.contains('invalide') ||
        text.contains('trebuie');
  }
}