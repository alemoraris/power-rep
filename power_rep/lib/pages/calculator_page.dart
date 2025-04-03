import 'package:flutter/material.dart';

class CalculadoraRMPage extends StatefulWidget {
  const CalculadoraRMPage({Key? key}) : super(key: key);

  @override
  State<CalculadoraRMPage> createState() => _CalculadoraRMPageState();
}

class _CalculadoraRMPageState extends State<CalculadoraRMPage> {
  // Controllers for user input.
  final TextEditingController _pesoUtilizadoController =
      TextEditingController();
  final TextEditingController _repeticionesController = TextEditingController();

  // Selected exercise: "Squat", "Pull up", or "Dip".
  String _selectedExercise = 'Squat';
  double? _calculated1RM;

  // Default bodyweight for Pull up/Dip (80 kg).
  final double defaultBodyWeight = 80;

  // Calculate one-rep max (1RM) using the appropriate formula.
  // For Squat: 1RM = usedWeight × reps × 0.03 + usedWeight
  // For Pull up/Dip: 1RM = (bodyweight + usedWeight) × reps × 0.03 + usedWeight
  void _calcularRM() {
    final double? usedWeight = double.tryParse(_pesoUtilizadoController.text);
    final double? repsInput = double.tryParse(_repeticionesController.text);

    if (usedWeight == null || repsInput == null) {
      // Optionally, show an error.
      return;
    }

    double oneRM = 0;
    if (_selectedExercise == 'Squat') {
      oneRM = usedWeight * repsInput * 0.03 + usedWeight;
    } else {
      oneRM = (defaultBodyWeight + usedWeight) * repsInput * 0.03 + usedWeight;
    }

    setState(() {
      _calculated1RM = oneRM;
    });

    // Show the results in a modal dialog.
    showDialog(
      context: context,
      barrierDismissible: true, // Tapping outside dismisses the modal.
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF302B2B),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "This is your max rep ${oneRM.toStringAsFixed(1)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildResultsTable(oneRM, usedWeight),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // For each percentage, compute the estimated reps using:
  // • For Squats:
  //    estimatedReps = (1RM – (1RM × percentage)) / (usedWeight × 0.03)
  // • For Pull ups/Dips:
  //    estimatedReps = (1RM – (1RM × percentage)) / ((bodyweight + usedWeight) × 0.03)
  double estimatedRepsForRow(
    double oneRM,
    double usedWeight,
    double percentage,
  ) {
    double load = oneRM * percentage;
    if (_selectedExercise == 'Squat') {
      return (oneRM - load) / (usedWeight * 0.03);
    } else {
      return (oneRM - load) / ((defaultBodyWeight + usedWeight) * 0.03);
    }
  }

  // Build the results table.
  // The table shows rows for 50%, 60%, 70%, 80%, and 90% of the 1RM.
  // Each row displays:
  // - % 1RM,
  // - The load = oneRM × percentage,
  // - The estimated reps for that load.
  Widget _buildResultsTable(double oneRM, double usedWeight) {
    List<double> percentages = [0.50, 0.60, 0.70, 0.80, 0.90];

    List<DataRow> rows =
        percentages.map((p) {
          double weight = oneRM * p;
          double repsForRow = estimatedRepsForRow(oneRM, usedWeight, p);
          return DataRow(
            cells: [
              DataCell(
                Text(
                  '${(p * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              DataCell(
                Text(
                  weight.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              DataCell(
                Text(
                  repsForRow.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        }).toList();

    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith(
        (states) => Colors.white12,
      ),
      columns: const [
        DataColumn(label: Text('% 1RM', style: TextStyle(color: Colors.white))),
        DataColumn(label: Text('Peso', style: TextStyle(color: Colors.white))),
        DataColumn(label: Text('Reps', style: TextStyle(color: Colors.white))),
      ],
      rows: rows,
      dividerThickness: 1,
      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white10),
    );
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF302B2B);
    const buttonColor = Color(0xFFEC221F);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BACK BUTTON.
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 20),
              // TITLE.
              const Center(
                child: Text(
                  "CALCULADORA RM",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // SELECT EXERCISE.
              const Text(
                "Selecciona ejercicio:",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _selectedExercise,
                  dropdownColor: Colors.black87,
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.white,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'Squat', child: Text('Squat')),
                    DropdownMenuItem(value: 'Pull up', child: Text('Pull up')),
                    DropdownMenuItem(value: 'Dip', child: Text('Dip')),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      _selectedExercise = value ?? 'Squat';
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              // USED WEIGHT INPUT.
              const Text(
                "Introduzca peso utilizado:",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _pesoUtilizadoController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white12,
                  hintText: "kg",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // REPETITIONS INPUT.
              const Text(
                "Introduzca repeticiones:",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _repeticionesController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white12,
                  hintText: "n° reps",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // CALCULAR BUTTON.
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Check if reps is zero.
                    final double? repsInput = double.tryParse(
                      _repeticionesController.text,
                    );
                    if (repsInput == null || repsInput == 0) {
                      // Do nothing if reps are zero.
                      return;
                    }
                    _calcularRM();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    "CALCULAR",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
