import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTranaction extends StatefulWidget {
  final Function addtransactionhandler;

  NewTranaction(this.addtransactionhandler);

  @override
  _NewTranactionState createState() => _NewTranactionState();
}

class _NewTranactionState extends State<NewTranaction> {
  final titleConteroller = TextEditingController();
  final amountConteroller = TextEditingController();
  DateTime userdatechosen;
  void submitData() {
    if(amountConteroller.text.isEmpty)
    {
      return;
    }
    final enterdtitle = titleConteroller.text;
    final enteramount = double.parse(amountConteroller.text);
    if (enterdtitle.isEmpty || enteramount <= 0 || userdatechosen ==null) {
      return;
    }

    widget.addtransactionhandler(enterdtitle, enteramount ,userdatechosen);
    Navigator.of(context).pop();
  }

  void _presistansedatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((chosendate) {
      if (chosendate == null) {
        return;
      }
      setState(() {
              userdatechosen = chosendate;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
          child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.only(top: 10,right: 10,left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom +10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleConteroller,
                onSubmitted: (_) => submitData(),
                //  onChanged: (value) => titleInput = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountConteroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                //  onChanged: (value) {
                //      amountInput = value;
                //   },
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(                          //take all width needed
                    child:Text(userdatechosen == null
                        ? 'No Date Chossen'
                        : DateFormat.yMd().format(userdatechosen),
                        )
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark),
                      ),
                      onPressed: _presistansedatepicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColorDark,
                child: Text(
                  'Add Trasaction',
                  style:
                      TextStyle(color: Theme.of(context).textTheme.button.color),
                ),
                onPressed: submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
