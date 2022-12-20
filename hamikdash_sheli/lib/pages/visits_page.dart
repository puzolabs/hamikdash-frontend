
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';
import 'package:hamikdash_sheli/pages/new_visit.dart';

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

  Order visit;
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

  void _goToNewVisitPage(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const NewVisitPage();
        }
      )
    )
    //force rebuild this widget after poping from summery page
    .then((value) => setState(()
    {
      _data = _generateItems();
    }));
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
          body: ListTile(
              title: Text("this is expanded"),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Order visit) {
    return Card(
      child: ListTile(
        leading: const FlutterLogo(),
        title: Text(
          visit.title,
          style: Theme.of(context).textTheme.headline4,
        ),
        onTap: () {  }
      )
    );
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
        onPressed: () { 
          currentOrder = Order();
          _goToNewVisitPage(context);
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
