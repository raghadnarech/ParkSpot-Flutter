import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:park_spot/const/constants.dart';

class TextInputAuth extends StatefulWidget {
  TextInputAuth(
      {this.type,
      this.control,
      this.hint,
      this.autocorrect,
      this.enableSuggestions,
      this.obscureText});
  String? hint;
  TextEditingController? control;

  bool? obscureText;
  bool? enableSuggestions;
  bool? autocorrect;
  TextInputType? type;

  @override
  State<TextInputAuth> createState() => _TextInputAuthState();
}

class _TextInputAuthState extends State<TextInputAuth> {
  bool hidePass = true;
  String? errormessage(String str) {
    switch (widget.hint) {
      case "Phone number ex:(9xx xxx xxx)":
        return "Please Enter Your Phone Number";
      case "Phone number":
        return "Please Enter Your Phone Number";
      case "Name":
        return "Please Enter Your Name";
      case "Password":
        return "Please Enter Your Password";
      case "re-Password":
        return "Please Enter Your Password agin";
      case "Vehicle ID":
        return "Please Enter ID for Your Car";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: TextFormField(
        inputFormatters: [
          widget.hint == "Phone number ex:(9xx xxx xxx)"
              ? LengthLimitingTextInputFormatter(9)
              : widget.hint == "Vehicle ID"
                  ? LengthLimitingTextInputFormatter(7)
                  : LengthLimitingTextInputFormatter(30),
        ],
        controller: widget.control,
        validator: ((value) {
          if (value!.isEmpty) {
            return errormessage(widget.hint!);
          }
        }),
        obscureText: widget.obscureText!,
        enableSuggestions: widget.enableSuggestions!,
        autocorrect: widget.autocorrect!,
        cursorColor: kPrimaryColor,
        style: TextStyle(
          fontSize: 15,
          color: Color.fromARGB(255, 126, 129, 132),
        ),
        keyboardType: widget.type,
        decoration: InputDecoration(
            filled: true,
            prefixIcon: widget.hint == "Phone number ex:(9xx xxx xxx)"
                ? Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      "image/SY.png",
                      height: 2,
                    ),
                  )
                : null,
            suffixIcon:
                widget.hint == "Password" || widget.hint == "re-Password"
                    ? InkWell(
                        child: Icon(
                          Icons.remove_red_eye,
                          color: kPrimaryColor,
                        ),
                        onTap: () {
                          setState(() {
                            widget.obscureText = !widget.obscureText!;
                          });
                        },
                      )
                    : null,
            fillColor: Color(0xffececec),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: Color(0xffececec),
                )),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: Color(0xffececec),
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: Color(0xffececec),
                )),
            focusColor: Color(0xffececec),
            hintText: widget.hint,
            hintStyle: TextStyle(color: Color.fromARGB(255, 126, 129, 132))),
      ),
    );
  }
}
