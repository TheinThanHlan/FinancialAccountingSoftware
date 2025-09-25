import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/data/dao/COADao.dart';
import 'package:financial_accounting_software/data/model/COA.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './AddNewAccountController.dart';
import 'package:winter/winter.dart';

class AddNewAccount extends StatelessWidget {
  late final AddNewAccountController c;

  @override
  Widget build(BuildContext context) {
    //    return LayoutBuilder(builder: (context, constraints) {
    //      return Desktop(c);
    //    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          //color: getIt<GlobalStyle>().backgroundColor,
          child: Row(
            spacing: 13,
            children: [
              Container(
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    c.data!.completeAddNewAccount();
                  },
                ),
              ),
              Text(c.languageFactory.getLang(0), style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
        ),
        Expanded(
          child: Form(
            key: c.formKey,
            child: Column(
              spacing: 34,
              children: [
                TextFormField(
                  decoration: InputDecoration(label: Text(c.languageFactory.getLang(1))),
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(label: Text(c.languageFactory.getLang(3))),
                  onChanged: (a) {
                    c.code = int.parse(a);
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
                ValueListenableBuilder(
                  valueListenable: c.debitOrCredit,
                  builder: (context, value, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...c.debitAndCredit.entries.map((a) {
                          return SizedBox(
                            width: 225,
                            height: 55,
                            child: ListTile(
                              title: Text(a.key),
                              leading: Radio<String>(
                                value: a.key,
                                groupValue: value,
                                onChanged: (v) {
                                  c.debitOrCredit.value = a.key;
                                },
                              ),
                              onTap: () {
                                c.debitOrCredit.value = a.key;
                              },
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
                ElevatedButton(
                  child: Text(c.languageFactory.getLang(8)),
                  onPressed: () {
                    if (c.formKey.currentState!.validate()) {
                      getIt<COADao>().add(COA(0, c.code, c.account, c.debitAndCredit[c.debitOrCredit] ?? false, false));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
