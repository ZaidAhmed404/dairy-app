import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:meo_shop/Widgets/ButtonWidget.dart';
import 'package:meo_shop/main.dart';

import '../../Widgets/TextFieldWidget.dart';
import '../../cubit/LoadingCubit/loading_cubit.dart';

class AddMilkScreen extends StatelessWidget {
  AddMilkScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController milk1Controller = TextEditingController();
  TextEditingController milk2Controller = TextEditingController();
  TextEditingController milk3Controller = TextEditingController();
  TextEditingController milk4Controller = TextEditingController();
  TextEditingController milk5Controller = TextEditingController();

  TextEditingController fat1Controller = TextEditingController();
  TextEditingController fat2Controller = TextEditingController();
  TextEditingController fat3Controller = TextEditingController();
  TextEditingController fat4Controller = TextEditingController();
  TextEditingController fat5Controller = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, LoadingState>(
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state.loading,
          color: Colors.black,
          opacity: 0.5,
          progressIndicator: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const CircularProgressIndicator(
                color: Colors.blue,
              )),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add Milk",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                      textFieldWidth: MediaQuery.of(context).size.width,
                      hintText: "Enter Name",
                      text: "Name",
                      controller: nameController,
                      isPassword: false,
                      isEnabled: true,
                      textInputType: TextInputType.text,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldWidget(
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.42,
                          hintText: "Enter Milk 1 quantity",
                          text: "Milk",
                          controller: milk1Controller,
                          isPassword: false,
                          isEnabled: true,
                          textInputType: TextInputType.number,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Milk is required';
                            }
                            return null;
                          },
                        ),
                        TextFieldWidget(
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.42,
                          hintText: "Enter Milk 1 Fat",
                          text: "Fat",
                          controller: fat1Controller,
                          isPassword: false,
                          isEnabled: true,
                          textInputType: TextInputType.number,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fat is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldWidget(
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.42,
                          hintText: "Enter Milk 2 quantity",
                          text: "Milk",
                          controller: milk2Controller,
                          isPassword: false,
                          isEnabled: true,
                          textInputType: TextInputType.number,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Milk is required';
                            }
                            return null;
                          },
                        ),
                        TextFieldWidget(
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.42,
                          hintText: "Enter Milk 1 Fat",
                          text: "Fat",
                          controller: fat2Controller,
                          isPassword: false,
                          isEnabled: true,
                          textInputType: TextInputType.number,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fat is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldWidget(
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.42,
                          hintText: "Enter Milk 3 quantity",
                          text: "Milk",
                          controller: milk3Controller,
                          isPassword: false,
                          isEnabled: true,
                          textInputType: TextInputType.number,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Milk is required';
                            }
                            return null;
                          },
                        ),
                        TextFieldWidget(
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.42,
                          hintText: "Enter Milk 3 Fat",
                          text: "Fat",
                          controller: fat3Controller,
                          isPassword: false,
                          isEnabled: true,
                          textInputType: TextInputType.number,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fat is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldWidget(
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.42,
                          hintText: "Enter Milk 4 quantity",
                          text: "Milk",
                          controller: milk4Controller,
                          isPassword: false,
                          isEnabled: true,
                          textInputType: TextInputType.number,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Milk is required';
                            }
                            return null;
                          },
                        ),
                        TextFieldWidget(
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.42,
                          hintText: "Enter Milk 4 Fat",
                          text: "Fat",
                          controller: fat4Controller,
                          isPassword: false,
                          isEnabled: true,
                          textInputType: TextInputType.number,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fat is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFieldWidget(
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.42,
                          hintText: "Enter Milk 5 quantity",
                          text: "Milk",
                          controller: milk5Controller,
                          isPassword: false,
                          isEnabled: true,
                          textInputType: TextInputType.number,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Milk is required';
                            }
                            return null;
                          },
                        ),
                        TextFieldWidget(
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.42,
                          hintText: "Enter Milk 5 Fat",
                          text: "Fat",
                          controller: fat5Controller,
                          isPassword: false,
                          isEnabled: true,
                          textInputType: TextInputType.number,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fat is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      textFieldWidth: MediaQuery.of(context).size.width,
                      hintText: "Enter Price of milk",
                      text: "Price",
                      controller: priceController,
                      isPassword: false,
                      isEnabled: true,
                      textInputType: TextInputType.number,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Price is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        onPressedFunction: () async {
                          if (_formKey.currentState!.validate()) {
                            await appConstants.milkServices.addMilk(
                                name: nameController.text.trim(),
                                milk1: milk1Controller.text.trim(),
                                fat1: fat1Controller.text.trim(),
                                milk2: milk2Controller.text.trim(),
                                fat2: fat2Controller.text.trim(),
                                milk3: milk3Controller.text.trim(),
                                fat3: fat3Controller.text.trim(),
                                milk4: milk4Controller.text.trim(),
                                fat4: fat4Controller.text.trim(),
                                milk5: milk5Controller.text.trim(),
                                fat5: fat5Controller.text.trim(),
                                price: priceController.text.trim(),
                                context: context);
                          }
                        },
                        buttonText: "Save",
                        buttonColor: Colors.blue,
                        borderColor: Colors.blue,
                        textColor: Colors.white)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
