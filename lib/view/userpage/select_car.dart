import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/UserProvider.dart';
import 'package:park_spot/view/splash.dart';
import 'package:park_spot/view/userpage/parking_confirm.dart';
import 'package:provider/provider.dart';

class SelectCar extends StatelessWidget {
  const SelectCar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Select Car"),
      ),
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: kBaseColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: height * 0.62,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: userProvider!.CarList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async {},
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          userProvider!.setdefaultcar(index);
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          title: Text("${userProvider!.CarList[index].Type}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          subtitle: Text(
                              "${userProvider!.CarList[index].Country} | ${userProvider!.CarList[index].NumCar}"),
                          trailing: Image.asset(
                            "image/carlogo/car.png",
                            fit: BoxFit.fitWidth,
                            width: width * 0.3,
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
