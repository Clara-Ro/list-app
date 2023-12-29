import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.child
  });

  final void Function() onPressed;
  final bool isEnabled;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:(){
        if(isEnabled){
          onPressed();
        } 
      }
      ,style: ButtonStyle(
        backgroundColor: isEnabled ? MaterialStateProperty.all(const Color(0xff44bd6e))
        :MaterialStateProperty.all(const Color(0xFF868181)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )
        )
      ), 
      child: child
    );
  }
}