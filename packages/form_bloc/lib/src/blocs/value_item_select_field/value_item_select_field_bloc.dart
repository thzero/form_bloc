part of '../field/field_bloc.dart';

/// A `FieldBloc` used to select one item
/// from multiple items.
class ValueItemSelectFieldBloc<Value, Item, ExtraData> extends SingleFieldBloc<Value?, Value, ValueItemSelectFieldBlocState<Value, Item, ExtraData>, ExtraData?> {
  /// ## SelectFieldBloc<Value, ExtraData>
  ///
  /// ### Properties:
  ///
  /// * [name] : It is the string that identifies the fieldBloc,
  /// it is available in [FieldBlocState.name].
  /// * [initialValue] : The initial value of the field,
  /// by default is `null`.
  /// * [validators] : List of [Validator]s.
  /// Each time the `value` will change,
  /// if the [FormBloc] that use this [SelectFieldBloc] has set
  /// in the `super` constructor `autoValidate = true`,
  /// the `value` is passed to each `validator`,
  /// and if any `validator` returns a `String error`,
  /// it will be added to [SelectFieldBlocState.error].
  /// Else if `autoValidate = false`, the value will be checked only
  /// when you call [validate] which is called automatically when call [FormBloc.submit].
  /// * [asyncValidators] : List of [AsyncValidator]s.
  /// it is the same as [validators] but asynchronous.
  /// Very useful for server validation.
  /// * [asyncValidatorDebounceTime] : The debounce time when any `asyncValidator`
  /// must be called, by default is 500 milliseconds.
  /// Very useful for reduce the number of invocations of each `asyncValidator.
  /// For example, used for prevent limit in API calls.
  /// * [suggestions] : This need be a [Suggestions] and will be
  /// added to [SelectFieldBlocState.suggestions].
  /// It is used to suggest values, usually from an API,
  /// and any of those suggestions can be used to update
  /// the value using [updateValue].
  /// * [items] : The list of items that can be selected to update the value.
  /// * [toJson] : Transform [value] in a JSON value.
  /// By default returns [value].
  /// This method is called when you use [FormBlocState.toJson]
  /// * [extraData] : It is an object that you can use to add extra data, it will be available in the state [FieldBlocState.extraData].
  ValueItemSelectFieldBloc({
    String? name,
    Value? initialValue,
    List<ValidatorWrapper<Value?>>? validators,
    List<AsyncValidatorWrapper<Value?>>? asyncValidators,
    Duration asyncValidatorDebounceTime = const Duration(milliseconds: 500),
    Suggestions<Value>? suggestions,
    Map<Value, Item> items = const {},
    dynamic Function(Value? value)? toJson,
    ExtraData? extraData,
    TranslateCallback? translate,
  }) : super(
          translate: translate,
          validators: validators,
          asyncValidators: asyncValidators,
          asyncValidatorDebounceTime: asyncValidatorDebounceTime,
          initialState: ValueItemSelectFieldBlocState(
            isValueChanged: false,
            initialValue: initialValue,
            updatedValue: initialValue,
            value: initialValue,
            error: FieldBlocUtils.getInitialStateError(
              validators: validators,
              value: initialValue,
            ),
            isDirty: false,
            suggestions: suggestions,
            isValidated: FieldBlocUtils.getInitialIsValidated(
              FieldBlocUtils.getInitialStateIsValidating(
                asyncValidators: asyncValidators,
                validators: validators,
                value: initialValue,
              ),
            ),
            isValidating: FieldBlocUtils.getInitialStateIsValidating(
              asyncValidators: asyncValidators,
              validators: validators,
              value: initialValue,
            ),
            name: FieldBlocUtils.generateName(name),
            items: items,
            toJson: toJson,
            extraData: extraData,
          ),
        );

  /// Add [value] to the current `items`
  /// of the current state.
  void addItem(Value value, Item item) {
    var items = state.items;
    items[value] = item;
    emit(state.copyWith(
      items: items,
    ));
  }

  /// Remove [item] to the current `items`
  /// of the current state.
  void removeItem(Value valueR) {
    var items = state.items;
    if (items.isNotEmpty) {
      if (items.containsKey(valueR)) {
        items.remove(valueR);
      }
      emit(state.copyWith(
        items: items,
        value: items.containsKey(value) ? null : Param(null),
      ));
    }
  }

  /// Set [items] to the `items` of the current state.
  ///
  /// If you want to add or remove elements to `items`
  /// of the current state,
  /// use [addItem] or [removeItem].
  void updateItems(Map<Value, Item> items) {
    emit(state.copyWith(
      items: items,
      value: items.containsKey(value) ? null : Param(null),
    ));
  }
}
