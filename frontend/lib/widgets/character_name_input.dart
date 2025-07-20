import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CharacterNameInput extends StatefulWidget {
  final List<String> names;
  final Function(List<String>) onChanged;
  final bool enabled;

  const CharacterNameInput({
    super.key,
    required this.names,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  State<CharacterNameInput> createState() => _CharacterNameInputState();
}

class _CharacterNameInputState extends State<CharacterNameInput> {
  late List<String> _names;

  @override
  void initState() {
    super.initState();
    _names = List.from(widget.names);
    if (_names.isEmpty) {
      _names.add(''); // Start with at least one empty field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Character Names',
        ),
        const SizedBox(height: 8),
        ..._buildNameFields(),
        if (widget.enabled)
          ShadButton.outline(
            onPressed: _addNameField,
            icon: const Icon(Icons.add),
            child: const Text('Add Character'),
          ),
      ],
    );
  }

  List<Widget> _buildNameFields() {
    return _names.asMap().entries.map((entry) {
      int index = entry.key;
      String name = entry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Expanded(
              child: ShadInput(
                initialValue: name,
                onChanged: (value) {
                  setState(() {
                    _names[index] = value;
                    widget.onChanged(
                        _names.where((name) => name.isNotEmpty).toList());
                  });
                },
                enabled: widget.enabled,
                placeholder: Text('Character ${index + 1}'),
              ),
            ),
            if (widget.enabled && _names.length > 1)
              ShadButton.outline(
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.redAccent,
                ),
                foregroundColor: Colors.redAccent,
                onPressed: () => _removeNameField(index),
              ),
          ],
        ),
      );
    }).toList();
  }

  void _addNameField() {
    setState(() {
      _names.add('');
    });
  }

  void _removeNameField(int index) {
    setState(() {
      _names.removeAt(index);
      widget.onChanged(_names.where((name) => name.isNotEmpty).toList());
    });
  }
}
