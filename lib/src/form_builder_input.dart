import 'dart:typed_data';
import 'dart:ui';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_form_builder/src/form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:signature/signature.dart';
import 'package:intl/intl.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

import './form_builder_input_option.dart';

// ignore: must_be_immutable
class FormBuilderInput extends StatefulWidget {
  static const String TYPE_TEXT = "Text";
  static const String TYPE_NUMBER = "Number";
  static const String TYPE_EMAIL = "Email";
  static const String TYPE_MULTILINE_TEXT = "MultilineText";
  static const String TYPE_PASSWORD = "Password";
  static const String TYPE_RADIO = "Radio";
  static const String TYPE_CHECKBOX_LIST = "CheckboxList";
  static const String TYPE_CHECKBOX = "Checkbox";
  static const String TYPE_SWITCH = "Switch";
  static const String TYPE_SLIDER = "Slider";
  static const String TYPE_DROPDOWN = "Dropdown";
  static const String TYPE_DATE_PICKER = "DatePicker";
  static const String TYPE_TIME_PICKER = "TimePicker";
  static const String TYPE_DATE_TIME_PICKER = "DateTimePicker";
  static const String TYPE_URL = "Url";
  static const String TYPE_TYPE_AHEAD = "TypeAhead";
  static const String TYPE_PHONE = "Phone";
  static const String TYPE_STEPPER = "Stepper";
  static const String TYPE_RATE = "Rate";
  static const String TYPE_SEGMENTED_CONTROL = "SegmentedControl";
  static const String TYPE_CHIPS_INPUT = "ChipsInput";
  static const String TYPE_SIGNATURE_PAD = "DrawingPad";

  Widget label;
  String attribute;
  String type;
  bool readonly;
  String helperText;
  InputDecoration decoration;
  dynamic value;
  bool require;
  dynamic min;
  dynamic max;
  int divisions;
  Color penColor;
  Color backgroundColor;
  double penStrokeWidth;
  double height;
  double width;
  List<Point> points;
  num step;
  String format;
  IconData icon;
  double iconSize;
  DateTime firstDate; //TODO: Use min?
  DateTime lastDate; //TODO: Use max?
  FormFieldValidator<dynamic> validator;
  List<FormBuilderInputOption> options;
  SuggestionsCallback suggestionsCallback;
  ItemBuilder itemBuilder;
  ChipsBuilder suggestionBuilder;
  ChipsBuilder chipBuilder;
  int maxLines;
  bool autovalidate;
  ValueChanged<dynamic> onChanged;

  //Inputs for typeahead
  bool getImmediateSuggestions;
  ErrorBuilder errorBuilder;
  WidgetBuilder noItemsFoundBuilder;
  WidgetBuilder loadingBuilder;
  Duration debounceDuration;
  SuggestionsBoxDecoration suggestionsBoxDecoration;
  double suggestionsBoxVerticalOffset;
  AnimationTransitionBuilder transitionBuilder;
  Duration animationDuration;
  double animationStart;
  AxisDirection direction;
  bool hideOnLoading;
  bool hideOnEmpty;
  bool hideOnError;
  bool hideSuggestionsOnKeyboardHide;
  bool keepSuggestionsOnLoading;

  FormBuilderInput.textField({
    @required this.decoration,
    @required this.type,
    @required this.attribute,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
    this.min,
    this.max,
    this.maxLines = 5,
    this.autovalidate = false,
    this.onChanged,
  })
      : assert(min == null || min is int),
        assert(max == null || max is int);

  FormBuilderInput.password({
    @required this.decoration,
    @required this.attribute,
    this.readonly = false,
    this.value,
    this.require = false,
    this.autovalidate = false,
    this.validator,
    this.min,
    this.max,
  })
      : assert(min == null || min is int),
        assert(max == null || max is int) {
    type = FormBuilderInput.TYPE_PASSWORD;
  }

  FormBuilderInput.typeAhead({
    @required this.decoration,
    this.label,
    @required this.attribute,
    @required this.itemBuilder,
    @required this.suggestionsCallback,
    this.autovalidate = false,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
    this.getImmediateSuggestions = false,
    this.errorBuilder,
    this.noItemsFoundBuilder,
    this.loadingBuilder,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.suggestionsBoxDecoration = const SuggestionsBoxDecoration(),
    this.suggestionsBoxVerticalOffset = 5.0,
    this.transitionBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationStart = 0.25,
    this.direction = AxisDirection.down,
    this.hideOnLoading = false,
    this.hideOnEmpty = false,
    this.hideOnError = false,
    this.hideSuggestionsOnKeyboardHide = true,
    this.keepSuggestionsOnLoading = true,
  }) {
    type = FormBuilderInput.TYPE_TYPE_AHEAD;
  }

  FormBuilderInput.signaturePad({
    @required this.decoration,
    @required this.attribute,
    this.autovalidate = false,
    this.readonly = false,
    this.penColor = Colors.black,
    this.penStrokeWidth = 3,
    this.width,
    this.points,
    this.height = 250,
    this.backgroundColor = Colors.white70,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_SIGNATURE_PAD;
  }

  FormBuilderInput.number({
    @required this.decoration,
    @required this.attribute,
    this.autovalidate = false,
    this.readonly = false,
    this.value,
    this.min,
    this.max,
    this.require = false,
    this.validator,
  })
      : assert(min == null || min is num),
        assert(max == null || max is num),
        assert(min == null || max == null || min <= max,
        "Min cannot be higher than Max") {
    type = FormBuilderInput.TYPE_NUMBER;
  }

  FormBuilderInput.stepper({
    @required this.decoration,
    @required this.attribute,
    this.autovalidate = false,
    this.readonly = false,
    this.value,
    this.min,
    this.max,
    this.step,
    this.require = false,
    this.validator,
  })
      : assert(min == null || min is num),
        assert(max == null || max is num),
        assert(min == null || max == null || min <= max,
        "Min cannot be higher than Max") {
    type = FormBuilderInput.TYPE_STEPPER;
  }

  FormBuilderInput.rate({
    @required this.decoration,
    @required this.attribute,
    @required this.max,
    this.autovalidate = false,
    this.readonly = false,
    this.value,
    this.icon,
    this.iconSize,
    this.require = false,
    this.validator,
  })
      : assert(max == null || max is num),
        assert(max > value || value == null,
        "Initial value cannot be higher than Max") {
    type = FormBuilderInput.TYPE_RATE;
  }

  FormBuilderInput.slider({
    this.autovalidate = false,
    @required this.decoration,
    @required this.attribute,
    @required this.min,
    @required this.max,
    @required this.value,
    this.readonly = false,
    this.divisions,
    this.require = false,
    this.validator,
  })
      : assert(min == null || min is num),
        assert(max == null || max is num) {
    type = FormBuilderInput.TYPE_SLIDER;
  }

  FormBuilderInput.dropdown({
    @required this.decoration,
    @required this.options,
    @required this.attribute,
    this.autovalidate = false,
    this.helperText,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_DROPDOWN;
  }

  FormBuilderInput.radio({
    @required this.decoration,
    @required this.attribute,
    @required this.options,
    this.autovalidate = false,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_RADIO;
  }

  FormBuilderInput.segmentedControl({
    @required this.decoration,
    @required this.attribute,
    @required this.options,
    this.autovalidate = false,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_SEGMENTED_CONTROL;
  }

  FormBuilderInput.checkbox({
    this.decoration = const InputDecoration(),
    @required this.label,
    @required this.attribute,
    this.autovalidate = false,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) : assert(value == null || value is bool,
  "Initial value for a checkbox should be boolean") {
    type = FormBuilderInput.TYPE_CHECKBOX;
  }

  FormBuilderInput.switchInput({
    this.decoration = const InputDecoration(),
    @required this.label,
    @required this.attribute,
    this.autovalidate = false,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) : assert(value == null || value is bool,
  "Initial value for a switch should be boolean") {
    type = FormBuilderInput.TYPE_SWITCH;
  }

  FormBuilderInput.checkboxList({
    @required this.decoration,
    @required this.options,
    @required this.attribute,
    this.autovalidate = false,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) : assert(value == null || value is List) {
    value == value ?? []; // ignore: unnecessary_statements
    type = FormBuilderInput.TYPE_CHECKBOX_LIST;
  }

  FormBuilderInput.datePicker({
    @required this.decoration,
    @required this.attribute,
    this.autovalidate = false,
    this.readonly = false,
    // @Deprecated('Use attribute: min')
    this.firstDate,
    // this.min,
    // @Deprecated('Use attribute: max')
    this.lastDate,
    this.max,
    this.format,
    this.value,
    this.require = false,
    this.validator,
  }) /*: assert(min == null || min is DateTime),
        assert(max == null || max is DateTime),
        assert(min == null || firstDate == null),
        assert(max == null || lastDate == null)*/ {
    type = FormBuilderInput.TYPE_DATE_PICKER;
  }

  FormBuilderInput.dateTimePicker({
    @required this.decoration,
    @required this.attribute,
    this.readonly = false,
    this.autovalidate = false,
    // @Deprecated('Use attribute: min')
    this.firstDate,
    // this.min,
    // @Deprecated('Use attribute: max')
    this.lastDate,
    // this.max,
    this.format,
    this.value,
    this.require = false,
    this.validator,
  }) /*: assert(min == null || min is DateTime),
        assert(max == null || max is DateTime),
        assert(min == null || firstDate == null),
        assert(max == null || lastDate == null) */{
    type = FormBuilderInput.TYPE_DATE_TIME_PICKER;
  }

  FormBuilderInput.timePicker({
    @required this.decoration,
    @required this.attribute,
    this.autovalidate = false,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) {
    type = FormBuilderInput.TYPE_TIME_PICKER;
  }

  FormBuilderInput.chipsInput({
    this.autovalidate = false,
    @required this.decoration,
    @required this.attribute,
    @required this.suggestionsCallback,
    @required this.suggestionBuilder,
    @required this.chipBuilder,
    this.readonly = false,
    this.value,
    this.require = false,
    this.validator,
  }) : assert(value == null || value is List) {
    type = FormBuilderInput.TYPE_CHIPS_INPUT;
  }

  @override
  FormBuilderInputState createState() => FormBuilderInputState();
}

class FormBuilderInputState extends State<FormBuilderInput> {
  GlobalKey<FormFieldState> _fieldKey;

  @override
  void initState() {
    _fieldKey = GlobalKey(debugLabel: widget.attribute);
    super.initState();
  }

  final _dateTimeFormats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  get value => _fieldKey.currentState.value;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case FormBuilderInput.TYPE_TEXT:
      case FormBuilderInput.TYPE_PASSWORD:
      case FormBuilderInput.TYPE_NUMBER:
      case FormBuilderInput.TYPE_PHONE:
      case FormBuilderInput.TYPE_EMAIL:
      case FormBuilderInput.TYPE_URL:
      case FormBuilderInput.TYPE_MULTILINE_TEXT:
        TextInputType keyboardType;
        switch (widget.type) {
          case FormBuilderInput.TYPE_NUMBER:
            keyboardType = TextInputType.number;
            break;
          case FormBuilderInput.TYPE_EMAIL:
            keyboardType = TextInputType.emailAddress;
            break;
          case FormBuilderInput.TYPE_URL:
            keyboardType = TextInputType.url;
            break;
          case FormBuilderInput.TYPE_PHONE:
            keyboardType = TextInputType.phone;
            break;
          case FormBuilderInput.TYPE_MULTILINE_TEXT:
            keyboardType = TextInputType.multiline;
            break;
          default:
            keyboardType = TextInputType.text;
            break;
        }
        return TextFormField(
          key: _fieldKey,
          enabled: !(widget.readonly || widget.readonly),
          style: (widget.readonly || widget.readonly)
              ? Theme
              .of(context)
              .textTheme
              .subhead
              .copyWith(
            color: Theme
                .of(context)
                .disabledColor,
          )
              : null,
          focusNode: (widget.readonly || widget.readonly)
              ? AlwaysDisabledFocusNode()
              : null,
          decoration: widget.decoration.copyWith(
            enabled: !(widget.readonly || widget.readonly),
          ),
          autovalidate: widget.autovalidate ?? false,
          initialValue:
          widget.value != null ? "${widget.value}" : '',
          maxLines:
          widget.type == FormBuilderInput.TYPE_MULTILINE_TEXT
              ? widget.maxLines
              : 1,
          keyboardType: keyboardType,
          obscureText:
          widget.type == FormBuilderInput.TYPE_PASSWORD
              ? true
              : false,
          onFieldSubmitted: (data) {
            if (widget.onChanged != null)
              widget.onChanged(data);
          },
          validator: (val) {
            if (widget.require && val.isEmpty)
              return "${widget.attribute} is required";

            if (widget.type == FormBuilderInput.TYPE_NUMBER) {
              if (num.tryParse(val) == null && val.isNotEmpty)
                return "$val is not a valid number";
              if (widget.max != null &&
                  num.tryParse(val) > widget.max)
                return "${widget.attribute} should not be greater than ${widget
                    .max}";
              if (widget.min != null &&
                  num.tryParse(val) < widget.min)
                return "${widget.attribute} should not be less than ${widget
                    .min}";
            } else {
              if (widget.max != null &&
                  val.length > widget.max)
                return "${widget.attribute} should have ${widget
                    .max} character(s) or less";
              if (widget.min != null &&
                  val.length < widget.min)
                return "${widget.attribute} should have ${widget
                    .min} character(s) or more";
            }

            if (widget.type == FormBuilderInput.TYPE_EMAIL &&
                val.isNotEmpty) {
              Pattern pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              if (!RegExp(pattern).hasMatch(val))
                return '$val is not a valid email address';
            }

            if (widget.type == FormBuilderInput.TYPE_URL &&
                val.isNotEmpty) {
              Pattern pattern =
                  r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
              if (!RegExp(pattern, caseSensitive: false).hasMatch(val))
                return '$val is not a valid URL';
            }

            if (widget.validator != null)
              return widget.validator(val);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
          // autovalidate: ,
        );
        break;

      case FormBuilderInput.TYPE_DATE_TIME_PICKER:
        return DateTimePickerFormField(
          key: _fieldKey,
          inputType: InputType.both,
          initialValue: widget.value,
          format: widget.format != null
              ? DateFormat(widget.format)
              : _dateTimeFormats[InputType.both],
          enabled: !(widget.readonly || widget.readonly),
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          decoration: widget.decoration.copyWith(
            enabled: !(widget.readonly || widget.readonly),
          ),
          validator: (val) {
            if (widget.require && val == null)
              return "${widget.attribute} is required";
            if (widget.validator != null)
              return widget.validator(val);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
        );
        break;

      case FormBuilderInput.TYPE_DATE_PICKER:
        return DateTimePickerFormField(
          key: _fieldKey,
          inputType: InputType.date,
          initialValue: widget.value,
          format: widget.format != null
              ? DateFormat(widget.format)
              : _dateTimeFormats[InputType.date],
          enabled: !(widget.readonly || widget.readonly),
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          decoration: widget.decoration.copyWith(
            enabled: !(widget.readonly || widget.readonly),
          ),
          validator: (val) {
            if (widget.require && val == null)
              return "${widget.attribute} is required";
            if (widget.validator != null)
              return widget.validator(val);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
        );
        break;

      case FormBuilderInput.TYPE_TIME_PICKER:
        return DateTimePickerFormField(
          key: _fieldKey,
          inputType: InputType.time,
          initialValue: widget.value,
          format: widget.format != null
              ? DateFormat(widget.format)
              : _dateTimeFormats[InputType.time],
          enabled: !(widget.readonly || widget.readonly),
          decoration: widget.decoration.copyWith(
            enabled: !(widget.readonly || widget.readonly),
          ),
          validator: (val) {
            if (widget.require && val == null)
              return "${widget.attribute} is required";
            if (widget.validator != null)
              return widget.validator(val);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
        );
        break;

      case FormBuilderInput.TYPE_TYPE_AHEAD:
        TextEditingController _typeAheadController =
        TextEditingController(text: widget.value);
        return TypeAheadFormField(
          key: _fieldKey,
          textFieldConfiguration: TextFieldConfiguration(
            enabled: !(widget.readonly || widget.readonly),
            controller: _typeAheadController,
            style: (widget.readonly || widget.readonly)
                ? Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(
              color: Theme
                  .of(context)
                  .disabledColor,
            )
                : null,
            focusNode: (widget.readonly || widget.readonly)
                ? AlwaysDisabledFocusNode()
                : null,
            decoration: widget.decoration.copyWith(
              enabled: !(widget.readonly || widget.readonly),
            ),
          ),
          suggestionsCallback: widget.suggestionsCallback,
          itemBuilder: widget.itemBuilder,
          transitionBuilder: (context, suggestionsBox, controller) =>
          suggestionsBox,
          onSuggestionSelected: (suggestion) {
            _typeAheadController.text = suggestion;
          },
          validator: (val) {
            if (widget.require && val.isEmpty)
              return '${widget.attribute} is required';
            if (widget.validator != null)
              return widget.validator(val);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
          getImmediateSuggestions: widget.getImmediateSuggestions,
          errorBuilder: widget.errorBuilder,
          noItemsFoundBuilder: widget.noItemsFoundBuilder,
          loadingBuilder: widget.loadingBuilder,
          debounceDuration: widget.debounceDuration,
          suggestionsBoxDecoration:
          widget.suggestionsBoxDecoration,
          suggestionsBoxVerticalOffset:
          widget.suggestionsBoxVerticalOffset,
          // transitionBuilder: widget.transitionBuilder,
          animationDuration: widget.animationDuration,
          animationStart: widget.animationStart,
          direction: widget.direction,
          hideOnLoading: widget.hideOnLoading,
          hideOnEmpty: widget.hideOnEmpty,
          hideOnError: widget.hideOnError,
          hideSuggestionsOnKeyboardHide:
          widget.hideSuggestionsOnKeyboardHide,
          keepSuggestionsOnLoading:
          widget.keepSuggestionsOnLoading,
        );
        break;

      case FormBuilderInput.TYPE_DROPDOWN:
        return FormField(
          key: _fieldKey,
          enabled: !(widget.readonly || widget.readonly),
          initialValue: widget.value,
          validator: (val) {
            if (widget.require && val == null)
              return "${widget.attribute} is required";
            if (widget.validator != null)
              return widget.validator(val);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: widget.decoration.copyWith(
                enabled: !(widget.readonly || widget.readonly),
                errorText: field.errorText,
                contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                border: InputBorder.none,
              ),
              child: DropdownButton(
                isExpanded: true,
                // hint: Text(widget.hint ?? ''), //TODO: Dropdown may require hint
                items: widget.options.map((option) {
                  return DropdownMenuItem(
                    child: Text("${option.label ?? option.value}"),
                    value: option.value,
                  );
                }).toList(),
                value: field.value,
                onChanged: (widget.readonly || widget.readonly)
                    ? null
                    : (value) {
                  field.didChange(value);
                },
              ),
            );
          },
        );
        break;

    //TODO: For TYPE_CHECKBOX, TYPE_CHECKBOX_LIST, TYPE_RADIO allow user to choose if checkbox/radio to appear before or after Label
      case FormBuilderInput.TYPE_RADIO:
        return FormField(
          key: _fieldKey,
          enabled: !widget.readonly && !widget.readonly,
          initialValue: widget.value,
          validator: (value) {
            if (widget.require && value == null)
              return "${widget.attribute} is required";
            if (widget.validator != null)
              return widget.validator(value);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
          builder: (FormFieldState<dynamic> field) {
            List<Widget> radioList = [];
            for (int i = 0; i < widget.options.length; i++) {
              radioList.addAll([
                ListTile(
                  dense: true,
                  isThreeLine: false,
                  contentPadding: EdgeInsets.all(0.0),
                  leading: null,
                  title: Text(
                      "${widget.options[i].label ?? widget.options[i].value}"),
                  trailing: Radio<dynamic>(
                    value: widget.options[i].value,
                    groupValue: field.value,
                    onChanged: (widget.readonly || widget.readonly)
                        ? null
                        : (dynamic value) {
                      field.didChange(value);
                    },
                  ),
                  onTap: (widget.readonly || widget.readonly)
                      ? null
                      : () {
                    field.didChange(widget.options[i].value);
                  },
                ),
                Divider(
                  height: 0.0,
                ),
              ]);
            }
            return InputDecorator(
              decoration: widget.decoration.copyWith(
                enabled: !(widget.readonly || widget.readonly),
                errorText: field.errorText,
                contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                border: InputBorder.none,
              ),
              child: Column(
                children: radioList,
              ),
            );
          },
        );
        break;

      case FormBuilderInput.TYPE_SEGMENTED_CONTROL:
        return FormField(
          key: _fieldKey,
          initialValue: widget.value,
          enabled: !(widget.readonly || widget.readonly),
          validator: (value) {
            if (widget.require && value == null)
              return "${widget.require} is required";
            if (widget.validator != null)
              return widget.validator(value);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: widget.decoration.copyWith(
                enabled: !(widget.readonly || widget.readonly),
                errorText: field.errorText,
                contentPadding:
                EdgeInsets.only(top: 10.0, bottom: 10.0),
                border: InputBorder.none,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CupertinoSegmentedControl(
                  borderColor: (widget.readonly || widget.readonly)
                      ? Theme
                      .of(context)
                      .disabledColor
                      : Theme
                      .of(context)
                      .primaryColor,
                  selectedColor:
                  (widget.readonly || widget.readonly)
                      ? Theme
                      .of(context)
                      .disabledColor
                      : Theme
                      .of(context)
                      .primaryColor,
                  pressedColor:
                  (widget.readonly || widget.readonly)
                      ? Theme
                      .of(context)
                      .disabledColor
                      : Theme
                      .of(context)
                      .primaryColor,
                  groupValue: field.value,
                  children: Map.fromIterable(
                    widget.options,
                    key: (v) => v.value,
                    value: (v) =>
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text("${v.label ?? v.value}"),
                        ),
                  ),
                  onValueChanged: (dynamic value) {
                    if (widget.readonly || widget.readonly) {
                      field.reset();
                    } else
                      field.didChange(value);
                  },
                ),
              ),
            );
          },
        );
        break;

      case FormBuilderInput.TYPE_SWITCH:
        return FormField(
            key: _fieldKey,
            enabled: !(widget.readonly || widget.readonly),
            initialValue: widget.value ?? false,
            validator: (value) {
              if (widget.require && value == null)
                return "${widget.attribute} is required";
              /*if (widget.validator != null)
                    return widget.validator(value);*/
            },
            onSaved: (val){
              FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
            },
            builder: (FormFieldState<dynamic> field) {
              return InputDecorator(
                decoration: widget.decoration.copyWith(
                  enabled: !(widget.readonly || widget.readonly),
                  errorText: field.errorText,
                ),
                child: ListTile(
                  dense: true,
                  isThreeLine: false,
                  contentPadding: EdgeInsets.all(0.0),
                  title: widget.label,
                  trailing: Switch(
                    value: field.value,
                    onChanged: (widget.readonly || widget.readonly)
                        ? null
                        : (bool value) {
                      field.didChange(value);
                    },
                  ),
                  onTap: (widget.readonly || widget.readonly)
                      ? null
                      : () {
                    bool newValue = !(field.value ?? false);
                    field.didChange(newValue);
                  },
                ),
              );
            });
        break;

      case FormBuilderInput.TYPE_STEPPER:
        return FormField(
          enabled: !(widget.readonly || widget.readonly),
          key: _fieldKey,
          initialValue: widget.value,
          validator: (value) {
            if (widget.require && value == null)
              return "${widget.attribute} is required";
            if (widget.validator != null)
              return widget.validator(value);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: widget.decoration.copyWith(
                enabled: !(widget.readonly || widget.readonly),
                errorText: field.errorText,
              ),
              child: SyStepper(
                value: field.value ?? 0,
                step: widget.step ?? 1,
                min: widget.min ?? 0,
                max: widget.max ?? 9999999,
                size: 24.0,
                onChange: (widget.readonly || widget.readonly)
                    ? null
                    : (value) {
                  field.didChange(value);
                },
              ),
            );
          },
        );
        break;

      case FormBuilderInput.TYPE_RATE:
        return FormField(
          enabled: !(widget.readonly || widget.readonly),
          key: _fieldKey,
          initialValue: widget.value ?? 1,
          validator: (value) {
            if (widget.require && value == null)
              return "${widget.attribute} is required";
            if (widget.validator != null)
              return widget.validator(value);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: widget.decoration.copyWith(
                enabled: !(widget.readonly || widget.readonly),
                errorText: field.errorText,
              ),
              child: SyRate(
                value: field.value,
                total: widget.max,
                icon: widget.icon,
                //TODO: When disabled change icon color (Probably deep grey)
                iconSize: widget.iconSize ?? 24.0,
                onTap: (widget.readonly || widget.readonly)
                    ? null
                    : (value) {
                  field.didChange(value);
                },
              ),
            );
          },
        );
        break;

      case FormBuilderInput.TYPE_CHECKBOX:
        return FormField(
          key: _fieldKey,
          enabled: !(widget.readonly || widget.readonly),
          initialValue: widget.value ?? false,
          validator: (value) {
            if (widget.require && value == null)
              return "${widget.attribute} is required";
            if (widget.validator != null)
              return widget.validator(value);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: widget.decoration.copyWith(
                enabled: !(widget.readonly || widget.readonly),
                errorText: field.errorText,
              ),
              child: ListTile(
                dense: true,
                isThreeLine: false,
                contentPadding: EdgeInsets.all(0.0),
                title: widget.label,
                trailing: Checkbox(
                  value: field.value ?? false,
                  onChanged: (widget.readonly || widget.readonly)
                      ? null
                      : (bool value) {
                    field.didChange(value);
                  },
                ),
                onTap: (widget.readonly || widget.readonly)
                    ? null
                    : () {
                  bool newValue = !(field.value ?? false);
                  field.didChange(newValue);
                },
              ),
            );
          },
        );
        break;

      case FormBuilderInput.TYPE_SLIDER:
        return FormField(
          key: _fieldKey,
          enabled: !(widget.readonly || widget.readonly),
          initialValue: widget.value,
          validator: (value) {
            if (widget.require && value == null)
              return "${widget.attribute} is required";
            if (widget.validator != null)
              return widget.validator(value);
          },
          onSaved: (val){
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: widget.decoration.copyWith(
                enabled: !(widget.readonly || widget.readonly),
                errorText: field.errorText,
              ),
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Slider(
                      value: field.value,
                      min: widget.min,
                      max: widget.max,
                      divisions: widget.divisions,
                      onChanged:
                      (widget.readonly || widget.readonly)
                          ? null
                          : (double value) {
                        field.didChange(value);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("${widget.min}"),
                        Text("${field.value}"),
                        Text("${widget.max}"),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
        break;

      case FormBuilderInput.TYPE_CHECKBOX_LIST:
        return FormField(
            key: _fieldKey,
            enabled: !(widget.readonly || widget.readonly),
            initialValue: widget.value ?? [],
            validator: widget.validator,
            onSaved: (val){
              FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
            },
            builder: (FormFieldState<dynamic> field) {
              List<Widget> checkboxList = [];
              for (int i = 0; i < widget.options.length; i++) {
                checkboxList.addAll([
                  ListTile(
                    dense: true,
                    isThreeLine: false,
                    contentPadding: EdgeInsets.all(0.0),
                    leading: Checkbox(
                      value: field.value
                          .contains(widget.options[i].value),
                      onChanged: (widget.readonly ||
                          widget.readonly)
                          ? null
                          : (bool value) {
                        var currValue = field.value;
                        if (value)
                          currValue
                              .add(widget.options[i].value);
                        else
                          currValue.remove(
                              widget.options[i].value);
                        field.didChange(currValue);
                      },
                    ),
                    title: Text(
                        "${widget.options[i].label ??
                            widget.options[i].value}"),
                    onTap: (widget.readonly || widget.readonly)
                        ? null
                        : () {
                      var currentValue = field.value;
                      if (!currentValue
                          .contains(widget.options[i].value))
                        currentValue
                            .add(widget.options[i].value);
                      else
                        currentValue
                            .remove(widget.options[i].value);
                      field.didChange(currentValue);
                    },
                  ),
                  Divider(
                    height: 0.0,
                  ),
                ]);
              }
              return InputDecorator(
                decoration: widget.decoration.copyWith(
                  enabled: !(widget.readonly || widget.readonly),
                  errorText: field.errorText,
                  contentPadding:
                  EdgeInsets.only(top: 10.0, bottom: 0.0),
                  border: InputBorder.none,
                ),
                child: Column(
                  children: checkboxList,
                ),
              );
            });
        break;
      case FormBuilderInput.TYPE_CHIPS_INPUT:
        return SizedBox(
          // height: 200.0,
          child: FormField(
            key: _fieldKey,
            enabled: !(widget.readonly || widget.readonly),
            initialValue: widget.value ?? [],
            validator: (value) {
              if (widget.require && value.length == 0)
                return "${widget.attribute} is required";
              if (widget.validator != null)
                return widget.validator(value);
            },
            onSaved: (val){
              FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
            },
            builder: (FormFieldState<dynamic> field) {
              return ChipsInput(
                initialValue: field.value,
                enabled: !(widget.readonly || widget.readonly),
                decoration: widget.decoration.copyWith(
                  enabled: !(widget.readonly || widget.readonly),
                  errorText: field.errorText,
                ),
                findSuggestions: widget.suggestionsCallback,
                onChanged: (data) {
                  field.didChange(data);
                },
                chipBuilder: widget.chipBuilder,
                suggestionBuilder: widget.suggestionBuilder,
              );
            },
          ),
        );
        break;

      case FormBuilderInput.TYPE_SIGNATURE_PAD:
        var _signatureCanvas = Signature(
          points: widget.points,
          width: widget.width,
          height: widget.height,
          backgroundColor: widget.backgroundColor,
          penColor: widget.penColor,
          penStrokeWidth: widget.penStrokeWidth,
        );

        return FormField<Image>(
          key: Key(widget.attribute),
          enabled: !(widget.readonly || widget.readonly),
          initialValue: widget.value,
          onSaved: (val) async {
            Uint8List signature = await _signatureCanvas.exportBytes();
            var image = Image
                .memory(signature)
                .image;
            _fieldKey.currentState.didChange(image);
            FormBuilder.of(context).key.currentState.updateFieldValue(widget.attribute, val);
          },
          validator: (value) {
            if (widget.require && _signatureCanvas.isEmpty)
              return "${widget.attribute} is required";
            if (widget.validator != null)
              return widget.validator(value);
          },
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: widget.decoration.copyWith(
                enabled: !(widget.readonly || widget.readonly),
                errorText: field.errorText,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: GestureDetector(
                      onVerticalDragUpdate: (_) {},
                      child: _signatureCanvas,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: SizedBox()),
                      FlatButton(
                          onPressed: () {
                            _signatureCanvas.clear();
                            field.didChange(null);
                          },
                          child: Text('Clear')),
                    ],
                  ),
                ],
              ),
            );
          },
        );
        break;
      default:
        return Container();
        break;
    }
  }
}
