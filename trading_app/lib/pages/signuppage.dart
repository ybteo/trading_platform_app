import 'package:flutter/material.dart';
import 'package:trading_app/const/buttonWidget.dart';
import 'package:trading_app/const/constant.dart';
import 'package:trading_app/const/textstyle.dart';
import 'package:trading_app/widget/bottomNaviBar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool useHedge = false;
  bool accept = false;
  String selectedServer = 'Trading-Demo';
  String selectedAccount = 'Forex Hedged USD';
  String selectedLeverage = '1:100';
  String selectedDeposit = '100000 USD';

void _showSelectionDialog(String title, List<String> options, String? selectedOption,Function(String) onSelected) {
  showModalBottomSheet(
    context: context,
    backgroundColor: grey.shade200,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Material(
              color: grey.shade200,
              /* child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, size: 20, color: blue),
                      ),
                      const SizedBox(width: 35),
                      Text(title, style: bodyMBold),
                    ],
                  ),
                  Divider(thickness: 1, height: 1, color: grey.shade500),

                  ...options.map((option) {
                    return ListTile(
                      title: Text(option),
                      onTap: () {
                        if (option == 'Custom') {
                          Navigator.pop(context); // Close first sheet
                          _showCustomInputDialog(onSelected); // Show new one
                        } else {
                          onSelected(option);
                          Navigator.pop(context);
                        }
                      },
                    );
                  }),
                ],
              ), */
              child: ListView.separated(
                controller: scrollController,
                itemBuilder: ((context, index) {
                  if(index == 0){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          icon: Icon(Icons.close, size: 20, color: blue),
                        ),
                        const SizedBox(width: 35),
                        Text(title, style: bodyMBold),
                      ],
                    );
                  }
                  if(index == 1){
                    return Divider(thickness: 1, height: 0, color: grey.shade900);
                  }
                  final option = options[index - 2];

                  return ListTile(
                    title: Text(option),
                    trailing: selectedOption == option ? Icon(Icons.check, color: blue): null,
                    onTap: (){
                      Navigator.pop(context);
                      if(option == 'Custom'){
                        _showCustomInputDialog(onSelected);
                      }else{
                        onSelected(option);
                      }
                    },
                  );
                  
                }), 

                separatorBuilder: ((context, index) => Divider(thickness: 1, height: 0, color: grey.shade300)), 
                itemCount: options.length + 2,
              ),

            ),
          );
        },
      );
    },
  );
}

void _showCustomInputDialog(Function(String) onSelected) {
  final TextEditingController customController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: grey.shade200,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: customController,
              focusNode: focusNode,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter custom deposit',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            BlueButton(
              onPressed: () {
                if (customController.text.isNotEmpty) {
                  onSelected('${customController.text} USD');
                  Navigator.pop(context);
                }
              },
              text: 'Confirm',
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );

  // Request focus after build
  WidgetsBinding.instance.addPostFrameCallback((_) {
    focusNode.requestFocus();
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Image.asset('assets/logo/trade_sampleLogo.png', width: 40, height: 40),
            const Text('Trading Platform App Name', style: bodyMBold),
          ],
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.clear, size: 20, color: blue),
        ),
      ),


      body: SingleChildScrollView(
        child: Container(
          color: grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              _labelField('personal information'),
              const SizedBox(height: 10),
              _textField(firstNameController, 'min 2 chars', 'First Name'),
              _textField(lastNameController, 'min 2 chars', 'Last Name'),
              //dob
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('You must be at least 18 years old', style: bodySRegular.copyWith(color: grey.shade600)),
              ),
          
              const SizedBox(height: 10),
              _textField(mobileNumberController, '+74951234567', 'Mobile'),
              _textField(emailController, 'name@company.com', 'Email'),
              const SizedBox(height: 15),

              _labelField('account information'),
              const SizedBox(height: 10),
              _toggleField('Use hedge', useHedge, (val)=> setState(() => useHedge = val)),
              _buildSelectionField('Server', selectedServer, () {
                _showSelectionDialog('Server', ['Trading-main', 'Trading-demo', 'Trading-setting1'], selectedServer,
                  (value){
                    setState(() => selectedServer = value);
                  }
                );
              }),
              _buildSelectionField('Account Type', selectedAccount, () {
                _showSelectionDialog('Account Type', ['Forex Hedged USD', 'Forex Hedged AUD', 'Forex Hedged CAD'], selectedAccount,
                  (value){
                    setState(() => selectedAccount = value);
                  }
                );
              }),
              _buildSelectionField('Leverage', selectedLeverage, () {
                _showSelectionDialog('Leverage', ['1:50', '1:100', '1:300', '1:500'], selectedLeverage,
                  (value){
                    setState(() => selectedLeverage = value);
                  }
                );
              }),
              _buildSelectionField('Deposit', selectedDeposit, () {
                _showSelectionDialog('Deposit', ['100000 USD', '5000 USD', '3000 USD', 'Custom'], selectedDeposit,
                  (value){
                    setState(() => selectedDeposit = value);
                  }
                );
              }),

              const SizedBox(height: 30),
              _toggleField('Accept', accept, (val)=> setState(() => accept = val)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('By enabling "Accept" you agree with the terms and conditions for opening an account and the data protection policy', style: bodySRegular.copyWith(color: grey.shade600)),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: BlueButton(
                      onPressed: () async {
                        Navigator.pushReplacement(
                          context, 
                          MaterialPageRoute(builder: (context) => const BottomNaviBar(isNewUser: true)),
                        );
                      }, 
                      text: 'Register',
                    ),
                  ),
                ],
              ),
          
            ],
          ),
        ),
      ),


    );
  }

  Widget _labelField(String text){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(text.toUpperCase(), style: bodySRegular.copyWith(color: grey.shade700)),
    );
  }

  Widget _textField(TextEditingController controller, String hintText, String title){
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          onChanged:(value) {
            setState(() {
              
            });
          },
          enabled: true,
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            labelStyle: bodyMRegular,
            border: const UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: blue),
            ),
            hintText: hintText,
            hintStyle: bodyMRegular.copyWith(color: grey.shade600),
          ),
        ),
      ),
    );
  }

  Widget _toggleField(String title, bool value, Function(bool) onChanged){
    return Material(
      color: Colors.white,
      child: SwitchListTile(
        value: value, 
        onChanged: onChanged,
        title: Text(title, style: bodyMRegular),
        activeColor: Colors.green,
        activeTrackColor: Colors.green,
        inactiveThumbColor: Colors.white,
        trackOutlineColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
        inactiveTrackColor: grey.shade400,
        // shape: Border.all(color: Colors.transparent),
        // tileColor: Colors.white,
        thumbColor: MaterialStateColor.resolveWith((states) => Colors.white),
        
      ),
    );
  }

  Widget _buildSelectionField(String label, String value, VoidCallback onTap){
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            
            Divider(thickness: 1, height: 0, color: grey.shade400),
        
            GestureDetector(
              onTap: onTap,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: bodySRegular.copyWith(color: Colors.black87),
                  border: const UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: grey.shade500),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(value.isNotEmpty? value: "Select $label", style: value.isNotEmpty? bodyMRegular.copyWith(color: grey.shade900):bodyMRegular.copyWith(color: grey.shade500)),
                    Icon(Icons.keyboard_arrow_right, color: grey.shade500),
                  ],
                ),
        
              ),
            ),
        
            Divider(thickness: 1, height: 0, color: grey.shade400),
          ],
        ),
      ),
    );
  }

  


}