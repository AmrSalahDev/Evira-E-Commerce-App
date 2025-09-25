import 'package:evira_e_commerce/shared/cubits/text_field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TextFieldCubit extends Cubit<TextFieldState> {
  final Map<String, String> _fieldValues = {};
  List<String> _requiredFields = [];

  TextFieldCubit() : super(TextFieldsInitial());

  void setRequiredFields(List<String> requiredFields) {
    _requiredFields = requiredFields;
    _fieldValues.clear();

    // Initialize all fields as empty
    for (String field in _requiredFields) {
      _fieldValues[field] = '';
    }
    _updateState();
  }

  void updateField(String fieldName, String value) {
    _fieldValues[fieldName] = value.trim();
    _updateState();
  }

  void clearField(String fieldName) {
    _fieldValues[fieldName] = '';
    _updateState();
  }

  void clearAllFields() {
    for (String field in _requiredFields) {
      _fieldValues[field] = '';
    }
    _updateState();
  }

  bool isFieldEmpty(String fieldName) {
    return _fieldValues[fieldName]?.isEmpty ?? true;
  }

  bool get areAllFieldsFilled {
    return _requiredFields.every(
      (field) => _fieldValues[field]?.isNotEmpty == true,
    );
  }

  String getFieldValue(String fieldName) {
    return _fieldValues[fieldName] ?? '';
  }

  void _updateState() {
    emit(
      TextFieldsUpdated(
        fieldValues: Map.from(_fieldValues),
        allFieldsFilled: areAllFieldsFilled,
      ),
    );
  }
}
