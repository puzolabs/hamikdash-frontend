
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/widgets/korban_widget.dart';
import 'package:hamikdash_sheli/korban.dart';

class KorbansWidget extends StatelessWidget {
  const KorbansWidget({
    super.key,
    required this.korbanot,
  });

  final List<Korban> korbanot;

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: korbanot.length,
      itemBuilder: (BuildContext context, int index) {
        return KorbanWidget(korban: korbanot[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
