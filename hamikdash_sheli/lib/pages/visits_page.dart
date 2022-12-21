
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';
import 'package:hamikdash_sheli/pages/new_visit.dart';

import '../widgets/korbans_summery_widget.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({
    super.key,
  });

  @override
  State<VisitsPage> createState() => _MyVisitsPageState();
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.visit,
    this.isExpanded = false,
  });

  Visit visit;
  bool isExpanded;
}

class _MyVisitsPageState extends State<VisitsPage> {
  
  @override
  void initState() {
    super.initState();
    _data = _generateItems();
  }

  List<Item> _data = List<Item>.empty();

  List<Item> _generateItems() {
    return visitList.map<Item>((e) => Item (
        visit: e,
      )).toList();
  }

  Future<void> _goToNewVisitPage(BuildContext context) async
  {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const NewVisitPage();
        }
      )
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.visit.title),
            );
          },
          body: KorbansSummeryWidget(visit: item.visit),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

// onTap: () {
//                 setState(() {
//                   _data.removeWhere((Item currentItem) => item == currentItem);
//                 });
//               }

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
            children: [
              Text(
                "ברוכים הבאים",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              (visitList.isEmpty) ?
                const Text("רשימת הביקורים ריקה :(", style: TextStyle(color: Colors.grey))
              :
              SingleChildScrollView(
                child: Container(
                  child: _buildPanel(),
                ),
              ),
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async { 
          currentVisit = Visit();
          await _goToNewVisitPage(context);
          //force rebuild this widget after poping from summery page
          setState(()
          {
            _data = _generateItems();
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
