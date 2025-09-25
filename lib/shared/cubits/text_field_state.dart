abstract class TextFieldState {}

class TextFieldsInitial extends TextFieldState {}

class TextFieldsUpdated extends TextFieldState {
  final Map<String, String> fieldValues;
  final bool allFieldsFilled;

  TextFieldsUpdated({required this.fieldValues, required this.allFieldsFilled});
}
