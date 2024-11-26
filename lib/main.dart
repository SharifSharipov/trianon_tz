
import 'package:flutter/material.dart';
import 'package:trianon_tz/test_screen/data/models/drop_down_item_model.dart';
import 'package:trianon_tz/test_screen/presentation/manager/drop_down_bloc.dart';
import 'package:trianon_tz/test_screen/presentation/pages/custom_drop_down_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (_) => DropDownBloc([]),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: const Text("Custom Dropdown")),
          body: Center(
            child: CustomDropDownMenu(
              items: List.generate(
                10,
                    (index) => DropDownItem(id: "$index", title: "Element $index"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
