import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key, 
    required this.text, 
    required this.index, 
    required this.openDeleteDialog,
    required this.openEditDialog
  });
  
  final String text;
  final int index;

  final void Function() openDeleteDialog;
  final void Function() openEditDialog;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: openEditDialog, 
            icon: const Icon(Icons.border_color)
          ),
          IconButton(
            onPressed: openDeleteDialog, 
            icon: const Icon(Icons.cancel, color: Colors.red,)
          )
        ],
      ),
    );
  }
}