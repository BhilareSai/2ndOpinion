import 'dart:io';

import 'package:doctor_opinion/models/doctor/degrees.dart';
import 'package:doctor_opinion/provider/dropdown.dart';
import 'package:doctor_opinion/tp.dart';
import 'package:doctor_opinion/widgets/doctor/customDropDown.dart';
import 'package:doctor_opinion/widgets/doctor/email.dart';
import 'package:doctor_opinion/widgets/doctor/phone.dart';
import 'package:doctor_opinion/widgets/doctor/username.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class doctorSignUpPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpPage();
  }
}

int _pointer = 0;
final ImagePicker _picker = ImagePicker();
File? _profileImage;
bool imageLoading = false;
Future pickImage() async {
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    _profileImage = imageTemp;
  } on PlatformException catch (e) {
    imageLoading = false;
    print('Failed to pick image: $e');
  }
}

class _SignUpPage extends ConsumerState<doctorSignUpPage> {
  void setPointer(int i) {
    setState(() {
      _pointer = i;
    });
  }

  late List<Widget> screens = [
    IntroPage(
      pointerSet: setPointer,
    ),
    BasicDetails(
      setPointer: setPointer,
    ),
    Singlefilepicker(),
    EducationalDetails(
      setPointer: setPointer,
    ),
    Achivements()
  ];
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColorLight,
          title: Text(
            "Get OnBoard",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        body: screens[_pointer]);
  }
}

class IntroPage extends StatelessWidget {
  IntroPage({required Function this.pointerSet});
  Function pointerSet;
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Column(
        children: [
          Spacer(),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Lottie.asset("assets/Animation - 1721160123515 (3).json")),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Your Experties are valuable!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.circular(5)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Join Us in Redefining Care: Provide Expert Second Opinions and Make a Difference!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.circular(5)),
          ),
          Spacer(),
          FilledButton.tonal(
              onPressed: () {
                pointerSet(1);
              },
              child: Text(
                "Lets go ",
                style: Theme.of(context).textTheme.displayMedium,
              )),
          Spacer()
        ],
      ),
    );
  }
}

GlobalKey<FormState> _personalInfo = GlobalKey<FormState>();
String _username = "";
bool _vusername = true;
String _phone = "";
bool _vphone = true;
String _email = "";
bool _vemail = true;

class BasicDetails extends StatefulWidget {
  const BasicDetails({required Function this.setPointer});
  final Function setPointer;

  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  void validateUsername(String username, bool vuser) {
    _username = username;
    _vusername = vuser;
  }

  void validatePhone(String phone, bool p) {
    _phone = phone;
    _vphone = p;
  }

  void validateEmail(String email, bool e) {
    _email = email;
    _vemail = e;
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                  height: 80,
                  // width: MediaQuery.of(context).size.width * 0.2,
                  "assets/personalInfo icon.png"),
              // const SizedBox(
              //   width: 5,
              // ),
              const Text("Personale Info "),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _personalInfo,
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Container(
                    child: imageLoading ? CircularProgressIndicator() : null,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 7, color: Theme.of(context).primaryColor),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _profileImage != null
                                ? FileImage(
                                    _profileImage!,
                                  )
                                : AssetImage("assets/doctorProfile.png"))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: FilledButton.icon(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        setState(() {
                          imageLoading = true;
                        });
                        await pickImage();
                        setState(() {
                          imageLoading = false;
                        });
                      },
                      label: Text("Profile Picture")),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: TextFormField(
                      decoration: InputDecoration(label: Text("First Name")),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                    child: TextFormField(
                      decoration: InputDecoration(label: Text("Last Name")),
                    ),
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(label: Text("Age")),
                    ),
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(label: Text("Gender")),
                        value: "Female",
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                          DropdownMenuItem(
                            child: Text("Female"),
                            value: "Female",
                          ),
                          DropdownMenuItem(
                            child: Text("Other"),
                            value: "Other",
                          )
                        ],
                        onChanged: (v) {},
                      ),
                    ),
                  ),
                ],
              ),
              UserNameWidget(vadliateUsername: validateUsername),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: const InputDecoration(label: Text("Password")),
                ),
              ),
              Phonewidget(validatePhone: validatePhone),
              EmailWidget(validateEmail: validateEmail),
              FilledButton(
                  onPressed: () {
                    widget.setPointer(2);
                  },
                  child: Text("Next"))
            ],
          ),
        ),
      ),
    );
  }
}

class EducationalDetails extends ConsumerStatefulWidget {
  EducationalDetails({required Function this.setPointer});
  Function setPointer;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EducationalDetails();
    throw UnimplementedError();
  }
}

class _EducationalDetails extends ConsumerState<EducationalDetails> {
  bool search = false;
  List<String> data = [];
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  widget.setPointer(1);
                },
                icon: const Icon(Icons.arrow_back)),
            Image.asset(
              'assets/test.png',
              width: 80,
              height: 50,
            ),
            const Text("Education/specialization"),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (v) {
                  print("v is");
                  print(v);
                  setState(() {
                    if (v.isEmpty || v == "") {
                      search = false;
                    } else {
                      search = true;
                    }
                  });
                  ref
                      .read(DropDownProvider.notifier)
                      .searchDegreeMethod(v.toUpperCase());
                  // ref.refresh(DropDownProvider);
                },
                decoration: new InputDecoration(
                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(25)),
                  suffix: Icon(Icons.search),
                  labelText: "Search your degree",
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      width: 2.0,
                    ),
                  ),

                  //fillColor: Colors.green
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            search
                ? CustoDropDown()
                : Container(
                    child: selectedMedicalDegreesAndSpecializations.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                child: Image.asset('assets/empty-folder.png'),
                              ),
                              Text("Add your Specilaization")
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 8),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: selectedDegree(context)),
                          ),
                  )
            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Container(
            //     height: MediaQuery.of(context).size.height * 0.5,
            //     decoration: BoxDecoration(
            //         border: Border.all(
            //             color: Theme.of(context).colorScheme.outlineVariant)),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class Achivements extends StatelessWidget {
  Widget build(context) {
    return Column();
  }
}

Widget selectedDegree(context) {
  List<Widget> data = [];
  selectedMedicalDegreesAndSpecializations.forEach((key, value) {
    value.forEach((v) {
      data.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: Theme.of(context).focusColor,
          title: Text(
            key,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          subtitle: Text(v.keys.toString()),
          trailing: Column(
            children: [Icon(Icons.add_to_photos), Text("Certificate")],
          ),
        ),
      ));
    });
  });
  return ListView(
    children: data,
  );
}
