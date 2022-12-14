//

import 'package:flutter/material.dart';

import '../database/models/object_label.dart';
import '../styling/styling.dart';

class AppAutoComplete extends StatelessWidget {
  const AppAutoComplete(
      {Key? key,
      required this.objectsList,
      required this.onSelected,
      this.initialValue = '',
      this.hint,
      this.onChange})
      : super(key: key);

  final List<ObjectTitle> objectsList;
  final String? hint;
  final String initialValue;
  final Function(ObjectTitle) onSelected;
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    String displayStringForOption(ObjectTitle option) => option.title;
    return Autocomplete<ObjectTitle>(
      initialValue: TextEditingValue(text: initialValue),
      displayStringForOption: displayStringForOption,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          style: Topology.darkLargBody,
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (value) => onFieldSubmitted(),
          onChanged: (value) {
            if (onChange != null) {
              onChange!(value);
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
            hintText: hint,

            hintStyle: Topology.darkLargBody.copyWith(
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
