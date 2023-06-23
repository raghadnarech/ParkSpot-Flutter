import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/view/Auth/login.dart';
import 'package:park_spot/view/Auth/otp_page.dart';
import 'package:park_spot/view/Home/home.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:park_spot/widget/textinput_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Register_Car extends StatefulWidget {
  bool? showlogin;
  Register_Car({super.key, this.showlogin});

  @override
  State<Register_Car> createState() => _Register_CarState();
}

TextEditingController typeController = TextEditingController();
TextEditingController colorController = TextEditingController();
TextEditingController countryController = TextEditingController();

class _Register_CarState extends State<Register_Car> {
  TextEditingController _vehicleIDController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String TypeSelect = "Kia";
  List<String> Type = [
    "Kia",
    "Abarth",
    "AC",
    "Acura",
    "Aixam",
    "Alfa Romeo",
    "Ariel",
    "Arrinera",
    "Aston Martin",
    "Audi",
    "Bentley",
    "BMW",
    "Bugatti",
    "Buick",
    "Cadillac",
    "Caterham",
    "Chevrolet",
    "Chrysler",
    "Citroen",
    "Delorean",
    "Corvette",
    "Dacia",
    "Daewoo",
    "Daf",
    "Daihatsu",
    "Dodge",
    "Dr Motor",
    "Elfin",
    "Ferrari",
    "Fiat",
    "Ford",
    "Ford Mustang",
    "Gaz",
    "Geely",
    "General Motors",
    "Gillet",
    "Ginetta",
    "GMC",
    "Great Wall",
    "Gumpert",
    "Hennessey",
    "Holden",
    "Honda",
    "Hummer",
    "Hyundai",
    "Infiniti",
    "Isuzu",
    "Jaguar",
    "Jeep",
    "Joss",
    "Koenigsegg",
    "Lada",
    "Lamborghini",
    "Lancia",
    "Land Rover",
    "Lexus",
    "Lincoln",
    "Lotus",
    "Luxgen",
    "Mahindra",
    "Maruti Suzuki",
    "Maserati",
    "Maybach",
    "Mazda",
    "Mclaren",
    "Mercedes Benz",
    "MG",
    "Mini",
    "Mitsubishi",
    "Morgan Motor",
    "Mosler",
    "Nissan Motors",
    "Noble Automotive",
    "Opel",
    "Pagani",
    "Panoz",
    "Perodua",
    "Peugeot",
    "Piaggio",
    "Pininfarina",
    "Porsche",
    "Proton",
    "Renault",
    "Reva",
    "Rimac Automobili",
    "Rolls Royce",
    "Ruf Automobile",
    "Saab",
    "Scania",
    "Scion",
    "Seat",
    "Shelby",
    "Skoda",
    "Smart",
    "Spyker Cars",
    "Ssangyong",
    "SSC",
    "Subaru",
    "Suzuki",
    "Tata",
    "Tatra",
    "Terms",
    "Tesla",
    "Think",
    "Toyota",
    "Tramontana",
    "Troller",
    "TVR",
    "UAZ",
    "Vandenbrink Design",
    "Vauxhall",
    "Vector Motors",
    "Venturi",
    "Volkswagen",
    "Volvo",
    "Wiesmann",
    "Zagato",
    "Zaz",
    "Zil"
  ];
  String ColorSelect = "White";
  List<String> colors = [
    "Red",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Purple",
    "Pink",
    "Brown",
    "Gray",
    "Black",
    "White",
    "Silver"
  ];
  String CountrySelect = "Damascus";
  List<String> Country = [
    "Damascus",
    "Homs",
    "Sweidaa",
    "Edlb",
    "Tartous",
    "Lattakia",
    "Daraa",
    "Hama",
    "Qunitra",
    "Rif Dimashq",
    "Al-Hasakah",
    "Al-Raqa",
    "Dir Alzor",
    "Aleppo"
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    CarProvider carProvider = Provider.of<CarProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              "image/board3.png",
                              // height: height * 0.3,
                              width: width * 0.8,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Select Your Type Car:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        color: Color(0xffececec),
                        width: double.infinity,
                        child: DropdownButtonFormField(
                            dropdownColor: Color(0xffececec),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                fillColor: Color(0xffececec),
                                focusColor: Color(0xffececec),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffececec),
                                  ),
                                )),
                            value: TypeSelect,
                            items: Type.map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                )).toList(),
                            onChanged: (String? item) => setState(() {
                                  TypeSelect = item!;
                                  print(TypeSelect);
                                })),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Select Your Color Car:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        color: Color(0xffececec),
                        width: double.infinity,
                        child: DropdownButtonFormField(
                            dropdownColor: Color(0xffececec),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                fillColor: Color(0xffececec),
                                focusColor: Color(0xffececec),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffececec),
                                  ),
                                )),
                            value: ColorSelect,
                            items: colors
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ))
                                .toList(),
                            onChanged: (String? item) => setState(() {
                                  ColorSelect = item!;
                                })),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Select Country Car:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        color: Color(0xffececec),
                        width: double.infinity,
                        child: DropdownButtonFormField(
                            dropdownColor: Color(0xffececec),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                fillColor: Color(0xffececec),
                                focusColor: Color(0xffececec),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color(0xffececec),
                                    )),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xffececec),
                                  ),
                                )),
                            value: CountrySelect,
                            items:
                                Country.map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    )).toList(),
                            onChanged: (String? item) => setState(() {
                                  CountrySelect = item!;
                                  print(CountrySelect);
                                })),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        "Enter Your Vehicle ID:",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextInputAuth(
                        hint: "Vehicle ID",
                        enableSuggestions: true,
                        autocorrect: true,
                        obscureText: false,
                        type: TextInputType.number,
                        control: _vehicleIDController,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        height: height * 0.06,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor),
                            onPressed: () async {
                              if (_globalKey.currentState!.validate()) {
                                print(ColorSelect);
                                print(_vehicleIDController.text);
                                print(CountrySelect);
                                if (await carProvider.register_car(
                                    CountrySelect,
                                    _vehicleIDController.text,
                                    TypeSelect,
                                    ColorSelect)) {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: HomePage(),
                                        isIos: false,
                                        duration: Duration(milliseconds: 300),
                                      ));
                                } else {
                                  Flushbar(
                                    backgroundColor: Colors.red,
                                    title: 'Failed',
                                    message: 'You Cant register now',
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                }
                              }
                            },
                            child: carProvider.isLoadingregistercar
                                ? Text(
                                    "Loading ...",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Next",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
