import 'package:authentication/src/models/login_model.dart';
import 'package:authentication/src/services/dependency_service.dart';
import 'package:authentication/src/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  Color _colorEmail = Colors.red;
  AuthBloc() : super(AuthEmptyState());

  AuthBlocState get initialState => AuthEmptyState();

  @override
  Stream<AuthBlocState> mapEventToState(AuthBlocEvent event) async* {
    if (event is RightEmailEvent) {
      _colorEmail = Colors.black;
      yield InititialState();
    } else if (event is InitializeEvent) {
      yield InititialState();
    } else if (event is SignInEvent) {
      final user = await authenticationRepository
          .signInWithEmailAndPassword(event.loginModel);
      if (user != null) {
        navigationService.navigateTo(Pages.home, arguments: user.uid);
      } else {
        yield ErrorState();
      }
    } else if (event is SignUpEvent) {
      final user = await authenticationRepository
          .singUpwithEmailAndPassword(event.loginModel);
      if (user != null) {
        navigationService.navigateTo(Pages.home, arguments: user.uid);
      } else {
        yield ErrorState();
      }
    }
  }

  Color get getColorEmail => _colorEmail;
}

class AuthBlocEmptyState {}

abstract class AuthBlocEvent {}

class InitializeEvent extends AuthBlocEvent {}

class SignInEvent extends AuthBlocEvent {
  final LoginModel loginModel;

  SignInEvent({this.loginModel});
}

class RightEmailEvent extends AuthBlocEvent {}

class SignUpEvent extends AuthBlocEvent {
  final LoginModel loginModel;

  SignUpEvent({this.loginModel});
}

abstract class AuthBlocState {}

class SignedInState extends AuthBlocState {}

class SignedUpState extends AuthBlocState {}

class InititialState extends AuthBlocState {}

class ErrorState extends AuthBlocState {}

class AuthEmptyState extends AuthBlocState {}
