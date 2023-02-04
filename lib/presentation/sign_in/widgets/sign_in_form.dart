import 'package:ddd_tutorial/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
        builder: (context, state) {
          return Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(4.0),
              children: [
                const Text(
                  "📝",
                  style: TextStyle(fontSize: 130),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    label: Text('Email'),
                  ),
                  autocorrect: false,
                  onChanged: (value) {
                    context.read<SignInFormBloc>().add(
                          SignInFormEvent.emailChanged(value),
                        );
                  },
                  validator: (_) => context
                      .read<SignInFormBloc>()
                      .state
                      .emailAddress
                      .value
                      .fold(
                        (f) => f.maybeMap(
                            invalidEmail: ((value) => value.failedValue),
                            orElse: () => null),
                        (_) => null,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    label: Text('Password'),
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) {
                    context.read<SignInFormBloc>().add(
                          SignInFormEvent.passwordChanged(value),
                        );
                  },
                  validator: (_) =>
                      context.read<SignInFormBloc>().state.password.value.fold(
                            (f) => f.maybeMap(
                              shortPassword: ((value) => value.failedValue),
                              orElse: () => null,
                            ),
                            (_) => null,
                          ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: const Text("Sign in"),
                        onPressed: () {
                          context.read<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .signInWithEmailAndPasswordPressed(),
                              );
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: const Text("Register"),
                        onPressed: () {
                          context.read<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .registerWithEmailAndPasswordPressed(),
                              );
                        },
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                  child: const Text("Sign in with google"),
                  onPressed: () {
                    context.read<SignInFormBloc>().add(
                          const SignInFormEvent.signInWithGooglePressed(),
                        );
                  },
                )
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
