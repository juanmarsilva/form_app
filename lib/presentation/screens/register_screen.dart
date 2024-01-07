import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/presentation/blocs/register/register_cubit.dart';
import 'package:form_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
    const RegisterScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Nuevo usuario'),
            ),
            body: BlocProvider(
                create: (context) => RegisterCubit(),
                child: const _RegisterView()
            ),
        );
    }
}

class _RegisterView extends StatelessWidget {
    const _RegisterView();

    @override
    Widget build(BuildContext context) {
        return const SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                            FlutterLogo( size: 100 ),

                            SizedBox( height: 20 ),

                            _RegisterForm(),

                            SizedBox( height: 20 )
                        ],
                    ),
                ),
            ),
        );
    }
}

class _RegisterForm extends StatefulWidget {
    const _RegisterForm();

    @override
    State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String username = '';
    String email = '';
    String password = '';

    String? Function(String?)? validateUsername = (value) {
        if( value == null  || value.isEmpty ) return 'Campo requerido';

        if( value.trim().isEmpty ) return 'Campo requerido';

        if( value.length < 6 ) return 'Más de 6 letras';

        return null;
    };

    String? Function(String?)? validateEmail = (value) {
        if( value == null  || value.isEmpty ) return 'Campo requerido';

        if( value.trim().isEmpty ) return 'Campo requerido';

        final emailRegExp = RegExp(
            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        );

        if( !emailRegExp.hasMatch(value) ) return 'Correo electrónico no valido';

        return null;
    };

    String? Function(String?)? validatePassword = (value) {
        if( value == null  || value.isEmpty ) return 'Campo requerido';

        if( value.trim().isEmpty ) return 'Campo requerido';

        if( value.length < 6 ) return 'Más de 6 letras';

        return null;
    };

    @override
    Widget build(BuildContext context) {

        final registerCubit = context.watch<RegisterCubit>();

        return Form(
            key: _formKey,
            child: Column(
                children: [

                    CustomTextFormField(
                        label: 'Nombre de usuario',
                        icon: Icons.person,
                        onChanged: registerCubit.usernameChanged,
                        validator: validateUsername
                    ),

                    const SizedBox( height:  20 ),

                    CustomTextFormField(
                        label: 'Correo electrónico',
                        icon: Icons.mail,
                        onChanged: registerCubit.emailChanged,
                        validator: validateEmail,
                    ),

                    const SizedBox( height:  20 ),

                    CustomTextFormField(
                        label: 'Contraseña',
                        icon: Icons.lock,
                        obscureText: true,
                        onChanged: registerCubit.passwordChanged,
                        validator: validatePassword,
                    ),

                    const SizedBox( height:  20 ),

                    FilledButton.tonalIcon(
                        onPressed: registerCubit.onSubmit, 
                        icon: const Icon( Icons.save ),
                        label: const Text('Crear usuario'),
                    )

                ],
            ),
        );
    }
}