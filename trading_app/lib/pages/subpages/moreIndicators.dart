import 'package:flutter/material.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';

class AddIndicator extends StatefulWidget {
  const AddIndicator({super.key});

  @override
  State<AddIndicator> createState() => _AddIndicatorState();
}

class _AddIndicatorState extends State<AddIndicator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Indicator', style: bodyMBold),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left, size: 30, color: blue),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          color: grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('TREND', style: bodyXSRegular.copyWith(color: grey.shade700)),
              ),
              _buttonForIndicators('Average Directional Movement Index', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Bollinger Bands', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Envelopes', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Ichimoku Kinko Hyo', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Moving Average', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Parabolic SAR', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Standard Deviation', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
        
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('OSCILLATORS', style: bodyXSRegular.copyWith(color: grey.shade700)),
              ),
              _buttonForIndicators('Average True Range', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Bears Power', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Bulls Power', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Commodity Channel Index', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('DeMarker', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Force Index', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('MACD', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Momentum', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Moving Average of Oscillator', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Relative Strength Index', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Relative Vigor Index', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Stochastic Oscillator', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Williams\' Percent Range', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),

              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('VOLUMES', style: bodyXSRegular.copyWith(color: grey.shade700)),
              ),
              _buttonForIndicators('Accumulation/Distribution', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Money Flow Index', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('On Balance Volume', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Volumes', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0), 

              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('BILL WILLIAMS', style: bodyXSRegular.copyWith(color: grey.shade700)),
              ),
              _buttonForIndicators('Accelerator Oscillator', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Alligator', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Awesome Oscillator', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Fractals', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Gator Oscillator', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),
              _buttonForIndicators('Market Facilitation Index', () { }),
              Divider(thickness: 1, color: grey.shade200, height: 0),

            ],
          ),
        ),
      ),





    );
  }


  Widget _buttonForIndicators(String title, VoidCallback onPress){
    return  Material(
      color: Colors.white,
      child: ListTile(
        title: Text(title, style: bodySRegular),
        onTap: onPress,
      ),
    );
  }

}