import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PageEvent {}

class ChangePageEvent extends PageEvent {
  final int page;

  ChangePageEvent(this.page);
}

class PageState{
  final int actualPage;
  PageState(this.actualPage);
}

class PageBloc extends Bloc<PageEvent, PageState>{
  PageBloc() : super(PageState(0));

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    if(event is ChangePageEvent){
      yield PageState(event.page);
    }
  }
}