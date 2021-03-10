import 'package:authentication/src/models/login_model.dart';
import 'package:authentication/src/services/dependency_service.dart';
import 'package:authentication/src/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBloc() : super(HomeEmptyState());

  HomeBlocState get initialState => HomeEmptyState();

  @override
  Stream<HomeBlocState> mapEventToState(HomeBlocEvent event) async* {
    if (event is InitializeEvent) {
      yield InititializeState();
    } else if (event is LogOutOnTapEvent) {
      authenticationRepository.logOut();
      navigationService.navigateTo(Pages.login);
    }
  }
}

abstract class HomeBlocEvent {}

class InitializeEvent extends HomeBlocEvent {
  final String text;

  InitializeEvent({this.text});
}

class LogOutOnTapEvent extends HomeBlocEvent {}

abstract class HomeBlocState {}

class InititializeState extends HomeBlocState {}

class HomeEmptyState extends HomeBlocState {}
