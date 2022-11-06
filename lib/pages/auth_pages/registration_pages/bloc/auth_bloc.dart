import 'package:casino/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(
          const AuthState(),
        ) {
    on<PhoneNumberVerificationIdEvent>((
      PhoneNumberVerificationIdEvent event,
      Emitter<AuthState> emit,
    ) async {
      emit(
        state.copyWith(
          status: AuthStatus.loading,
        ),
      );
      try {
        await AuthRepositories.instance.verifyPhoneSendOtp(event.phone!,
            completed: (credential) {
          if (kDebugMode) {
            print('completed');
          }
          add(
            CompletedAuthEvent(credential: credential),
          );
        }, failed: (error) {
          if (kDebugMode) {
            print(error);
          }
          add(
            ErrorOccurredEvent(
              error: error.toString(),
            ),
          );
        }, codeSent: (
          String id,
          int? token,
        ) {
          add(
            CodeSendEvent(
              token: token,
              verificationId: id,
            ),
          );
        }, codeAutoRetrievalTimeout: (String id) {
          if (AuthRepositories.instance.user == null) {
            add(
              const ErrorCodeSendEvent(),
            );
          }
        });
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
    on<ErrorCodeSendEvent>((
      ErrorCodeSendEvent event,
      Emitter<AuthState> emit,
    ) {
      emit(
        state.copyWith(
          status: AuthStatus.failedCodeSent,
        ),
      );
    });

    on<ErrorOccurredEvent>((
      ErrorOccurredEvent event,
      Emitter<AuthState> emit,
    ) {
      emit(
        state.copyWith(
          status: AuthStatus.failed,
        ),
      );
    });

    on<PhoneAuthCodeVerificationIdEvent>(
        (PhoneAuthCodeVerificationIdEvent event,
            Emitter<AuthState> emit) async {
      try {
        await AuthRepositories.instance.verifyAndLogin(
          event.verificationId!,
          event.smsCode!,
          event.phone!,
        );
      } on Exception {
        add(
          const ErrorCodeSendEvent(),
        );
      }
    });
    on<CodeSendEvent>((
      CodeSendEvent event,
      Emitter<AuthState> emit,
    ) {
      emit(
        state.copyWith(
          status: AuthStatus.codeSent,
          verificationId: event.verificationId,
          token: event.token,
        ),
      );
    });
  }
}
