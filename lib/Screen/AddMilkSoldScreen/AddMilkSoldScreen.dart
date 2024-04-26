import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:meo_shop/Widgets/ButtonWidget.dart';
import 'package:meo_shop/main.dart';

import '../../Widgets/TextFieldWidget.dart';
import '../../cubit/LoadingCubit/loading_cubit.dart';

class AddMilkSoldScreen extends StatelessWidget {
  AddMilkSoldScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController milkController = TextEditingController();
  TextEditingController fatController = TextEditingController();
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Milk",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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
                        controller: milkController,
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
                        controller: fatController,
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
                  const Spacer(),
                  ButtonWidget(
                      onPressedFunction: () async {
                        if (_formKey.currentState!.validate()) {
                          await appConstants.milkServices.sendMilk(
                              name: nameController.text.trim(),
                              milk: milkController.text.trim(),
                              fat: fatController.text.trim(),
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
        );
      },
    );
  }
}
