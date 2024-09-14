import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zxplore_app/colors.dart';


class DropT<T> {
  T data;
  DropT(this.data);
}

class CustomDropDownZx<DropT> extends StatefulWidget {
  const CustomDropDownZx(
      {super.key,
      this.data,
      required this.value,
      required this.onChanged,
      required this.itemWidget,
      this.items,
      required this.fieldTitle});
  final Function(DropT?)? onChanged;
  final DropT? data;
  final DropT? value;
  final List<DropT>? items;
  final String fieldTitle;
  final Widget itemWidget;

  @override
  State<CustomDropDownZx> createState() => _CustomDropDownZxState();
}

class _CustomDropDownZxState extends State<CustomDropDownZx> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.fieldTitle,
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<DropT>(
            isExpanded: true,
            hint: Text(
              'Select option',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: ZxplorePrimaryColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            items: widget.items
                ?.map<DropdownMenuItem<DropT>>(
                    (item) => DropdownMenuItem<DropT>(child: Text(  'polo',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            ZxplorePrimaryColor,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,)))
                .toList(),
            value: widget.value,
            onChanged: (DropT? value){
              widget.onChanged!(value);
            },//widge.onChanged,
            buttonStyleData: ButtonStyleData(
              height: 60,
              // width: 160,
              padding: const EdgeInsets.only(left: 0, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: ZxplorePrimaryColor,
                ),
              ),
              elevation: 0,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                CupertinoIcons.chevron_down,
              ),
              iconSize: 14,
              iconEnabledColor: ZxplorePrimaryColor,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              // width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              // offset: const Offset(0, 0),
              scrollbarTheme: const ScrollbarThemeData(
                radius: Radius.circular(40),
                thickness: WidgetStatePropertyAll<double>(6),
                thumbVisibility: WidgetStatePropertyAll<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ],
    );
  }
}
