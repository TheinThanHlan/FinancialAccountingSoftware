import 'package:flutter/material.dart';
import './HomeController.dart';
import 'package:winter/winter.dart';
import 'package:financial_accounting_software/GlobalStyle.dart';

class Home extends StatelessWidget {
  late final HomeController c;
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValueListenableBuilder(
        valueListenable: getIt<ValueNotifier<String>>(
          instanceName: "currentLanguage",
        ),
        builder: (context, widget, child) {
          return Scaffold(
            body: Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  width: 233,
                  color: getIt<GlobalStyle>().sideBarColor,
                  child: Column(
                    spacing: 13,
                    children: [
                      SizedBox(
                        height: 89,
                        child: Center(
                          child: Text(
                            c.languageFactory.getLang(0),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                      ...c.pages.entries.map((a) {
                        return ValueListenableBuilder(
                          valueListenable: c.currentPage,
                          builder: (context, widget, child) => ListTile(
                            title: Text(a.key),
                            leading: Icon(Icons.book),
                            selected: c.currentPage.value == a.key,
                            onTap: () {
                              c.currentPage.value = a.key;
                            },
                          ),
                        );
                      }),
                      Flexible(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ValueListenableBuilder(
                            valueListenable: getIt<ValueNotifier<String>>(
                              instanceName: "currentLanguage",
                            ),
                            builder: (context, value, child) {
                              return DropdownButton(
                                value: value,
                                onChanged: (a) {
                                  getIt<ValueNotifier<String>>(
                                    instanceName: "currentLanguage",
                                  ).value = a!;
                                },
                                items: c.supportedLanguages
                                    .map<DropdownMenuItem<String>>((x) {
                                      return DropdownMenuItem(
                                        child: Text(x.displayName),
                                        value: x.code,
                                      );
                                    })
                                    .toList(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ValueListenableBuilder(
                      valueListenable: c.currentPage,
                      builder: (context, widget, child) {
                        return c.pages[c.currentPage.value]!;
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
