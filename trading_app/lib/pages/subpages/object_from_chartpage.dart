import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class ObjectPage extends StatefulWidget {
  const ObjectPage({super.key});

  @override
  State<ObjectPage> createState() => _ObjectPageState();
}

class _ObjectPageState extends State<ObjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Objects', style: bodyMBold),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      body: Container(
        color: grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Divider(thickness: 1, color: grey.shade200, height: 0),
            _buttonForObject('Add Object', () { }),
            Divider(thickness: 1, color: grey.shade200, height: 0),
            _buttonForObject('Add Text', () { }),
            Divider(thickness: 1, color: grey.shade200, height: 0),
            const SizedBox(height: 10),
            //list of icon buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: (){}, child: Text('|', style: bodyMBold.copyWith(color: blue))),
                TextButton(onPressed: (){}, child: Text('--', style: bodyMBold.copyWith(color: blue))),
                TextButton(onPressed: (){}, child: Text('/', style: bodyMBold.copyWith(color: blue))),
                IconButton(onPressed: (){}, icon: Icon(Icons.signal_cellular_0_bar_outlined, size: 20, color: blue)),
                IconButton(onPressed: (){}, icon: Icon(Icons.local_movies_outlined, size: 20, color: blue)),
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_outward, size: 20, color: blue)),
                IconButton(onPressed: (){}, icon: Icon(Icons.gradient, size: 20, color: blue)),
              ],
            ),


            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Long tap the object on the chart to edit or delete it', style: bodyXSRegular.copyWith(color: grey.shade800)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonForObject(String title, VoidCallback onPress){
    return  Material(
      color: Colors.white,
      child: ListTile(
        title: Text(title, style: bodySRegular),
        trailing: Icon(Icons.keyboard_arrow_right_outlined, color: grey.shade500),
        onTap: onPress,
      ),
    );
  }




}