import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class HistoryFromHistory extends StatefulWidget {
  const HistoryFromHistory({super.key});

  @override
  State<HistoryFromHistory> createState() => _HistoryFromHistoryState();
}

class _HistoryFromHistoryState extends State<HistoryFromHistory> {
  String selectedOption = 'Today';
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {

    DateTime initialDate = isStartDate ? DateTime.now(): (startDate?? DateTime.now());
    DateTime firstDate = isStartDate? DateTime(2000): (startDate?? DateTime(2000));
    DateTime lastDate = DateTime(2100);


    DateTime? pickedDate = await showDatePicker(
      context: context, 
      initialDate: initialDate,
      firstDate: firstDate, 
      lastDate: lastDate,
    );
    if(pickedDate != null){
      setState(() {
        if(isStartDate){
          startDate = pickedDate;
          if(endDate != null && endDate!.isBefore(startDate!)){
            endDate = null;
          }
        }else{
          endDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History', style: bodyMBold),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: (){
              //save function needed
              Navigator.pop(context);
            }, 
            child: Text('Done', style: bodySBold.copyWith(color: blue)),
          ),
        ],
      ),

      body: Container(
        color: grey.shade100,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Material(
              color: Colors.white,
              child: ListTile(
                title: const Text('Symbol:', style: bodyMRegular),
                //appear when the selection is chosen
                trailing:  
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('All symbols', style: bodyMRegular.copyWith(color: grey.shade700)),
                      const SizedBox(width: 5),
                      Icon(Icons.done, size: 20, color: blue),
                    ],
                  ),
                  onTap: (){},
              ),
            ),
            const SizedBox(height: 25),

            const SizedBox(height: 30),
            Divider(thickness: 1, color: grey.shade200, height: 0),
            _buttonForHistory('Today'),
            Divider(thickness: 1, color: grey.shade200, height: 0),
            _buttonForHistory('Last week'),
            Divider(thickness: 1, color: grey.shade200, height: 0),
            _buttonForHistory('Last month'),
            Divider(thickness: 1, color: grey.shade200, height: 0),
            _buttonForHistory('Last 3 months'),
            Divider(thickness: 1, color: grey.shade200, height: 0),
            _buttonForHistory('Last 6 months'),
            Divider(thickness: 1, color: grey.shade200, height: 0),
            _buttonForHistory('Last year'),
            Divider(thickness: 1, color: grey.shade200, height: 0),
            _buttonForHistory('Custom'),
            Divider(thickness: 1, color: grey.shade200, height: 0),

            //if select custom, pop out start date and end date
            if(selectedOption == 'Custom')...[
              const SizedBox(height: 20),
              _customDatePicker('Start date', startDate, () => _selectDate(context, true)),
              // const SizedBox(height: 20),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _customDatePicker('End date', endDate, () => _selectDate(context, false)),

            ]

          ],
        ),
      ),

    );
  }

  Widget _buttonForHistory(String title){
    return Material(
      color: Colors.white,
      child: ListTile(
        title: Text(title, style: bodyMRegular),
        //appear when the selection is chosen
        trailing: selectedOption == title? Icon(Icons.done, size: 20, color: blue): null,
        onTap: (){
          setState(() {
            selectedOption = title;
          });
        },
      ),
    );
  }

  Widget _customDatePicker(String label, DateTime? date, VoidCallback onTap){
    return Material(
      color: Colors.white,
      child: ListTile(
        title: Text(label, style: bodyMRegular),
        trailing: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            // shape: BoxShape.rectangle,
            color: grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            date != null? '${date.day}/${date.month}/${date.year}': 'Select date', style: bodyMRegular
          ),
        ),
        onTap: onTap,       
      ),
    );
  }




}