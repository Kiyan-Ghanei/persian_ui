import 'package:flutter/material.dart';

/// A reusable Material 3 date picker field designed for Persian and RTL
/// interfaces.
///
/// [PDatePickerField] is a controlled component. The current selected date is
/// provided through [value], and changes are reported through [onChanged].
///
/// The field opens Flutter's Material date picker when tapped. The component
/// uses [DateTime] as its value type and does not implement a calendar system
/// of its own.
///
/// The displayed date is formatted using Flutter's
/// [MaterialLocalizations], so localization and text direction remain under
/// the application's control.
///
/// When [onChanged] is null or [enabled] is false, the field is disabled.
///
/// The component does not impose a fixed width or height and supports
/// constrained and responsive layouts.
class PDatePickerField extends StatefulWidget {
  /// Creates a [PDatePickerField].
  const PDatePickerField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.hintText,
    this.firstDate,
    this.lastDate,
    this.enabled = true,
    this.padding,
  });

  /// The currently selected date.
  ///
  /// A null value means that no date is currently selected.
  final DateTime? value;

  /// Called when the user selects a date.
  ///
  /// When null, the field is disabled.
  final ValueChanged<DateTime?>? onChanged;

  /// Optional widget describing the date field.
  final Widget? label;

  /// Optional text displayed when no date is selected.
  final String? hintText;

  /// The earliest selectable date.
  final DateTime? firstDate;

  /// The latest selectable date.
  final DateTime? lastDate;

  /// Whether the field is interactive.
  ///
  /// When false, the field is disabled regardless of [onChanged].
  final bool enabled;

  /// Optional outer padding around the date field.
  final EdgeInsetsGeometry? padding;

  @override
  State<PDatePickerField> createState() => _PDatePickerFieldState();
}

class _PDatePickerFieldState extends State<PDatePickerField> {
  late final TextEditingController _controller;

  static final DateTime _defaultFirstDate = DateTime(1900);
  static final DateTime _defaultLastDate = DateTime(2100);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncControllerText();
  }

  @override
  void didUpdateWidget(covariant PDatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _syncControllerText();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DateTime _effectiveFirstDate() {
    return widget.firstDate ?? _defaultFirstDate;
  }

  DateTime _effectiveLastDate() {
    return widget.lastDate ?? _defaultLastDate;
  }

  DateTime _effectiveInitialDate() {
    final first = _effectiveFirstDate();
    final last = _effectiveLastDate();

    final candidate = widget.value ?? DateTime.now();

    if (candidate.isBefore(first)) {
      return first;
    }

    if (candidate.isAfter(last)) {
      return last;
    }

    return candidate;
  }

  String _formattedValue() {
    final value = widget.value;

    if (value == null) {
      return '';
    }

    return MaterialLocalizations.of(context).formatMediumDate(value);
  }

  void _syncControllerText() {
    final formattedValue = _formattedValue();

    if (_controller.text == formattedValue) {
      return;
    }

    _controller.value = TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  Future<void> _openDatePicker() async {
    if (!widget.enabled || widget.onChanged == null) {
      return;
    }

    final first = _effectiveFirstDate();
    final last = _effectiveLastDate();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _effectiveInitialDate(),
      firstDate: first,
      lastDate: last,
    );

    if (!mounted || selectedDate == null) {
      return;
    }

    widget.onChanged!(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      readOnly: true,
      enabled: widget.enabled && widget.onChanged != null,
      onTap: _openDatePicker,
      controller: _controller,
      decoration: InputDecoration(
        label: widget.label,
        hintText: widget.hintText,
        suffixIcon: const Icon(Icons.calendar_today_outlined),
      ),
    );

    if (widget.padding == null) {
      return field;
    }

    return Padding(padding: widget.padding!, child: field);
  }
}
