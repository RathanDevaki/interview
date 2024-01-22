import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'family.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({Key? key}) : super(key: key);

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  List<String> dropdownListVal = <String>['Two', 'Three', 'Four'];
  List<TextEditingController> _accNoControllers = [];
  List<TextEditingController> _dobController = [];
  List<TextEditingController> _nameController = [];
  List<TextEditingController> _emailController = [];
  List<bool> isApiCallingList = [];
  List<bool> isDateErrorList = [];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    }
  }

  @override
  Widget build(BuildContext context) {
    final _fontStyle = const TextStyle(
        fontWeight: FontWeight.bold, color: Color.fromARGB(255, 31, 19, 251));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextFormField(
                                          controller: _accNoControllers[i],
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              isApiCallingList[i] =
                                                  (value.length == 12);
                                            });
                                            if (value.length == 12) {
                                              // isApiCalling = true;
                                              // callApi!();
                                            }
                                          },
                                          decoration: InputDecoration(
                                            counterText: '',
                                            labelText: jsonData[
                                                        'familyMember${i + 1}']![
                                                    'familyAccountNumber']
                                                ['displayName'],
                                            floatingLabelStyle: _fontStyle,
                                            hintText: jsonData[
                                                        'familyMember${i + 1}']![
                                                    'familyAccountNumber']
                                                ['placeholder'],
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            suffixIcon: (isApiCallingList[i])
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
                                            if (value!.length != 12) {
                                              return '12digit required';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {},
                                        ),
                                        const SizedBox(height: 10),
                                        (isApiCallingList[i])
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Text(
                                                  jsonData['familyMember${i + 1}']![
                                                          'familyAccountNumber']
                                                      ['errorMsg'],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red),
                                                ),
                                              )
                                            : Container(),
                                      ],
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
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            labelText: jsonData[
                                                    'familyMember${i + 1}']![
                                                'familydob']['displayName'],
                                            hintText: jsonData[
                                                    'familyMember${i + 1}']![
                                                'familydob']['placeholder'],
                                            floatingLabelStyle: _fontStyle,
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                Icons.calendar_today,
                                                color: Colors.orange,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                          validator: (value) {
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        (isDateErrorList[i])
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Text(
                                                  jsonData[
                                                          'familyMember${i + 1}']![
                                                      'familydob']['errorMsg'],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red),
                                                ),
                                              )
                                            : Container(),
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
                                    child: DropdownMenu<String>(
                                      expandedInsets: const EdgeInsets.all(1),
                                      onSelected: (String? value) {
                                        setState(() {
                                          // AppState
                                          // dropdownValue = value!;
                                        });
                                      },
                                      trailingIcon:
                                          const Icon(Icons.arrow_downward),
                                      label: Text(
                                        jsonData['familyMember${i + 1}']![
                                                'familyRelationship']
                                            ['displayName'],
                                      ),
                                      errorText: (isApiCallingList[i] == true)
                                          ? jsonData['familyMember${i + 1}']![
                                              'familyRelationship']['errorMsg']
                                          : null,
                                      dropdownMenuEntries:
                                          jsonData['familyMember${i + 1}']![
                                                      'familyRelationship']
                                                  ['Buttonvalues']
                                              .map<DropdownMenuEntry<String>>(
                                                  (String value) {
                                        return DropdownMenuEntry<String>(
                                            value: value, label: value);
                                      }).toList(),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _nameController[i],
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          maxLength: int.parse(
                                            jsonData['familyMember${i + 1}']![
                                                'familyName']['maxLength'],
                                          ),
                                          decoration: InputDecoration(
                                            counterText: '',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            labelText: jsonData[
                                                    'familyMember${i + 1}']![
                                                'familyName']['displayName'],
                                            hintText: jsonData[
                                                    'familyMember${i + 1}']![
                                                'familyName']['placeholder'],
                                            floatingLabelStyle: _fontStyle,
                                          ),
                                          validator: (value) {
                                            final RegExp regex = RegExp(jsonData[
                                                    'familyMember${i + 1}']![
                                                'familyName']['pattern']);
                                            if (!regex.hasMatch(value ?? '')) {
                                              return jsonData[
                                                      'familyMember${i + 1}']![
                                                  'familyName']['errorMsg'];
                                            }
                                            if (value!.length ==
                                                int.parse(jsonData[
                                                        'familyMember${i + 1}']![
                                                    'familyName']['maxLength'])) {
                                              return jsonData[
                                                      'familyMember${i + 1}']![
                                                  'familyName']['maxText'];
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        (isDateErrorList[i])
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Text(
                                                  jsonData[
                                                          'familyMember${i + 1}']![
                                                      'familyName']['errorMsg'],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red),
                                                ),
                                              )
                                            : Container(),
                                      ],
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
                                      enabled: true,
                                      maxLength: int.parse(
                                        jsonData['familyMember${i + 1}']
                                            ['familyEmail']['maxLength'],
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
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
                                        floatingLabelStyle: _fontStyle,
                                      ),
                                      validator: (value) {
                                        if (value!.length ==
                                            int.parse(
                                                jsonData['familyMember${i + 1}']
                                                        ['familyEmail']
                                                    ['maxLength'])) {
                                          return jsonData[
                                                  'familyMember${i + 1}']
                                              ['familyEmail']['maxText'];
                                        }

                                        final RegExp regex = RegExp(
                                            jsonData['familyMember${i + 1}']
                                                ['familyEmail']['pattern']);
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
                  numberOfForms++;
                  _accNoControllers.add(TextEditingController());
                  _dobController.add(TextEditingController());
                  _nameController.add(TextEditingController());
                  _emailController.add(TextEditingController());
                  isApiCallingList.add(false);
                  isDateErrorList.add(false);
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
            child: Text("Print Data"),
          ),
        ],
      ),
    );
  }

  void _deleteForm(int index) {
    setState(() {
      if (numberOfForms > 1) {
        _accNoControllers.removeAt(index);
        _dobController.removeAt(index);
        _nameController.removeAt(index);
        _emailController.removeAt(index);
        isApiCallingList.removeAt(index);
        isDateErrorList.removeAt(index);
        numberOfForms--;
      }
    });
  }
}
