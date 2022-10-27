//

import 'package:flutter/material.dart';

import '../database/models/object_label.dart';
import '../styling/styling.dart';

class AppAutoComplete extends StatelessWidget {
  const AppAutoComplete({
    Key? key,
    required this.objectsList,
    required this.onSelected,
  }) : super(key: key);

  final List<ObjectTitle> objectsList;
  final Function(ObjectTitle) onSelected;
  @override
  Widget build(BuildContext context) {
    String displayStringForOption(ObjectTitle option) => option.title;
    return Autocomplete<ObjectTitle>(
      displayStringForOption: displayStringForOption,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          style: Topology.darkMeduimBody,
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (value) => onFieldSubmitted(),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusColor: Colors.amber,
            isCollapsed: true,
            hintText: 'Select accnount',

            hintStyle: Topology.darkMeduimBody.copyWith(
              color: Colors.grey,
            ),
            // suffixIcon: IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.arrow_drop_down_outlined),
            // ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<ObjectTitle>.empty();
        }
        return objectsList.where((element) {
          return element.title
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final ObjectTitle option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () => onSelected(option),
                    child: ListTile(
                      title: Text(
                        option.title,
                        style: Topology.darkMeduimBody,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      onSelected: (ObjectTitle selection) {
        onSelected(selection);
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
    );
  }
}
