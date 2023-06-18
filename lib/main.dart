
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? pickedImage;
  TextEditingController _date = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>(); //key for form
  List<String> items = [
    'Number of siblings',
    '0',
    '1',
    '2',
    '3',
    '4',
    'More',
  ];
  String dropdownValue = 'Number of siblings';

  String DropdownValue = '0';
  String name = "";
  Widget showbottonsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            "Choose profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  PickImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera),
                label: const Text("camera"),
              ),
              TextButton.icon(
                onPressed: () {
                  PickImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.image),
                label: const Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future PickImage(ImageSource imagetype) async {
    try {
      await ImagePicker().pickImage(source: imagetype);
      if (pickedImage == null) {
        return;
      }
      final imageTemporary = File(pickedImage!.path);
      setState(() => pickedImage = imageTemporary);
    } on Platform  catch (error) {
      debugPrint(error.toString());
    }
  }

  // Future PickImageGallery(ImageSource source) async {
  //   try {
  //     await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) {
  //       return;
  //     }
  //     final imageTemporary = File(image!.path);
  //     setState(() => image = imageTemporary);
  //   } on Platform catch (e) {
  //     print("Can't Pick the Image; $e ");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: SingleChildScrollView(
          child: Form(
            key: formKey, //key for form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.04),
                const Text(
                  "Here to Get",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),
                const Text(
                  "Welcomed !",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Center(
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 80.0,
                        backgroundImage: 
                        AssetImage('assets/img.jpg'),
                      ),
                      Positioned(
                          bottom: 20.0,
                          right: 20.0,
                          child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => showbottonsheet()));
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.teal,
                                size: 28.0,
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Your Name",
                      filled: true,
                      fillColor: Colors.grey[70],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      return "Enter correct name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Phone",
                      filled: true,
                      fillColor: Colors.grey[70],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                            .hasMatch(value!)) {
                      return "Enter correct Phone number";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter your Email",
                      filled: true,
                      fillColor: Colors.grey[70],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}+$') // w mean any kind of letter or numers th3en you might have desh(-)and dot(.)then obviously have @ after that combination of W or any letter or number then period which is dot(.) then combinaton of letters can come 2 to 4 times repeated
                            .hasMatch(value!)) {
                      return "Enter correct Email";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.grey[70],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)")
                              .hasMatch(value!)) {
                        return " Password should contain Capital, small letter & Number & Special";
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  controller: _date,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: "Select Date of Birth",
                  ),
                  onTap: () async {
                    DateTime? Pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2024));
                    if (Pickeddate != null) {
                      setState(() {
                        // _date.text = DateFormat('yyyy-MM-dd'). format(Pickeddate);
                        _date.text = Pickeddate.toString();
                      });
                    }
                  },
                ),
                Center(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue ?? '';
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 22),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: IconButton(
                        onPressed: () {
                          // ignore: prefer_typing_uninitialized_variables
                          if (formKey.currentState!.validate()) {
                            // check if form data is valid
                            //pprocess task ahead if valid
                            final snackBar = SnackBar(
                              content: Text("Form is submitting"),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 100.0,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
