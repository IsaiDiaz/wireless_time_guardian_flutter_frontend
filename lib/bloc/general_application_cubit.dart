import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationState {
  final String serverIp;
  final String serverPort;

  ApplicationState(this.serverIp, this.serverPort);
}

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(
    ApplicationState('localhost', '8080')
  );

  void changeServerIp(String serverIp) {
    emit(ApplicationState(serverIp, state.serverPort));
  }

  void changeServerPort(String serverPort) {
    emit(ApplicationState(state.serverIp, serverPort));
  }

  void changeServer(String serverIp, String serverPort) {
    emit(ApplicationState(serverIp, serverPort));
  }
}