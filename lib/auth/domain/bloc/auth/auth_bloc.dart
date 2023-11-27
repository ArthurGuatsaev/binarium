import 'dart:async';

import 'package:binarium/auth/domain/model/user.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:binarium/auth/domain/repository/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final StreamController<MyUser> controller;
  final BaseAuth authRepo;
  AuthBloc({required this.controller, required this.authRepo})
      : super(AuthState(user: MyUser())) {
    controller.stream.listen(
      (event) {
        if (event.name.isNotEmpty) {
          add(AddUserEvent(user: event));
        } else {
          MyNavigatorManager.instance.signInPush();
        }
      },
    );
    on<AddUserEvent>(onAddUser);
    on<SignUpEvent>(onSignUp);
    on<GetUserEvent>(onGetUser);
    on<ChangeUserImageEvent>(onChangeUserImage);
    on<ChangeUserDataEvent>(onChangeUserData);
    on<LogOutEvent>(onLogOut);
    on<SignInEvent>(onSignIn);
    on<DeleteUserAccountEvent>(onDeleteUserAccount);
  }

  onAddUser(AddUserEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(user: event.user, status: MyAuthStatus.success));
    MyNavigatorManager.instance.homePush();
  }

  onSignUp(SignUpEvent event, Emitter<AuthState> emit) {
    authRepo.signUp(
        name: event.name, password: event.password, userController: controller);
  }

  onSignIn(SignInEvent event, Emitter<AuthState> emit) {
    authRepo.signIn(
        name: event.name, password: event.password, userController: controller);
  }

  //получение юзера при повторном входе
  onGetUser(GetUserEvent event, Emitter<AuthState> emit) {
    if (authRepo is UserRepo) {
      if ((authRepo as UserRepo).myUser != null) {
        emit(state.copyWith(user: (authRepo as UserRepo).myUser));
      }
    }
  }

  onChangeUserImage(ChangeUserImageEvent event, Emitter<AuthState> emit) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      image != null
          ? await (authRepo as UserRepo)
              .setImage(image: image, name: state.user.name)
          : null;
      add(GetUserEvent());
    } catch (e) {
      emit(state);
    }
  }

  onChangeUserData(ChangeUserDataEvent event, Emitter<AuthState> emit) async {
    (authRepo as UserRepo).changeUserData(userV: event.user);
    emit(state.copyWith(user: event.user));
  }

  onDeleteUserAccount(
      DeleteUserAccountEvent event, Emitter<AuthState> emit) async {
    (authRepo as UserRepo).deleteAccount(userController: controller);
  }

  onLogOut(LogOutEvent event, Emitter<AuthState> emit) async {
    (authRepo as UserRepo).logOut(controller);
  }
}
