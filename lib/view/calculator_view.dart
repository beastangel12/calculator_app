import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final myController = TextEditingController();
  int? first, second;
  int result = 0;
  String operation = '';

  void _calculate() {
    if (first != null && second != null) {
      switch (operation) {
        case '+':
          setState(() {
            result = first! + second!;
          });
          break;
        case '-':
          setState(() {
            result = first! - second!;
          });
          break;
        case '*':
          setState(() {
            result = first! * second!;
          });
          break;
        case '/':
          setState(() {
            if (second! != 0) {
              result = first! ~/ second!;
            } else {
              // Handle division by zero
              // You can display an error message or handle it as per your requirements
              result = 0;
            }
          });
          break;
      }
      myController.text = result.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Calculator App'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: myController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: 16,
              itemBuilder: (BuildContext context, int index) {
                return _buildButton(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(int index) {
    List<String> buttonLabels = [
      '7',
      '8',
      '9',
      '/',
      '4',
      '5',
      '6',
      '*',
      '1',
      '2',
      '3',
      '-',
      '0',
      'C',
      '=',
      '+',
    ];

    return ElevatedButton(
      onPressed: () {
        _onButtonPressed(buttonLabels[index]);
      },
      child: Text(buttonLabels[index]),
    );
  }

  void _onButtonPressed(String buttonText) {
    if (buttonText == 'C') {
      setState(() {
        myController.clear();
        first = null;
        second = null;
        result = 0;
        operation = '';
      });
    } else if (buttonText == '=') {
      setState(() {
        second = int.tryParse(myController.text) ?? 0;
      });
      _calculate();
      operation = '';
      first = null;
      second = null;
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      setState(() {
        if (first == null) {
          first = int.tryParse(myController.text) ?? 0;
          myController.clear();
          operation = buttonText;
        } else {
          second = int.tryParse(myController.text) ?? 0;
          _calculate();
          operation = buttonText;
          first = result;
          second = null;
        }
      });
    } else {
      myController.text = myController.text + buttonText;
    }
  }
}
