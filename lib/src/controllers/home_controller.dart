import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  FocusNode focusNode = FocusNode();
  late SharedPreferences storage;

  ObservableList<String> items = <String>[].asObservable();

  @observable
  TextEditingController textController = TextEditingController();

  @observable
  TextEditingController editingController = TextEditingController();

  @observable
  bool isAddEnabled = false;

  @observable
  bool isEditingEnabled = false;

  @action
  validateText(){
    textController.value.text.isNotEmpty ? isAddEnabled = true : isAddEnabled = false;
  }

  @action
  validateEditing(){
    editingController.value.text.isNotEmpty ? isEditingEnabled = true : isEditingEnabled = false;
  }

  @action
  init() async {
    storage = await SharedPreferences.getInstance();
    var items = storage.getStringList('notes');
    if (items != null) {
      this.items.addAll(items);
    }
  }

  // @action
  // toJSONEncodable() {
  //   return items.map((item) {
  //     return item.toJSONEncodable();
  //   }).toList();
  // }

  @action
  addItem() {
    items.add(textController.value.text);
    saveToStorage();
  }

  @action
  saveToStorage() {
    storage.setStringList('notes', items.toList());
  }

  @action
  deleteItem(int index){
    items.removeAt(index);
    saveToStorage();
  }

  @action
  editItem(int index){
    items[index] = editingController.text;
    saveToStorage();
  }
}