// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ddd_tutorial/domain/auth/auth_failure.dart';
import 'package:ddd_tutorial/domain/auth/i_auth_facade.dart';
import 'package:ddd_tutorial/domain/auth/value_objects.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _iAuthFacade;

  SignInFormBloc(
    this._iAuthFacade,
  ) : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) {
      event.map(
        emailChanged: (value) async*{
          emit(state.copyWith(
            emailAddress: EmailAddress(value.emailString),
            authFailureOrSuccessOption: none()
          ));
        }, 
        passwordChanged:  (value) async*{
          emit(state.copyWith(
            password: Password(value.passwordString),
            authFailureOrSuccessOption: none()
          ));
        },
        registerWithEmailAndPasswordPressed: (value) async*{
        
          yield* _performActionOnAuthFacadeWithEmailAndPassword(_iAuthFacade.registerWithEmailAndPassword);
          
        }, 
        signInWithEmailAndPasswordPressed: (value) async*{

          yield* _performActionOnAuthFacadeWithEmailAndPassword(_iAuthFacade.signInWithEmailAndPassword);

        }, 
        signInWithGooglePressed: (value) async*{
          emit(state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none()
          ));
          final failureOrSuccess = await _iAuthFacade.signInWithGoogle();

          emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(failureOrSuccess)
          ));
        }
      );
    });
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function({required EmailAddress emailAddress, required Password password}) forwardedCall
  ) async*{
    Either<AuthFailure, Unit>? failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none()
      );

      failureOrSuccess = await forwardedCall(emailAddress: state.emailAddress, password: state.password);


    }

    yield state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
          authFailureOrSuccessOption: optionOf(failureOrSuccess)
        );
  }
}
