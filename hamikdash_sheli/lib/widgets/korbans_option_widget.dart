import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';

class KorbansOptionWidget extends StatelessWidget {
  const KorbansOptionWidget({
    super.key,
    required this.korbanotOption,
    required this.onOptionSelected,
  });

  final KorbansOption korbanotOption;
  final Function(KorbansOption) onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return Card (
      elevation: 8.0, // Good shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Rounded corners
      ),
      child: InkWell( // Makes the card tappable with a splash
        onTap: () {
          onOptionSelected.call(korbanotOption);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                korbanotOption.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              KorbansWidget(korbanot: korbanotOption.korbans),
            ],
          )
        )
      )
    );
  }
}
