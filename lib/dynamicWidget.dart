import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'family.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({Key? key}) : super(key: key);

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  List<TextEditingController> _accNoControllers = [];
  List<TextEditingController> _dobController = [];
  List<TextEditingController> _nameController = [];
  List<TextEditingController> _emailController = [];
  List<bool> isApiCallingList = [];
  List<bool> isDateErrorList = [];
  List<String?> dropdownValue = [];
  List<bool> isAccError = [];
  List<bool> nameEnabled = [];
  List<bool> emailEnabled = [];
  List<bool> isRepeated = [];
  List<void Function()> apiCallback = [];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final errorStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.red);
  final errorBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
    ), // Set error border color
  );
  final focusErrorBorder = const OutlineInputBorder(
    borderSide: BorderSide(
        color: Colors.red, width: 2), // Set focused error border color
  );
  final emailRegEx =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-]+.)+[a-zA-Z]{2,}))$';
  final nameRegex = r"^[a-zA-Z]+(?:['-]?[a-zA-Z]+)*$";
  int numberOfForms = 1;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < numberOfForms; i++) {
      _accNoControllers.add(TextEditingController());
      _dobController.add(TextEditingController());
      _nameController.add(TextEditingController());
      _emailController.add(TextEditingController());
      isApiCallingList.add(false);
      isDateErrorList.add(false);
      dropdownValue.add(null);
      nameEnabled.add(true);
      emailEnabled.add(false);
      isAccError.add(false);
      isRepeated.add(false);
    }
  }

  final fontStyle = const TextStyle(
      fontWeight: FontWeight.bold, color: Color.fromARGB(255, 31, 19, 251));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: SizedBox(
              height: 320,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    for (int i = 0; i < numberOfForms; i++)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          width: 900,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Enter Details of Family member ${i + 1}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  (i > 0)
                                      ? Container(
                                          height: 28,
                                          width: 28,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: IconButton(
                                            padding: const EdgeInsets.all(4),
                                            onPressed: () {
                                              _deleteForm(i);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _accNoControllers[i],
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          isApiCallingList[i] =
                                              (value.length == 12);

                                          for (int j = 0;
                                              j < _accNoControllers.length;
                                              j++) {
                                            if (j != i &&
                                                _accNoControllers[j].text ==
                                                    value) {
                                              isRepeated[i] = true;
                                              break;
                                            } else {
                                              isRepeated[i] = false;
                                            }
                                          }
                                          isAccError[i] = isRepeated[i];
                                        });

                                        if (isApiCallingList.length < i &&
                                            isApiCallingList[i] &&
                                            !isRepeated[i]) {
                                          apiCallback[i]();

                                          print('API calling');
                                          // isApiCalling = true;
                                          // callApi!();
                                        }
                                      },
                                      decoration: InputDecoration(
                                        errorBorder: errorBorder,
                                        focusedErrorBorder: focusErrorBorder,
                                        errorMaxLines: 5,
                                        errorStyle: errorStyle,
                                        counterText: '',
                                        labelText:
                                            jsonData['familyMember${i + 1}']![
                                                    'familyAccountNumber']
                                                ['displayName'],
                                        floatingLabelStyle: fontStyle,
                                        hintText:
                                            jsonData['familyMember${i + 1}']![
                                                    'familyAccountNumber']
                                                ['placeholder'],
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        suffixIcon: (isApiCallingList[i] &&
                                                !isRepeated[i])
                                            ? const Padding(
                                                padding: EdgeInsets.only(
                                                    right: 8,
                                                    top: 4,
                                                    bottom: 4),
                                                child: SizedBox(
                                                  height: 8,
                                                  width: 8,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color.fromARGB(
                                                        255, 27, 0, 233),
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ),
                                      maxLength: int.parse(
                                          jsonData['familyMember${i + 1}']![
                                                  'familyAccountNumber']
                                              ['maxLength']),
                                      validator: (value) {
                                        if (i >= isRepeated.length) {
                                          i = isRepeated.length - 1;
                                        }

                                        if (value!.length != 12) {
                                          return '12digit required';
                                        }
                                        if (isRepeated[i]) {
                                          return 'Please provide unique account details.';
                                        }
                                        if (isAccError[i] == true) {
                                          return jsonData[
                                                      'familyMember${i + 1}']![
                                                  'familyAccountNumber']
                                              ['errorMsg'];
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {},
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _dobController[i],
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            errorBorder: errorBorder,
                                            focusedErrorBorder:
                                                focusErrorBorder,
                                            errorMaxLines: 5,
                                            errorStyle: errorStyle,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            labelText: jsonData[
                                                    'familyMember${i + 1}']![
                                                'familydob']['displayName'],
                                            hintText: jsonData[
                                                    'familyMember${i + 1}']![
                                                'familydob']['placeholder'],
                                            floatingLabelStyle: fontStyle,
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                Icons.calendar_today,
                                                color: Colors.orange,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                          validator: (value) {
                                            return (isDateErrorList.length <
                                                        i &&
                                                    isDateErrorList[i])
                                                ? jsonData[
                                                        'familyMember${i + 1}']![
                                                    'familydob']['errorMsg']
                                                : null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              //2nd row begins
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        errorBorder: errorBorder,
                                        focusedErrorBorder: focusErrorBorder,
                                        errorMaxLines: 2,
                                        errorStyle: errorStyle,
                                        contentPadding:
                                            const EdgeInsets.all(20.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        labelText:
                                            jsonData['familyMember${i + 1}']![
                                                    'familyRelationship']
                                                ['displayName'],
                                      ),
                                      value: dropdownValue[i],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue[i] = newValue!;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return jsonData[
                                                  'familyMember${i + 1}']![
                                              'familyRelationship']['errorMsg'];
                                        }
                                        return null;
                                      },
                                      items: jsonData['familyMember${i + 1}']![
                                                  'familyRelationship']
                                              ['Buttonvalues']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _nameController[i],
                                      enabled: nameEnabled[i],
                                      keyboardType: TextInputType.text,
                                      maxLength: int.parse(
                                        jsonData['familyMember${i + 1}']![
                                            'familyName']['maxLength'],
                                      ),
                                      decoration: InputDecoration(
                                        errorBorder: errorBorder,
                                        focusedErrorBorder: focusErrorBorder,
                                        errorMaxLines: 5,
                                        errorStyle: errorStyle,
                                        counterText: '',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        labelText:
                                            jsonData['familyMember${i + 1}']![
                                                'familyName']['displayName'],
                                        hintText:
                                            jsonData['familyMember${i + 1}']![
                                                'familyName']['placeholder'],
                                        floatingLabelStyle: fontStyle,
                                      ),
                                      validator: (value) {
                                        print(i);
                                        if (nameEnabled[i]) {
                                          if (value!.isEmpty) {
                                            return 'Name is reqired';
                                          }
                                          final RegExp regex =
                                              RegExp(nameRegex);

                                          if (!regex.hasMatch(value!)) {
                                            return jsonData[
                                                    'familyMember${i + 1}']![
                                                'familyName']['errorMsg'];
                                          }
                                          if (value.length ==
                                              int.parse(jsonData[
                                                      'familyMember${i + 1}']![
                                                  'familyName']['maxLength'])) {
                                            return jsonData[
                                                    'familyMember${i + 1}']![
                                                'familyName']['maxText'];
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              //3rd Row
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _emailController[i],
                                      enabled: emailEnabled[i],
                                      maxLength: int.parse(
                                        jsonData['familyMember${i + 1}']
                                            ['familyEmail']['maxLength'],
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        errorBorder: errorBorder,
                                        focusedErrorBorder: focusErrorBorder,
                                        errorMaxLines: 5,
                                        errorStyle: errorStyle,
                                        counterText: '',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        labelText:
                                            jsonData['familyMember${i + 1}']
                                                ['familyEmail']['displayName'],
                                        hintText:
                                            jsonData['familyMember${i + 1}']
                                                ['familyEmail']['placeholder'],
                                        floatingLabelStyle: fontStyle,
                                      ),
                                      validator: (value) {
                                        if (emailEnabled[i] == true) {
                                          final RegExp regex =
                                              RegExp(emailRegEx);
                                          if (value!.isEmpty) {
                                            return 'Email is Required';
                                          }
                                          if (value!.length ==
                                              int.parse(jsonData[
                                                          'familyMember${i + 1}']
                                                      ['familyEmail']
                                                  ['maxLength'])) {
                                            return jsonData[
                                                    'familyMember${i + 1}']
                                                ['familyEmail']['maxText'];
                                          }

                                          if (!regex.hasMatch(value)) {
                                            return jsonData[
                                                    'familyMember${i + 1}']
                                                ['familyEmail']['errorMsg'];
                                          }
                                          if (value == '') {
                                            return jsonData[
                                                    'familyMember${i + 1}']
                                                ['familyEmail']['errorMsg'];
                                          }
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(child: SizedBox()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (numberOfForms < 5) {
                  ++numberOfForms;
                  _accNoControllers.add(TextEditingController());
                  _dobController.add(TextEditingController());
                  _nameController.add(TextEditingController());
                  _emailController.add(TextEditingController());
                  isApiCallingList.add(false);
                  isDateErrorList.add(false);
                  dropdownValue.add(null);
                  nameEnabled.add(true);
                  emailEnabled.add(true);
                  isAccError.add(false);
                  isRepeated.add(false);
                }
              });
            },
            child: const Text("Add Form"),
          ),
          ElevatedButton(
            onPressed: () {
              // Print data for each form separately
              if (_formKey.currentState!.validate()) {
                for (int i = 0; i < numberOfForms; i++) {
                  print(
                      "Data for Form ${i + 1}: ${_accNoControllers[i].text} , ${_dobController[i].text} , ${_nameController[i].text} , ${_emailController[i].text}");
                }
              }
            },
            child: const Text("Print Data"),
          ),
        ],
      ),
    );
  }

  void _deleteForm(int index) {
    setState(() {
      if (numberOfForms > 1 && index < numberOfForms) {
        --numberOfForms;
        _accNoControllers.removeAt(index);
        _dobController.removeAt(index);
        _nameController.removeAt(index);
        _emailController.removeAt(index);
        isApiCallingList.removeAt(index);
        isDateErrorList.removeAt(index);
        dropdownValue.removeAt(index);
        emailEnabled.removeAt(index);
        isAccError.removeAt(index);
        isRepeated.removeAt(index);
      }
    });
  }
}
