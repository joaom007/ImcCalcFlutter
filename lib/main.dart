import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String _textoInfo = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _limparCampos() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _textoInfo = "Informe seus dados";
    });
  }

  void _calcularImc() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text);
      double imc = peso / pow(altura, 2);

      if (imc < 18.6) {
        _textoInfo = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc <= 24.9) {
        _textoInfo = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc <= 29.9) {
        _textoInfo = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc <= 34.9) {
        _textoInfo = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc <= 39.9) {
        _textoInfo = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      } else {
        _textoInfo = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limparCampos,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.blue,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (KG)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor preencha o campo peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor preencha o campo altura";
                  }
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                height: 50.0,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  //Decorated button nova versão
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _calcularImc();
                    }
                  },
                  child: Text(
                    "Calcular",
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  color: Colors.green,
                ),
              ),
              Text(
                _textoInfo,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    ); // Scaffold
  }
}
