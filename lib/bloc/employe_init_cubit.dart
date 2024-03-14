import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';

class EmployeInitState {
  final List<EmployeeDto> currentProjectEmployees;
  final List<EmployeeDto> allEmployees;

  EmployeInitState(this.currentProjectEmployees, this.allEmployees);
}

class EmployeInitCubit extends Cubit<EmployeInitState> {
  EmployeInitCubit() : super(EmployeInitState([], []));

  void addEmploye(EmployeeDto employe) {
    if (existEmployeeById(employe.id!)) {
      updateEmploye(employe);
    } else {
      final List<EmployeeDto> currentProjectEmployees =
          state.currentProjectEmployees;
      currentProjectEmployees.add(employe);
      emit(EmployeInitState(currentProjectEmployees, state.allEmployees));
    }
  }

  void removeEmploye(int index) {
    final List<EmployeeDto> currentProjectEmployees =
        state.currentProjectEmployees;
    currentProjectEmployees.removeAt(index);
    emit(EmployeInitState(currentProjectEmployees, state.allEmployees));
  }

  EmployeeDto findEmployeeById(int id) {
    final List<EmployeeDto> currentProjectEmployees =
        state.currentProjectEmployees;
    final EmployeeDto employe =
        currentProjectEmployees.firstWhere((element) => element.id == id);
    return employe;
  }

  bool existEmployeeById(int id) {
    final List<EmployeeDto> currentProjectEmployees =
        state.currentProjectEmployees;
    final bool exist =
        currentProjectEmployees.any((element) => element.id == id);
    return exist;
  }

  void updateEmploye(EmployeeDto employe) {
    final List<EmployeeDto> currentProjectEmployees =
        state.currentProjectEmployees;
    final int index = currentProjectEmployees
        .indexWhere((element) => element.id == employe.id);
    currentProjectEmployees[index] = employe;
    emit(EmployeInitState(currentProjectEmployees, state.allEmployees));
  }

  void updateAllEmployeesEmployee(EmployeeDto employe) {
    final List<EmployeeDto> allEmployees = state.allEmployees;
    final int index =
        allEmployees.indexWhere((element) => element.id == employe.id);
    allEmployees[index] = employe;
    emit(EmployeInitState(state.currentProjectEmployees, allEmployees));
  }

  void initList(Future<List<EmployeeDto>?> currentProjectEmployees) {
    currentProjectEmployees
        .then((value) {
          if (value != null) {
            emit(EmployeInitState(value, state.allEmployees));
          }else{
            emit(EmployeInitState([], state.allEmployees));
          }
        });
  }

  void initAllEmployeesList(Future<List<EmployeeDto>?> allEmployees) {
    allEmployees.then((value) 
        {
          if (value != null) {
            emit(EmployeInitState(state.currentProjectEmployees, value));
          }else{
            emit(EmployeInitState(state.currentProjectEmployees, []));
          }
        });
  }

  void addAllEmploye(EmployeeDto employe) {
    if (existAllEmployeeById(employe.id!)) {
      updateAllEmployeesEmployee(employe);
    } else {
      final List<EmployeeDto> allEmployees = state.allEmployees;
      allEmployees.add(employe);
      emit(EmployeInitState(state.currentProjectEmployees, allEmployees));
    }
  }

  bool existAllEmployeeById(int id) {
    final List<EmployeeDto> allEmployees = state.allEmployees;
    final bool exist = allEmployees.any((element) => element.id == id);
    return exist;
  }

  void deleteNooneEmployee(){
    state.allEmployees.removeWhere((element) => element.fullName == "NADIE");
    emit(EmployeInitState(state.currentProjectEmployees, state.allEmployees));
  }

  void deleteEmployee(EmployeeDto employee){
    state.currentProjectEmployees.remove(employee);
    emit(EmployeInitState(state.currentProjectEmployees, state.allEmployees));
  }

  void deleteAllEmployeesEmployee(EmployeeDto employee){
    state.allEmployees.remove(employee);
    emit(EmployeInitState(state.currentProjectEmployees, state.allEmployees));
  }
}
