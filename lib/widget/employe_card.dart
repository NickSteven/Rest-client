// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EmployeCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(int) deleteById;
  const EmployeCard(
      {Key? key,
      required this.index,
      required this.item,
      required this.navigateEdit,
      required this.deleteById})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = item['numEmploye'];
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text("${index + 1}"),
        ),
        title: Text(item['nom']),
        subtitle: Text(item['adresse']),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == "edit") {
              // perform edit
              navigateEdit(item);
            } else if (value == "delete") {
              // perform delete
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text("Edit"),
                value: "edit",
              ),
              PopupMenuItem(
                child: Text("Delete"),
                value: "delete",
              ),
            ];
          },
        ),
      ),
    );
    ;
  }
}
