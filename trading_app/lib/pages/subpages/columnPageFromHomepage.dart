import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class ColumnPage extends StatefulWidget {
  final List<String> selectedColumns;
  const ColumnPage({super.key, required this.selectedColumns});

  @override
  State<ColumnPage> createState() => _ColumnPageState();
}

class _ColumnPageState extends State<ColumnPage> {

  List<String> selectedColumns = ['Bid', 'Ask', 'Day %', 'Spread'];
  List<String> availableColumns = ['Bid High', 'Bid Low', 'Ask High', 'Ask Low', 'Last', 'Last High', 'Last Low', 'Time'];

  @override
  void initState(){
    super.initState();
    selectedColumns = List.from(widget.selectedColumns);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Columns', style: bodyMBold),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
          onPressed: (){
            Navigator.pop(context, selectedColumns);
          },
        ),
      ),


      body: Column(
        children: [
          //list of display function 
          if(selectedColumns.isNotEmpty)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: selectedColumns.length * 56.0,
              ),
              child: ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for(int index = 0; index < selectedColumns.length; index++)
                    ListTile(
                      key: ValueKey(selectedColumns[index]),
                      leading: IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red), 
                        onPressed: (){
                          setState(() {
                            availableColumns.add(selectedColumns[index]);
                            selectedColumns.removeAt(index);
                          });
                        },
                      ),
                      title: Text(selectedColumns[index]),
                      trailing: ReorderableDragStartListener(
                        index: index,
                        child: Icon(Icons.dehaze, color: grey.shade500)),
                    )
                ], 

                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if(newIndex > oldIndex) newIndex--;
                    final item = selectedColumns.removeAt(oldIndex);
                    selectedColumns.insert(newIndex, item);

                  });
                },
              ),
            ),

          if(selectedColumns.isNotEmpty)
            Divider(thickness: 1, color: grey.shade600, height: 0),
      
          Expanded(
            child: ListView.builder(
              itemCount: availableColumns.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green),
                    onPressed: (){
                      setState(() {
                        selectedColumns.add(availableColumns[index]);
                        availableColumns.removeAt(index);
                      });
                    },
                  ),
                  title: Text(availableColumns[index]),
                );
              }
            ),
          ),
      
      
        ],
      ),
    );
  }
}