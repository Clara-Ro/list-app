import 'package:flutter/material.dart';

class CardDeleteDialog extends StatelessWidget {
  CardDeleteDialog({super.key, required this.deleteItem, required this.index});
  final void Function (int) deleteItem;
  final int index;



  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      content: const Text("Tem certeza que deseja excluir o item?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            deleteItem(index);
            Navigator.pop(context);
          }, 
          child: const Text('Sim'),
        ),
      ],
    );
  }
}