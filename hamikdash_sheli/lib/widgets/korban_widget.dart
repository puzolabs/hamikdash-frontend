
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
    return ListTile(
      leading: const FlutterLogo(),
      title: Text(
        widget.korban.requirements,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
            widget.korban.type,
            style: Theme.of(context).textTheme.headline6?.apply(color: Colors.grey),
          ),
          if(widget.korban.eatInfo != null)
            _buildEatInfo(),
        ],
      )
    );
  }
}
