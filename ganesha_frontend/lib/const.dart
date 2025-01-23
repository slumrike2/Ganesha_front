enum actionType {
  take_daily_test,
  login,
  do_daily_exercises,
}

extension actionTypeExtension on actionType {
  String get name {
    switch (this) {
      case actionType.take_daily_test:
        return 'Tomar Test Diario';
      case actionType.login:
        return 'Iniciar Sesión';
      case actionType.do_daily_exercises:
        return 'Hacer Ejercicios Diarios';
    }
  }
}
