import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/pages/date_finder_page.dart';
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/widgets/korbans_options_widget.dart';

class KorbanCasePage extends StatefulWidget {
  const KorbanCasePage({super.key, required this.korbanCase});

  final KorbanCase korbanCase;

  @override
  State<KorbanCasePage> createState() => _KorbanCasePageState();
}

class _KorbanCasePageState extends State<KorbanCasePage> {

  void _goToDateFinderPage()
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const DateFinderPage();
        }
      )
    );
  }

  List<Widget> _buildPanel(BuildContext context)
  {
      if(widget.korbanCase.korbanot != null)
      {
        return [
          Text(
            "עליכם להגיע למקדש עם הפריטים הבאים:",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          KorbansWidget(korbanot: widget.korbanCase.korbanot!),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                currentOrder!.korbans = widget.korbanCase.korbanot;
                _goToDateFinderPage();
              },
              child: const Text("המשך")
            ),
          ),
        ];
      }
      else if(widget.korbanCase.korbanotOptions != null)
      {
        return [
          Text(
            "ביחרו אחת מהאפשרויות הבאות:",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: KorbansOptionsWidget(korbanotOptions: widget.korbanCase.korbanotOptions!),
          ),
        ];
      }
      else
      {
        return [];
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Directionality(
          textDirection: TextDirection.rtl,
          child:Text("המקדש שלי"),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _buildPanel(context)
          ),
        ),
      )
    );
  }
}
