// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/employe_services.dart';
import '../utils/snackbar_helper.dart';

class AddEmploye extends StatefulWidget {
  final Map? todo;
  const AddEmploye({super.key, this.todo});

  @override
  _AddEmployeState createState() => _AddEmployeState();
}

class _AddEmployeState extends State<AddEmploye> {
  TextEditingController nomController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController tauxController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    final todo = widget.todo;
    super.initState();
    if (todo != null) {
      isEdit = true;
      final nom = todo['nom'];
      final adresse = todo['adresse'];
      final taux = todo['tauxHoraire'];

      nomController.text = nom;
      adresseController.text = adresse;
      tauxController.text = taux.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Editer" : "Nouveau"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),

        // Adding fields for input data
        children: [
          TextField(
            controller: nomController,
            decoration:
                InputDecoration(border: OutlineInputBorder(), labelText: "Nom"),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: adresseController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Adresse"),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: tauxController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Taux"),
          ),
          SizedBox(
            height: 20,
          ),

          // Button on submiting
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(isEdit ? "Mettre à jour" : "Valider"),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    // Get data from textfieldcontroller
    final todo = widget.todo;
    if (todo == null) {
      print('tsy mety');
      return;
    }
    final id = todo['numEmploye'];

    // submit updated data to the server
    final isSuccess = await EmployeService.updateData(id, body);

    if (isSuccess) {
      nomController.text = "";
      adresseController.text = "";
      tauxController.text = "";
      showSuccessMessage(context, message: "Employé modifié");
    } else {
      showFailureMessage(context, message: "Erreur lors du modification");
    }
  }

  Future<void> submitData() async {
    // Submitting data

    final isSuccess = await EmployeService.submitData(body);

    // showing success or fail message based on status
    if (isSuccess) {
      nomController.text = "";
      adresseController.text = "";
      tauxController.text = "";
      showSuccessMessage(context, message: "Employé ajouté");
    } else {
      showFailureMessage(context, message: "Erreur lors de l'ajout");
    }
  }

  // Create a variable to store data from textField to body paremeter
  Map get body {
    final nom = nomController.text;
    final adresse = adresseController.text;
    final taux = tauxController.text;
    return {
      "nom": nom,
      "adresse": adresse,
      "tauxHoraire": int.parse(taux),
    };
  }
}
