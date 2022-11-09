
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';

class KorbanotListPage extends StatelessWidget {
  const KorbanotListPage({
    super.key,
    required this.korbanot,
  });

  final List<Korban> korbanot;

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: korbanot.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildListItem(context, korbanot[index]);
      },
    );
  }

  Widget _buildListItem(BuildContext context, Korban korban) {
    return ListTile(
        leading: FlutterLogo(),
        title: Text(
          korban.requirements,
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: Text(
          korban.type,
          style: Theme.of(context).textTheme.headline6?.apply(color: Colors.grey),
        ),
      )
    ;
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
