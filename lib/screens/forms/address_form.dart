import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zxplore_app/blocs/account_form_bloc.dart';
import 'package:zxplore_app/blocs/provider.dart';
import 'package:zxplore_app/models/place_prediction.dart';

import '../../colors.dart';

class AddressFormPage extends StatefulWidget {
  TextEditingController address1Controller, cityOfResidenceController;
  AccountFormBloc accountFormBloc;

  AddressFormPage({
    required this.address1Controller,
    required this.accountFormBloc,
    required this.cityOfResidenceController,
  });

  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  bool addressIsSelected = true;
  List<Prediction> places = [];
  TextEditingController? bottomSheetAddress1Controller;

  @override
  void initState() {
    super.initState();
    bottomSheetAddress1Controller = TextEditingController();
  }

  @override
  void dispose() {
    bottomSheetAddress1Controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.accountFormBloc.place.listen((event) {
      if (event.length != 0) {
        if (mounted) {
          setState(() {
            places = event;
          });
        }
      }
    });

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: ZxplorePrimaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20),
            child: TextField(
              controller: bottomSheetAddress1Controller!,
              textCapitalization: TextCapitalization.characters,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                //   addressIsSelected =true;
                if (value.isNotEmpty) {
                  placePrediction(value);
                  setState(() {
                    places = [];
                  });
                }
              },
              maxLength: 100,
              maxLines: null,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                labelText: 'Enter Address',
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          places.length != 0
              ? Visibility(
                  visible: addressIsSelected,
                  child: Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      itemCount: places.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          bottomSheetAddress1Controller!.text = "";
                          bottomSheetAddress1Controller!.text =
                              places[index].description.toUpperCase();
                          widget.accountFormBloc.changeAddress1(
                              places[index].description.toUpperCase());
                          widget.accountFormBloc.changeCityOfResidence(
                              places[index].mainText.toUpperCase());
                          //  widget.address1Controller.text = places[index].description.toUpperCase();
                          //  widget.cityOfResidenceController.text = places[index].mainText.toUpperCase();
                          addressIsSelected = false;
                          //    setState(() {
                          places = [];
                          //   });
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(places[index].description,
                                  style: TextStyle(fontSize: 14))),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  void placePrediction(String text) {
    String val = text;
    if (val.isNotEmpty) {
      widget.accountFormBloc.getPlaces(val);
    }
  }
}
