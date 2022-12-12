import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kraut_rueben/backend/database.dart';

class LoginPopup extends StatelessWidget {
  final ValueChanged<String>? onConfirm;
  LoginPopup({Key? key, this.onConfirm}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    double width = 300;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned.fill(
              child: UnconstrainedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      color: Colors.white.withOpacity(0.4),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                                width: width,
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Login",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.none,
                                      maxLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: usernameController,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) =>
                                          _formKey.currentState!.validate(),
                                      decoration: InputDecoration(
                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 7),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      maxLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: passwordController,
                                      textAlign: TextAlign.left,
                                      onChanged: (value) =>
                                          _formKey.currentState!.validate(),
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.3),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 7),
                                      ),
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              color: Colors.black.withOpacity(0.2),
                              height: 1,
                              width: width,
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: width / 2,
                                    child: MaterialButton(
                                      onPressed: () => Navigator.pop(context),
                                      splashColor: Colors.transparent,
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  SizedBox(
                                    width: width / 2,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        var status = await DatabaseManager
                                            .connectToDatabase(
                                                usernameController.text,
                                                passwordController.text);
                                        print(status);
                                        if (status == ConnectionStatus.success) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      splashColor: Colors.transparent,
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
