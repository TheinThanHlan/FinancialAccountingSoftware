import 'package:financial_accounting_software/GlobalStyle.dart';
import 'package:financial_accounting_software/data/dao/AccountTypeDao.dart';
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
              Text(
                c.languageFactory.getLang(0),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                        c.accountType = ValueNotifier(snapshot.data!.first);
                        return ValueListenableBuilder(
                          valueListenable: c.accountType,
                          builder: (context, value, child) => DropdownButton(
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
                      if (await c.createNewAccount()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Success",

                              style: Theme.of(context).textTheme.headlineLarge!
                                  .copyWith(color: Colors.green),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Account already exist",
                              style: Theme.of(context).textTheme.headlineLarge!
                                  .copyWith(color: Colors.red),
                            ),
                          ),
                        );
                      }
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
