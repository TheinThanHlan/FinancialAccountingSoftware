import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/data/dao/AccountTypeDao.dart';
import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './AddNewAccountController.dart';
import 'package:winter/winter.dart';

class AddNewAccount extends StatelessWidget implements WinterView {
  late final AddNewAccountController c;

  @override
  Widget build(BuildContext context) {
    //    return LayoutBuilder(builder: (context, constraints) {
    //      return Desktop(c);
    //    });
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Add new account"),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      content: Center(
        child: Container(
          width: 610,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Form(
                  key: c.formKey,
                  child: Column(
                    spacing: 34,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: c.message,
                        builder: (context, value, child) {
                          return Text(
                            value.$1,
                            style: TextStyle(color: value.$2),
                          );
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text(c.languageFactory.getLang(1)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return c.languageFactory.getLang(2);
                          }
                          return null;
                        },
                        onChanged: (a) {
                          c.account = a;
                        },
                      ),
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          label: Text(c.languageFactory.getLang(3)),
                        ),
                        onChanged: (a) {
                          c.code = a;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return c.languageFactory.getLang(4);
                          }
                          if (int.tryParse(value) == null) {
                            return c.languageFactory.getLang(5);
                          }
                          //if (99999 < int.parse(value) || int.parse(value) < 10000) {
                          //  return c.languageFactory.getLang(6);
                          //}
                          return null;
                        },
                      ),
                      Container(
                        alignment: .centerLeft,
                        child: FutureBuilder(
                          future: getIt<AccountTypeDao>().getAllAccountTypes(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null &&
                                snapshot.data!.isNotEmpty) {
                              c.accountType = ValueNotifier(
                                snapshot.data!.first,
                              );
                              return ValueListenableBuilder(
                                valueListenable: c.accountType,
                                builder: (context, value, child) =>
                                    DropdownButton(
                                      value: c.accountType.value,
                                      items: snapshot.data!
                                          .map(
                                            (a) => DropdownMenuItem(
                                              value: a,
                                              child: Text(a.name),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (a) {
                                        c.accountType.value = a!;
                                      },
                                    ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                      OutlinedButton(
                        child: Text(
                          c.languageFactory.getLang(9),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onPressed: () async {
                          if (c.formKey.currentState!.validate()) {
                            await c.createNewAccount();
                          }
                        },
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xfff1E9D2),
                          borderRadius: .all(.circular(10)),
                        ),
                        child: Padding(
                          padding: .all(20),
                          child: Text("""
Important: Check Existing Accounts Before Adding New Ones

To prevent duplicate account names with conflicting codes, please verify if an account already exists before creating a new entry. Please adhere to the following numbering conventions:

Account Type	Code Prefixes: 
    Assets              -          1xxx+ 	
    Liabilities         -          2xxx+ 
    Equity              -          3xxx+  
    Revenue             -          4xxx+
    Expenses            -          5xxx+
    Contra Accounts     -          6xxx+
                    """, textAlign: .justify),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
