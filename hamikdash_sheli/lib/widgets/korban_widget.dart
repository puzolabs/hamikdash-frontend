
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';

class KorbanWidget extends StatefulWidget {
  const KorbanWidget({
    super.key,
    required this.korban,
  });

  @override
  State<StatefulWidget> createState() {
    return _KorbanWidgetState();
  }

  final Korban korban;
}

class _KorbanWidgetState extends State<KorbanWidget> {
  bool _isOpen = false;

  Widget _buildEatInfoRow(String name, String value)
  {
    return Row(
      children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  Widget _buildEatInfo()
  {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOpen = !_isOpen;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("פרטי אכילת הקורבן",
            style: TextStyle(
              decoration:TextDecoration.underline,
              color: Colors.blue,
            )
          ),
          Visibility(
            maintainSize: false, 
            maintainAnimation: true,
            maintainState: true,
            visible: _isOpen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("קורבן זה יש לאכול על פי התנאים הבאים:"),
                _buildEatInfoRow("מה: ", widget.korban.eatInfo!.what),
                _buildEatInfoRow("מי: ", widget.korban.eatInfo!.who),
                _buildEatInfoRow("איפה: ", widget.korban.eatInfo!.where),
                _buildEatInfoRow("מתי: ", widget.korban.eatInfo!.when),
              ]
            ), 
          ),
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 25),
            child: widget.korban.type == KorbanTypes.ola
            ? const Text('🔥 עולה' ,
              style: const TextStyle(fontSize: 18)
            )
            : widget.korban.type == KorbanTypes.shlamim
            ? const Text('🐏 שלמים' ,
              style: const TextStyle(fontSize: 18)
            )
            : widget.korban.type == KorbanTypes.hatat
            ? const Text('💔 חטאת' ,
              style: const TextStyle(fontSize: 18)
            )
            : widget.korban.type == KorbanTypes.asham
            ? const Text('😒 אשם' ,
              style: const TextStyle(fontSize: 18)
            )
            : widget.korban.type == KorbanTypes.minha
            ? const Text('🥖 מנחה' ,
              style: const TextStyle(fontSize: 18)
            )
            : //widget.korban.type == KorbanTypes.nesahim
            /* ?*/ const Text('🍾 נסכים' ,
              style: const TextStyle(fontSize: 18)
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 25),
            child: Text(widget.korban.requirements,
              style: const TextStyle(fontSize: 28)
            ),
          ),
        ),
        if(widget.korban.eatInfo != null)
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 25),
              child: _buildEatInfo()
            )
          )
        ]
    );
  }
}
