import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeInitState {
  List<Map<String, dynamic>> employes = [
    {
      'nombre': 'Juan',
      'apellido': 'Perez',
      'dni': '12345678',
      'email': '',
      'telefono': '',
      'proyecto': '',
    },
    {
      'nombre': 'Pedro',
      'apellido': 'Gomez',
      'dni': '87654321',
      'email': '',
      'telefono': '',
      'proyecto': '',
    },
  ];

  EmployeInitState(this.employes);
}

class EmployeInitCubit extends Cubit<EmployeInitState> {
  EmployeInitCubit() : super(EmployeInitState([]));

  void addEmploye(Map<String, dynamic> employe) {
    final List<Map<String, dynamic>> employes = state.employes;
    employes.add(employe);
    emit(EmployeInitState(employes));
  }

  void removeEmploye(int index) {
    final List<Map<String, dynamic>> employes = state.employes;
    employes.removeAt(index);
    emit(EmployeInitState(employes));
  }
}