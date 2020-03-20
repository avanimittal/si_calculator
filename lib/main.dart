import 'package:flutter/material.dart';

void main() => runApp(SI_Calculator());

class SI_Calculator extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _SI_CalculatorState();
  }
}
class _SI_CalculatorState extends State<SI_Calculator>
{ var _currencies=["Rupees","Dollar","Pounds","Euros"];
var _currentValueSelected="Rupees";
var _displayResult='';
var _formKey=GlobalKey<FormState>();
TextEditingController principalController=TextEditingController();
TextEditingController rateController=TextEditingController();
TextEditingController termController=TextEditingController();

  Widget build(BuildContext context){

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SI_Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
          primaryColor: Colors.amber,
          accentColor: Colors.amber
      ),
      home:Scaffold(
        appBar:AppBar(
          title: Text('Simple Interest Calculator',
            style: TextStyle(color:Colors.black),),
      ),
//        backgroundColor: Colors.black38,


        body:Form(
          key: _formKey,
            child:ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10.0),),
            Image(image: AssetImage('assets/money.png',),width: 150.0,height: 150.0,),
            Padding(padding: EdgeInsets.all(30.0),),
            Padding(padding: EdgeInsets.all(15.0),
            child:  TextFormField(
              keyboardType: TextInputType.number,
              controller: principalController,
              validator: (String value){
                if(value.isEmpty){
                  return "Please enter principal amount";
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  labelText: 'Principal',
                  errorStyle: TextStyle(fontSize: 14.0),
                  hintText: 'Enter the principal e.g. 25000'
              ),
            ),),
            Padding(padding: EdgeInsets.only(right:15.0,left: 15.0,top: 2.0,bottom: 2.0,),
              child:  TextFormField(
                keyboardType: TextInputType.number,
                controller: rateController,
                validator: (String value){
                  if(value.isEmpty){
                    return "Please enter rate of interest";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    labelText: 'Rate Of Interest',
                    errorStyle: TextStyle(fontSize: 14.0),
                    hintText: 'Enter the rate e.g. 5',
                ),
              ),),
        Padding(padding: EdgeInsets.only(right:15.0,left: 15.0,top: 15.0,bottom: 2.0,),
        child:Row(
          children: <Widget>[
            Expanded(child:TextFormField(
              keyboardType: TextInputType.number,
              controller: termController,
              validator: (String value){
                if(value.isEmpty){
                  return "Please enter time";
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  labelText: 'Term',
                  errorStyle: TextStyle(fontSize: 14.0),
                  hintText: 'Enter the time in years'
              ),
            ),),
            Padding(padding: EdgeInsets.all(10.0),),
            Expanded(child:DropdownButton<String>(
              items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: _currentValueSelected,
              onChanged: (String newValueSelected) {
                _onDropdownMenuSelected(newValueSelected);
              },
            )),
          ],
        ),),
          Padding(padding: EdgeInsets.only(right:15.0,left: 15.0,top: 15.0,bottom: 2.0,),
            child:
            Row(
              children: <Widget>[
                Expanded(
                  child:RaisedButton(
                    color:Colors.green,
                    child:Text('Calculate',style: TextStyle(color: Colors.black),),
                    onPressed: (){
                      setState(() {
                        if(_formKey.currentState.validate()){
                        this._displayResult=_calculateValue();}
                      });
                    },
                  )
                ),
                Padding(padding: EdgeInsets.all(10.0),),
                Expanded(
                    child:RaisedButton(
                      color:Colors.red,
                      child:Text('Reset',style: TextStyle(color: Colors.black),),
                      onPressed: (){
                        setState(() {
                          _reset();
                        });
                      },
                    )
                )
              ],
            ),),
          Padding(padding: EdgeInsets.only(right:15.0,left: 15.0,top: 15.0,bottom: 2.0,),
            child:Text(this._displayResult),)
          ],
        )),

    ));
  }void _onDropdownMenuSelected(String newValueSelected){
    setState(() {
      this._currentValueSelected = newValueSelected;
    });
  }
  String _calculateValue(){
    double principal=double.parse(principalController.text);
    double rate=double.parse(rateController.text);
    double term=double.parse(termController.text);

    double amount=principal+(principal*rate*term)/100;

    String result='After $term years,your investment will be $amount $_currentValueSelected';
    return result;
  }
  void _reset(){
    principalController.text='';
    rateController.text='';
    termController.text='';
    _displayResult='';
    _currentValueSelected=_currencies[0];
  }


}


