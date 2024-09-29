import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/screens/forms/epma/view_sections_epma/view_product_services_sreen.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditProductServices extends ConsumerStatefulWidget {
  const EditProductServices({super.key});

  @override
  ConsumerState<EditProductServices> createState() => _EditProductServicesState();
}

class _EditProductServicesState extends ConsumerState<EditProductServices> {
   

  // Individual TextEditingControllers
  
  bool easyPay = false;
  bool emailNotification = false;
  bool internetBanking = false;
  bool masterCard = false;
  bool visaCard = false;
  bool smsBanking = false;

    // Method to handle checkbox state changes
  void _handleCheckboxChange(int checkboxNumber, bool? value) {
    setState(() {
      switch (checkboxNumber) {
        case 1:
          easyPay = value ?? false;
          break;
        case 2:
          emailNotification = value ?? false;
          break;
        case 3:
          internetBanking = value ?? false;
          break;
        case 4:
          masterCard = value ?? false;
          break;
        case 5:
          visaCard = value ?? false;
          break;
        case 6:
          smsBanking = value ?? false;
          break;
       
      }
    });
  }

 
  void _submitForm() {
    
  }

  @override
  Widget build(BuildContext context) {
    return 
    ZxploreProgress(
      inAsyncCall:  false,
      child: BaseEditForm(
        showAddMore: false,
        button: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
              onPressed: () {
        
              },
              title: 'Save'),
        ),
        title: 'Product Services',
        widgetToGoOnCancel: Placeholder(),
        onCancel: () => Navigator.pop(context),
        data: null,
        addMore: IconButton(onPressed: () {}, icon: Icon(Icons.add_box)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              // Add bottom padding to ensure content is above the keyboard
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Product  Services',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                gapH16,
            
                div,
                gapH16,
                CheckboxListTile(
                  title: Text('easyPay'),
                  value: easyPay,
                  onChanged: (value) => _handleCheckboxChange(1, value),
                ),
                gapH12,
                CheckboxListTile(
                  title: Text('EmailNotification'),
                  value: emailNotification,
                  onChanged: (value) => _handleCheckboxChange(2, value),
                ),
                gapH12,
            
                CheckboxListTile(
                  title: Text('Internet Banking'),
                  value: internetBanking,
                  onChanged: (value) => _handleCheckboxChange(3, value),
                ),
                
                gapH12,
            
                CheckboxListTile(
                  title: Text('MasterCard'),
                  value: masterCard,
                  onChanged: (value) => _handleCheckboxChange(3, value),
                ),
                
                gapH12,
                CheckboxListTile(
                  title: Text('Visa Card'),
                  value: visaCard,
                  onChanged: (value) => _handleCheckboxChange(4, value),
                ),
                gapH12,
            
                CheckboxListTile(
                  title: Text('SMS Banking'),
                  value: smsBanking,
                  onChanged: (value) => _handleCheckboxChange(5, value),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
 
  }
}
