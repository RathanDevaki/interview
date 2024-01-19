// import 'package:flutter/services.dart';

// class FormFieldAddFamilyMembers extends StatefulWidget {
//   const FormFieldAddFamilyMembers({
//     Key? key,
//     this.width,
//     this.height,
//     required this.callApi,
//     this.isApiCalling,
//     this.dropdownListVal,
//     this.tempAccNo,
//   }) : super(key: key);

//   final double? width;
//   final double? height;
//   final Future<dynamic> Function() callApi;
//   final bool? isApiCalling;
//   final List<String>? dropdownListVal;
//   final String? tempAccNo;

//   @override
//   _FormFieldAddFamilyMembersState createState() =>
//       _FormFieldAddFamilyMembersState();
// }

// class _FormFieldAddFamilyMembersState extends State<FormFieldAddFamilyMembers> {
//   String? dropdownValue;
//   final TextEditingController _accNoController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   List<String>? dropdownListVal;
//   @override
//   void initState() {
//     super.initState();
//     _nameController.text = 'John ';
//     //dropdownListVal = widget.dropdownListVal!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: EdgeInsets.only(top: 30),
//         width: MediaQuery.of(context).size.width > 600
//             ? 800
//             : MediaQuery.of(context).size.width,
//         //main column
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             //first row
//             Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Enter Details of Family member 1',
//                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
//                   ),
//                   InkWell(
//                     radius: 30.0,
//                     onTap: () {},
//                     child: Container(
//                       height: 28,
//                       width: 28,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: IconButton(
//                         padding: EdgeInsets.all(4),
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.delete,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextFormField(
//                           controller: _accNoController,
//                           inputFormatters: <TextInputFormatter>[
//                             FilteringTextInputFormatter.digitsOnly,
//                             // Additional formatters can be added if needed
//                           ],
//                           onChanged: (value) {
//                             setState(() {
//                               //  _tempAccNo = value;
//                             });

//                             // Call the custom callback function when 12 digits are entered
//                             if (value.length == 12) {
//                               //isApiCalling = true;

//                               // callApi!();
//                             }
//                           },
//                           decoration: InputDecoration(
//                             counterText: '',
//                             labelText: 'AccNo',
//                             // labelStyle: TextStyle(fontWeight: FontWeight.w500),
//                             floatingLabelStyle: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                             hintText: 'Enter AccNo',
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(4)),
//                             suffixIcon: (true)
//                                 ? const Padding(
//                                     padding: EdgeInsets.only(
//                                         right: 8, top: 4, bottom: 4),
//                                     child: SizedBox(
//                                       height: 14,
//                                       width: 14,
//                                       child: CircularProgressIndicator(
//                                         color: Color.fromARGB(255, 27, 0, 233),
//                                         strokeWidth: 3,
//                                       ),
//                                     ),
//                                   )
//                                 : null,
//                           ),
//                           // enabled: widget.isEnabled,
//                           maxLength: 12,
//                           validator: (value) {
//                             if (value!.length != 12) {
//                               return '12digit required';
//                             }

//                             return null; // Return null if validation passes
//                           },
//                           onSaved: (value) {
//                             // Handle saving of the value if needed
//                           },
//                         ),
//                         (false)
//                             ? const Text(
//                                 'Error Text fhrodsfdiuwhfdsdfewdsoijoiqashjdoiioasjhdoiaoijdojsadoa',
//                                 style:
//                                     TextStyle(fontSize: 12, color: Colors.red),
//                               )
//                             : Container(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ]),
//           ],
//         ));
//   }
// }
