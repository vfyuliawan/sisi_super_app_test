// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sisi_super_app/moduls/login/cubit/login_cubit.dart';
import 'package:sisi_super_app/utility/Utility.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              final String? id = state.dataLogin.id;
              print("idUser: $id");
              context.go("/home/$id");
            } else if (state is LoginFailed) {
              Utility().themeAlert(
                  context: context,
                  title: "Wrong!!",
                  subtitle: state.message,
                  titleButton: "Tutup",
                  isError: true,
                  callback: () {
                    context.pop();
                  });
            }
          },
          builder: (context, state) {
            if (state is LoginIsLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }
            return Column(children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image.asset("assets/images/logosisi.png"),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Masukan Email",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey.shade600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Circular border radius
                          borderSide:
                              BorderSide.none, // Remove the default border
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: isPasswordVisible,
                      builder: (context, passwordVisible, child) {
                        return TextField(
                          controller: passwordController,
                          obscureText:
                              !passwordVisible, // Show/hide password based on visibility
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                            prefixIcon: Icon(Icons.lock),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                isPasswordVisible.value = !passwordVisible;
                              },
                              child: Icon(
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(children: [
                            Checkbox(
                              value:
                                  context.read<LoginCubit>().checkSimpanSandi,
                              onChanged: (value) {
                                context.read<LoginCubit>().toogleSimpanSandi();
                              },
                            ),
                            Text(
                              "Simpan Kata Sandi",
                            ),
                          ]),
                        ),
                        Text(
                          "Lupa Kata Sandi?",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        await context.read<LoginCubit>().submit(
                            email: emailController.text,
                            password: passwordController.text);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        // ignore: sort_child_properties_last
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ]);
          },
        ),
      ),
    );
  }
}
