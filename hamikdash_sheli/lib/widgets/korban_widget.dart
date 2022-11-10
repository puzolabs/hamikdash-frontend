
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';

class KorbanWidget extends StatelessWidget {
  const KorbanWidget({
    super.key,
    required this.korban,
  });

  final Korban korban;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const FlutterLogo(),
      title: Text(
        korban.requirements,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: Text(
        korban.type,
        style: Theme.of(context).textTheme.headline6?.apply(color: Colors.grey),
      ),
    );
  }
}
