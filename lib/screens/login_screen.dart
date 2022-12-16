import 'package:flutter/material.dart';
import 'package:ig_clone/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    emailValidator(val) {
      return AuthProvider.emailValidator(value: val ?? '')
          ? null
          : 'Formato correo invalido';
    }

    passValidator(val) {
      return AuthProvider.passwordValidator(password: val ?? '')
          ? null
          : 'Minimo 8 caracteres, 1 especial y numero';
    }

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: authProvider.form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: width * 0.4, child: Image.asset('assets/logo.png')),
              const SizedBox(
                height: 46,
              ),
              _CustomFormField(
                validator: emailValidator,
                hint: 'Email or username',
                onChange: (val) {
                  authProvider.email = val;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 15,
              ),
              _CustomFormField(
                validator: passValidator,
                isPassword: true,
                hint: 'Password',
                onChange: (val) {
                  authProvider.password = val;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: width * 0.8,
                  child: ElevatedButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (!authProvider.validForm()) return;
                        final res = await authProvider.login(
                            authProvider.email, authProvider.password);
                        if (res == true) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(context, 'splash');
                        } else if (res is String) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showMaterialBanner(
                              MaterialBanner(
                                  backgroundColor: Colors.red,
                                  contentTextStyle:
                                      const TextStyle(color: Colors.white),
                                  content: Text(res),
                                  actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.white),
                                    onPressed: () =>
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentMaterialBanner(),
                                    child: Text('Cerrar'))
                              ]));
                        }
                      },
                      child: const Text('Login')))
            ],
          ),
        ),
      ),
    ));
  }
}

class _CustomFormField extends StatefulWidget {
  const _CustomFormField({
    Key? key,
    required this.keyboardType,
    required this.onChange,
    required this.hint,
    this.showPassword = false,
    this.isPassword = false,
    required this.validator,
  }) : super(key: key);

  final TextInputType keyboardType;
  final Function onChange;
  final String hint;
  final bool showPassword;
  final bool isPassword;
  final Function validator;

  @override
  State<_CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<_CustomFormField> {
  bool hide = false;
  @override
  void initState() {
    super.initState();
    hide = widget.showPassword;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    borderStyle(Color color) {
      return OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: color, width: 1));
    }

    return SizedBox(
        width: width * 0.8,
        child: TextFormField(
            validator: (value) {
              return widget.validator(value);
            },
            autocorrect: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.keyboardType,
            obscureText: hide,
            onChanged: (val) {
              widget.onChange(val);
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                errorMaxLines: 2,
                focusedErrorBorder: borderStyle(Colors.red),
                errorBorder: borderStyle(Colors.red),
                suffixIcon: GestureDetector(
                  onTap: () {
                    hide = !hide;
                    setState(() {});
                  },
                  child: Icon(
                    widget.isPassword && hide
                        ? Icons.visibility_off
                        : widget.isPassword && !hide
                            ? Icons.visibility
                            : null,
                    color: Colors.grey,
                  ),
                ),
                fillColor: const Color.fromRGBO(250, 250, 250, 1),
                filled: true,
                hintText: widget.hint,
                hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                    fontWeight: FontWeight.w700),
                border: borderStyle(Colors.grey.withOpacity(0.5)),
                enabledBorder: borderStyle(Colors.grey.withOpacity(0.5)),
                focusedBorder: borderStyle(Colors.grey.withOpacity(0.5)))));
  }
}
