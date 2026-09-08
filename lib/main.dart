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
  final TextEditingController _pretController = TextEditingController();
  final TextEditingController _procentController = TextEditingController();

  String _rezultatReducere = '';
  String _rezultatFinal = '';

  void _calculeazaReducere() {
    final pretText = _pretController.text.trim();
    final procentText = _procentController.text.trim();

    if (pretText.isEmpty || procentText.isEmpty) {
      setState(() {
        _rezultatReducere = 'Completați toate câmpurile!';
        _rezultatFinal = '';
      });
      return;
    }

    try {
      final double pret = double.parse(pretText);
      final double procent = double.parse(procentText);

      if (pret < 0 || procent < 0 || procent > 100) {
        setState(() {
          _rezultatReducere = 'Valori invalide!';
          _rezultatFinal = '';
        });
        return;
      }

      final double valoareReducere = pret * (procent / 100);
      final double pretFinal = pret - valoareReducere;

      setState(() {
        _rezultatReducere = '${valoareReducere.toStringAsFixed(2)} lei';
        _rezultatFinal = '${pretFinal.toStringAsFixed(2)} lei';
      });
    } catch (e) {
      setState(() {
        _rezultatReducere = 'Eroare la calcul!';
        _rezultatFinal = '';
      });
    }
  }

  void _reseteaza() {
    setState(() {
      _pretController.clear();
      _procentController.clear();
      _rezultatReducere = '';
      _rezultatFinal = '';
    });
  }

  @override
  void dispose() {
    _pretController.dispose();
    _procentController.dispose();
    super.dispose();
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
              const SizedBox(height: 16),

              const Text(
                'Preț inițial (lei)',
                style: TextStyle(
                  color: AppTheme.blancPur,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _pretController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Introduceți prețul...',
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: AppTheme.bronzeLux,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Procent reducere (%)',
                style: TextStyle(
                  color: AppTheme.blancPur,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _procentController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Introduceți procentul...',
                  prefixIcon: Icon(
                    Icons.percent,
                    color: AppTheme.bronzeLux,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calculeazaReducere,
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
                        const Text(
                          'Valoare reducere:',
                          style: TextStyle(
                            color: AppTheme.grisClair,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _rezultatReducere.isEmpty
                              ? '___ lei'
                              : _rezultatReducere,
                          style: TextStyle(
                            color: _rezultatReducere.contains('Eroare') ||
                                _rezultatReducere.contains('Completați') ||
                                _rezultatReducere.contains('Valori invalide')
                                ? Colors.red
                                : AppTheme.bronzeLux,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Preț final:',
                          style: TextStyle(
                            color: AppTheme.grisClair,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _rezultatFinal.isEmpty
                              ? '___ lei'
                              : _rezultatFinal,
                          style: TextStyle(
                            color: _rezultatFinal.isEmpty
                                ? AppTheme.grisClair
                                : AppTheme.blancPur,
                            fontSize: 22,
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
}