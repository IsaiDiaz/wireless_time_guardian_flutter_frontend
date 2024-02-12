import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';

class EmployeInitState {
  final List<EmployeeDto> employes;

  EmployeInitState(this.employes);
}

class EmployeInitCubit extends Cubit<EmployeInitState> {
  EmployeInitCubit() : super(EmployeInitState([]));

  void addEmploye(EmployeeDto employe) {
    if (existEmployeeById(employe.id)) {
      updateEmploye(employe);
    } else {
      final List<EmployeeDto> employes = state.employes;
      employes.add(employe);
      emit(EmployeInitState(employes));
    }
  }

  void removeEmploye(int index) {
    final List<EmployeeDto> employes = state.employes;
    employes.removeAt(index);
    emit(EmployeInitState(employes));
  }

  EmployeeDto findEmployeeById(int id) {
    final List<EmployeeDto> employes = state.employes;
    final EmployeeDto employe =
        employes.firstWhere((element) => element.id == id);
    return employe;
  }

  bool existEmployeeById(int id) {
    final List<EmployeeDto> employes = state.employes;
    final bool exist = employes.any((element) => element.id == id);
    return exist;
  }

  void updateEmploye(EmployeeDto employe) {
    final List<EmployeeDto> employes = state.employes;
    final int index =
        employes.indexWhere((element) => element.id == employe.id);
    employes[index] = employe;
    emit(EmployeInitState(employes));
  }
}
