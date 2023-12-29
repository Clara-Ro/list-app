import 'package:flutter/material.dart';

import 'button_widget.dart';
import 'input_widget.dart';


class CardEditingDialog extends StatelessWidget {
  const CardEditingDialog({
    super.key,
    required this.editItem,
    required this.editingController,
    required this.index,
    required this.isEditingEnabled,
    required this.validateEditing
  });

  final void Function (int) editItem;
  final int index;
  final bool isEditingEnabled;
  final TextEditingController editingController;
  final void Function(String?)? validateEditing;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: InputWidget(
        textController: editingController,
        onChanged:validateEditing,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ButtonWidget(
          onPressed:(){
            editItem(index);
            Navigator.pop(context);
          },
          isEnabled: isEditingEnabled,
          child: const Text(
            'Salvar',
            style: TextStyle(fontSize: 16),
          )
        ),
      ],
    );
  }
}