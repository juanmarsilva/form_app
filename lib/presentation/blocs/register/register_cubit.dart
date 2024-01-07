import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:form_app/infrastructure/inputs/inputs.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {

    RegisterCubit() : super( const RegisterFormState() );

    void onSubmit() {
        emit(
            state.copyWith(
                formStatus: FormStatus.validating,
                username: Username.dirty( state.username.value ),
                password: Password.dirty( state.password.value ),
                isValid: Formz.validate([ state.username, state.password ])
            )
        );

        print('submit: $state');
    }

    void usernameChanged( String value ) {
        final username = Username.dirty( value );

        emit(
            state.copyWith(
                username: username,
                isValid: Formz.validate([ username, state.password ])
            )
        );
    }

    void emailChanged(String value) {
        emit(
            state.copyWith(
                email: value,
            )
        );
    }

    void passwordChanged( String value ) {
        final password = Password.dirty( value );

        emit(
            state.copyWith(
                password: password,
                isValid: Formz.validate([ state.username, password ])
            )
        );
    }
    
}
