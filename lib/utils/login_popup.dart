import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kraut_rueben/backend/database.dart';

class LoginPopup extends StatefulWidget {
  final ValueChanged<ConnectionStatus>? onConfirm;
  LoginPopup({Key? key, this.onConfirm}) : super(key: key);

  @override
  State<LoginPopup> createState() => _LoginPopupState();
}

class _LoginPopupState extends State<LoginPopup> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController databaseNameController =
      TextEditingController(text: "krautundrueben");
  TextEditingController ipController =
      TextEditingController(text: "130.162.243.109");
  TextEditingController portController = TextEditingController(text: "3306");
  bool doConnectToOwnServer = false;
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    double width = 300;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
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
                                      doConnectToOwnServer
                                          ? "Connect to Server"
                                          : "Login",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 20,
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
                                    if (doConnectToOwnServer)
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    if (doConnectToOwnServer)
                                      TextFormField(
                                        maxLines: 1,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: databaseNameController,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                          hintText: "Database Name",
                                          hintStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                                    if (doConnectToOwnServer)
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    if (doConnectToOwnServer)
                                      TextFormField(
                                        maxLines: 1,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9.]'))
                                        ],
                                        controller: ipController,
                                        textAlign: TextAlign.left,
                                        decoration: InputDecoration(
                                          hintText: "IPv4-Address",
                                          hintStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                                    if (doConnectToOwnServer)
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    if (doConnectToOwnServer)
                                      TextFormField(
                                        maxLines: 1,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: portController,
                                        textAlign: TextAlign.left,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]'))
                                        ],
                                        decoration: InputDecoration(
                                          hintText: "Port",
                                          hintStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: doConnectToOwnServer,
                                          onChanged: (value) => {
                                            setState(() {
                                              doConnectToOwnServer = value!;
                                            })
                                          },
                                        ),
                                        const Text("Connect to own server")
                                      ],
                                    ),
                                    if (errorText != "")
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    if (errorText != "")
                                      Text(
                                        errorText,
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600),
                                      )
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
                                    width: width,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        var status;
                                        if (doConnectToOwnServer) {
                                          status = await DatabaseManager
                                              .connectToDatabase(
                                                  usernameController.text,
                                                  passwordController.text,
                                                  ipController.text,
                                                  int.parse(
                                                      portController.text),
                                                  databaseNameController.text);
                                        } else {
                                          status = await DatabaseManager
                                              .connectToDatabase(
                                                  usernameController.text,
                                                  passwordController.text);
                                        }

                                        if (status ==
                                            ConnectionStatus.success) {
                                          widget.onConfirm?.call(status);
                                          Navigator.pop(context);
                                        } else if (status ==
                                            ConnectionStatus.error) {
                                          setState(() {
                                            errorText = "Database Error";
                                          });
                                          Future.delayed(Duration(seconds: 5),
                                              (() {
                                            setState(() {
                                              errorText = "";
                                            });
                                          }));
                                        } else if (status ==
                                            ConnectionStatus.loginFailure) {
                                          setState(() {
                                            errorText = "Wrong Credentials";
                                          });
                                          Future.delayed(Duration(seconds: 5),
                                              (() {
                                            setState(() {
                                              errorText = "";
                                            });
                                          }));
                                        }
                                      },
                                      splashColor: Colors.transparent,
                                      child: Text(
                                        doConnectToOwnServer
                                            ? "Connect to Server"
                                            : "Login",
                                        style: const TextStyle(
                                          color: Colors.black,
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
