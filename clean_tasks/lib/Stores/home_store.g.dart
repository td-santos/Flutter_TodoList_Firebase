// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  final _$darkModeAtom = Atom(name: '_HomeStoreBase.darkMode');

  @override
  bool get darkMode {
    _$darkModeAtom.context.enforceReadPolicy(_$darkModeAtom);
    _$darkModeAtom.reportObserved();
    return super.darkMode;
  }

  @override
  set darkMode(bool value) {
    _$darkModeAtom.context.conditionallyRunInAction(() {
      super.darkMode = value;
      _$darkModeAtom.reportChanged();
    }, _$darkModeAtom, name: '${_$darkModeAtom.name}_set');
  }

  final _$orderAscAtom = Atom(name: '_HomeStoreBase.orderAsc');

  @override
  bool get orderAsc {
    _$orderAscAtom.context.enforceReadPolicy(_$orderAscAtom);
    _$orderAscAtom.reportObserved();
    return super.orderAsc;
  }

  @override
  set orderAsc(bool value) {
    _$orderAscAtom.context.conditionallyRunInAction(() {
      super.orderAsc = value;
      _$orderAscAtom.reportChanged();
    }, _$orderAscAtom, name: '${_$orderAscAtom.name}_set');
  }

  final _$alturaCalendarAtom = Atom(name: '_HomeStoreBase.alturaCalendar');

  @override
  double get alturaCalendar {
    _$alturaCalendarAtom.context.enforceReadPolicy(_$alturaCalendarAtom);
    _$alturaCalendarAtom.reportObserved();
    return super.alturaCalendar;
  }

  @override
  set alturaCalendar(double value) {
    _$alturaCalendarAtom.context.conditionallyRunInAction(() {
      super.alturaCalendar = value;
      _$alturaCalendarAtom.reportChanged();
    }, _$alturaCalendarAtom, name: '${_$alturaCalendarAtom.name}_set');
  }

  final _$visibleCalendarAtom = Atom(name: '_HomeStoreBase.visibleCalendar');

  @override
  bool get visibleCalendar {
    _$visibleCalendarAtom.context.enforceReadPolicy(_$visibleCalendarAtom);
    _$visibleCalendarAtom.reportObserved();
    return super.visibleCalendar;
  }

  @override
  set visibleCalendar(bool value) {
    _$visibleCalendarAtom.context.conditionallyRunInAction(() {
      super.visibleCalendar = value;
      _$visibleCalendarAtom.reportChanged();
    }, _$visibleCalendarAtom, name: '${_$visibleCalendarAtom.name}_set');
  }

  final _$alturaDataAtom = Atom(name: '_HomeStoreBase.alturaData');

  @override
  double get alturaData {
    _$alturaDataAtom.context.enforceReadPolicy(_$alturaDataAtom);
    _$alturaDataAtom.reportObserved();
    return super.alturaData;
  }

  @override
  set alturaData(double value) {
    _$alturaDataAtom.context.conditionallyRunInAction(() {
      super.alturaData = value;
      _$alturaDataAtom.reportChanged();
    }, _$alturaDataAtom, name: '${_$alturaDataAtom.name}_set');
  }

  final _$alturaHOJEAtom = Atom(name: '_HomeStoreBase.alturaHOJE');

  @override
  double get alturaHOJE {
    _$alturaHOJEAtom.context.enforceReadPolicy(_$alturaHOJEAtom);
    _$alturaHOJEAtom.reportObserved();
    return super.alturaHOJE;
  }

  @override
  set alturaHOJE(double value) {
    _$alturaHOJEAtom.context.conditionallyRunInAction(() {
      super.alturaHOJE = value;
      _$alturaHOJEAtom.reportChanged();
    }, _$alturaHOJEAtom, name: '${_$alturaHOJEAtom.name}_set');
  }

  final _$dataFormatadaAtom = Atom(name: '_HomeStoreBase.dataFormatada');

  @override
  String get dataFormatada {
    _$dataFormatadaAtom.context.enforceReadPolicy(_$dataFormatadaAtom);
    _$dataFormatadaAtom.reportObserved();
    return super.dataFormatada;
  }

  @override
  set dataFormatada(String value) {
    _$dataFormatadaAtom.context.conditionallyRunInAction(() {
      super.dataFormatada = value;
      _$dataFormatadaAtom.reportChanged();
    }, _$dataFormatadaAtom, name: '${_$dataFormatadaAtom.name}_set');
  }

  final _$alturaListViewAtom = Atom(name: '_HomeStoreBase.alturaListView');

  @override
  double get alturaListView {
    _$alturaListViewAtom.context.enforceReadPolicy(_$alturaListViewAtom);
    _$alturaListViewAtom.reportObserved();
    return super.alturaListView;
  }

  @override
  set alturaListView(double value) {
    _$alturaListViewAtom.context.conditionallyRunInAction(() {
      super.alturaListView = value;
      _$alturaListViewAtom.reportChanged();
    }, _$alturaListViewAtom, name: '${_$alturaListViewAtom.name}_set');
  }

  final _$setAlturaListViewAsyncAction = AsyncAction('setAlturaListView');

  @override
  Future<void> setAlturaListView(double valor) {
    return _$setAlturaListViewAsyncAction
        .run(() => super.setAlturaListView(valor));
  }

  final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase');

  @override
  void setDarkMode(bool value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction();
    try {
      return super.setDarkMode(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOrderCres(bool value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction();
    try {
      return super.setOrderCres(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAlturaCalendar(double value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction();
    try {
      return super.setAlturaCalendar(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool setVisibleCalendar() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction();
    try {
      return super.setVisibleCalendar();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAturaData(double valor) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction();
    try {
      return super.setAturaData(valor);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAturaHOJE(double valor) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction();
    try {
      return super.setAturaHOJE(valor);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDataFormatada(String valor) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction();
    try {
      return super.setDataFormatada(valor);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetAlturaListView(double valor) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction();
    try {
      return super.resetAlturaListView(valor);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'darkMode: ${darkMode.toString()},orderAsc: ${orderAsc.toString()},alturaCalendar: ${alturaCalendar.toString()},visibleCalendar: ${visibleCalendar.toString()},alturaData: ${alturaData.toString()},alturaHOJE: ${alturaHOJE.toString()},dataFormatada: ${dataFormatada.toString()},alturaListView: ${alturaListView.toString()}';
    return '{$string}';
  }
}
