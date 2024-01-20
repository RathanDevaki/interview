import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  bool isApiCalling = false;
  Function()? callApi;
  List<String> dropdownListVal = <String>['One', 'Two', 'Three', 'Four'];
  String? dropdownValue;
  final TextEditingController _accNoController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = 'John ';
  }

  String? _tempAccNo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width > 600
              ? 800
              : MediaQuery.of(context).size.width,
          //main column
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //first row
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Enter Details of Family member 1',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      InkWell(
                        radius: 30.0,
                        onTap: () {},
                        child: Container(
                          height: 28,
                          width: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.all(4),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
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
                              controller: _accNoController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                // Additional formatters can be added if needed
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _tempAccNo = value;
                                });

                                // Call the custom callback function when 12 digits are entered
                                if (value.length == 12) {
                                  isApiCalling = true;

                                  callApi!();
                                }
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                labelText: 'AccNo',
                                // labelStyle: TextStyle(fontWeight: FontWeight.w500),
                                floatingLabelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: 'Enter AccNo',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                suffixIcon: (isApiCalling)
                                    ? const Padding(
                                        padding: EdgeInsets.only(
                                            right: 8, top: 4, bottom: 4),
                                        child: SizedBox(
                                          height: 14,
                                          width: 14,
                                          child: CircularProgressIndicator(
                                            color:
                                                Color.fromARGB(255, 27, 0, 233),
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              // enabled: widget.isEnabled,
                              maxLength: 12,
                              validator: (value) {
                                if (value!.length != 12) {
                                  return '12digit required';
                                }

                                return null; // Return null if validation passes
                              },
                              onSaved: (value) {
                                // Handle saving of the value if needed
                              },
                            ),
                            (isApiCalling)
                                ? const Text(
                                    'Error Text fhrodsfdiuwhfdsdfewdsoijoiqashjdoiioasjhdoiaoijdojsadoa',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red),
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
                              controller: _dobController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                labelText: 'DOB',
                                hintText: 'Enter DOB',
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.orange,
                                  ),
                                  onPressed: () {
                                    // Add your calendar icon functionality here
                                  },
                                ),
                              ),
                              validator: (value) {
                                // Add your validation logic for DOB here
                                return null; // Return null if validation passes
                              },
                            ),
                            const SizedBox(height: 10),
                            (isApiCalling)
                                ? const Text(
                                    'Error Text fhrodsfdiuwhfdsdfewdsoijoiqashjdoiioasjhdoiaoijdojsadoa',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              //2nd row begins
              //
              Row(
                children: [
                  Expanded(
                    child: DropdownMenu<String>(
                      width: 390,
                      initialSelection: dropdownListVal.first,
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          //AppState
                          dropdownValue = value!;
                        });
                      },
                      trailingIcon: Icon(Icons.arrow_downward),
                      label: Expanded(child: const Text('Select')),
                      errorText: (isApiCalling) ? 'Please Select' : null,
                      dropdownMenuEntries: dropdownListVal
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        labelText: 'Name',
                        hintText: 'Enter Name',
                      ),
                      validator: (value) {
                        // Add your validation logic for DOB here
                        return null; // Return null if validation passes
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
                      controller: _emailController,
                      enabled: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4)),
                        labelText: 'Email',
                        hintText: 'Enter Email Id',
                      ),
                      validator: (value) {
                        // Add your validation logic for DOB here
                        (value == null) ? 'Enter Email' : null;
                        return null; // Return null if validation passes
                      },
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
