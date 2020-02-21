import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:squareneumorphic/models/item.dart';

class ItemInputControllers with ChangeNotifier {
  ItemInputControllers()
      : nameController = new TextEditingController(),
        descriptionController = new TextEditingController(),
        selectedOptions = new List<Option>();

  TextEditingController nameController, descriptionController;

  List<Option> selectedOptions;

  void addOption(Option selectedOption) {
    selectedOptions.add(selectedOption);
  }

  void removeOption(Option selectedOptionToRemove, num index) {
    OptionValue selectedOptionValueToRemove = selectedOptionToRemove.values[0];
    selectedOptions[index].removeValue(selectedOptionValueToRemove);
  }

  void updateOption(Option optionToUpdate) {
    int index = -1;
    OptionValue valueToUpdate = optionToUpdate.values[0];
    for (var i = 0; i < selectedOptions.length; i++) {
      if (selectedOptions[i].name == optionToUpdate.name) {
        index = i;
        break;
      }
    }
    if (index > -1) {
      selectedOptions[index].contains(valueToUpdate) > -1
          ? this.removeOption(optionToUpdate, index)
          : this.addOption(optionToUpdate);
    } else {
      this.addOption(optionToUpdate);
    }
  }
}
