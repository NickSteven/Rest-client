// ignore_for_file: prefer_const_constructors, prefer_const_declarations, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_client/pages/add_employe.dart';
import 'package:http/http.dart' as http;

import '../services/employe_services.dart';
import '../utils/snackbar_helper.dart';
import '../widget/employe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List items = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste"),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchData,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                "Liste vide",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item['numEmploye'];
                return EmployeCard(
                  index: index,
                  deleteById: deleteById,
                  navigateEdit: navigateToEditEmploye,
                  item: item,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddEmploye,
        label: Text("Ajouter"),
      ),
    );
  }

  Future<void> navigateToAddEmploye() async {
    final route = MaterialPageRoute(builder: (context) => AddEmploye());
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  void navigateToEditEmploye(Map item) async {
    final route =
        MaterialPageRoute(builder: (context) => AddEmploye(todo: item));
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  // function getting data
  Future<void> fetchData() async {
    final response = await EmployeService.fetchData();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showFailureMessage(context, message: "Erreur de fetching");
    }
    setState(() {
      isLoading = false;
    });
  }

  // function deleting data
  Future<void> deleteById(int id) async {
    // delete employe
    final isSuccess = await EmployeService.deleteById(id);
    if (isSuccess) {
      // remove employe from the list
      final filtered =
          items.where((element) => element['numEmploye'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showFailureMessage(context, message: "Error on deleting");
    }
  }
}
