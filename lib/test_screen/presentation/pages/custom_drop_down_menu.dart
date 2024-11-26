import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/drop_down_item_model.dart';
import '../manager/drop_down_bloc.dart';

class CustomDropDownMenu extends StatelessWidget {
  final List<DropDownItem> items;

  const CustomDropDownMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DropDownBloc(items),
      child: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (modalContext) => BlocProvider.value(
                value: BlocProvider.of<DropDownBloc>(context),
                child: BlocBuilder<DropDownBloc, DropDownState>(
                  builder: (context, state) {
                    final filteredItems = state.items
                        .where((item) => item.title
                        .toLowerCase()
                        .contains(state.searchQuery.toLowerCase()))
                        .toList();

                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Column(
                        children: [
                     SizedBox(height:MediaQuery.of(context).size.height*0.1 ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: filteredItems.length,
                              itemBuilder: (_, index) {
                                final item = filteredItems[index];
                                return ListTile(
                                  leading: state.isMultiSelect
                                      ? Checkbox(
                                    value: item.isSelected,
                                    onChanged: (_) => context
                                        .read<DropDownBloc>()
                                        .add(UpdateSelection(item.id)),
                                  )
                                      : null,
                                  title: Text(item.title),
                                  onTap: () {
                                    if (state.isMultiSelect) {
                                      context
                                          .read<DropDownBloc>()
                                          .add(UpdateSelection(item.id));
                                    } else {
                                      Navigator.of(modalContext).pop();
                                      showDialog(
                                        context: context,
                                        builder: (dialogContext) =>
                                            AlertDialog.adaptive(
                                              title: const Text("Selected"),
                                              content: Text(
                                                  "You selected: '${item.title}'"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(dialogContext)
                                                          .pop(),
                                                  child: const Text("OK"),
                                                ),
                                              ],
                                            ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          if (state.isMultiSelect)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(modalContext);
                                  final selectedItems = state.items
                                      .where((item) => item.isSelected)
                                      .map((item) => item.title)
                                      .toList();
                                  showDialog(
                                    context: context,
                                    builder: (dialogContext) =>
                                        AlertDialog.adaptive(
                                          title: const Text("Selected"),
                                          content: Text(
                                            "You selected:\n${selectedItems.join(', ')}",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(dialogContext).pop(),
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                child: const Text("Confirm Selection"),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
          child: const Text("Open Dropdown"),
        ),
      ),
    );
  }
}

