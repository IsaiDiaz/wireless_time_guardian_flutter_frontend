import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/dto/employee_dto.dart';

class EmployeInitState {
  final List<EmployeeDto> employes;

  EmployeInitState(this.employes);
}

class EmployeInitCubit extends Cubit<EmployeInitState> {
  EmployeInitCubit() : super(EmployeInitState([
   EmployeeDto(id: 1, fullName: "Juan Perez Perez", ci: "12334456", update: true, isPresentRfid: false, isPresentWifi: false),
    EmployeeDto(id: 2, fullName: "Maria Perez Perez", ci: "12334456", update: true, isPresentRfid: false, isPresentWifi: false),
  ]));

  void addEmploye(EmployeeDto employe) {
    final List<EmployeeDto> employes = state.employes;
    employes.add(employe);
    emit(EmployeInitState(employes));
  }

  void removeEmploye(int index) {
    final List<EmployeeDto> employes = state.employes;
    employes.removeAt(index);
    emit(EmployeInitState(employes));
  }
}