import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/src/form_builder_input.dart';

import './form_builder_input.dart';

//TODO: Refactor this spaghetti code
class FormBuilder extends StatefulWidget {
  final BuildContext context;
  final Function(Map<String, dynamic>) onChanged;
  final WillPopCallback onWillPop;
  final List<FormBuilderInput> controls;
  final bool readonly;
  final bool autovalidate;
  final GlobalKey<FormBuilderState> key;

  const FormBuilder(
    this.context, {
    @required this.controls,
    this.readonly = false,
    this.key,
    this.onChanged,
    this.autovalidate = false,
    this.onWillPop,
  }) : super(key: key);

  // assert(duplicateAttributes(controls).length == 0, "Duplicate attribute names not allowed");

  //FIXME: Find way to assert no duplicates in control attributes
  /*Function duplicateAttributes = (List<FormBuilderInput> controls) {
    List<String> attributeList = [];
    controls.forEach((c) {
      attributeList.add(c.attribute);
    });
    List<String> uniqueAttributes = Set.from(attributeList).toList(growable: false);
    //attributeList.
  };*/

  static FormBuilder of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(FormBuilder) as FormBuilder;
  }

  @override
  FormBuilderState createState() => FormBuilderState();
}

class FormBuilderState extends State<FormBuilder> {
  GlobalKey<FormState> _formKey;
  Map<String, dynamic> value;
  Map<String, GlobalKey<FormFieldState>> _fieldKeys;

  initState(){
    _formKey = GlobalKey<FormState>();
    value = {};
    _fieldKeys = {};
    super.initState();
  }

  save() {
    _formKey.currentState.save();
  }

  GlobalKey<FormFieldState> findFieldByAttribute(String attribute) {
    return _fieldKeys[attribute];
  }

  bool validate() {
    return _formKey.currentState.validate();
  }

  updateFieldValue(String attribute, dynamic val) {
    setState(() {
      value[attribute] = val;
    });
  }

  reset() {
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      //TODO: Allow user to update field value or validate based on changes in others (e.g. Summations, Confirm Password)
      onChanged: () {
        if (widget.onChanged != null) {
          _formKey.currentState.save();
          widget.onChanged(value);
        }
      },
      onWillPop: widget.onWillPop,
      autovalidate: widget.autovalidate,
      child: Column(
        children: widget.controls,
      ),
    );
  }
}
