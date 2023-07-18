import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_post/register_provider.dart';
import 'package:provider_post/register_response.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildTextField(emailController, "Email", emailNode,
                    passwordNode, const Icon(Icons.person), false),
                const SizedBox(height: 20),
                _buildTextField(passwordController, "Password", passwordNode,
                    null, const Icon(Icons.lock), true),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final registerResponse =
                              registerProvider.registerUser(
                                  emailController.text,
                                  passwordController.text);
                          registerResponse.then((response) {
                            if (registerProvider.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Token: ${registerProvider.registerResponse.token!}  Id: ${registerProvider.registerResponse.id.toString()}'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Registration Failed"),
                                ),
                              );
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.blue),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 16),
                      )),
                )
              ],
            ),
          )),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      FocusNode focusNode,
      FocusNode? focusNodeNext,
      Icon? iconData,
      bool isPassword) {
    return TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "$label is required";
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        obscureText: isPassword,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.12),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.withOpacity(0.5),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green.withOpacity(0.5),
            ),
          ),
          hintText: label,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: iconData,
        ),
        onFieldSubmitted: (String val) {
          fieldFocusChange(context, focusNode, focusNodeNext);
        });
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode? nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
