import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/src/shared/app_sizes.dart';

final meansOfIdFormKey = GlobalKey<FormState>(debugLabel: 'meansOfId');

class MeansOfIdentificationPage extends ConsumerStatefulWidget {
  const MeansOfIdentificationPage({super.key});

  @override
  ConsumerState<MeansOfIdentificationPage> createState() =>
      _MeansOfIdentificationPageState();
}

class _MeansOfIdentificationPageState
    extends ConsumerState<MeansOfIdentificationPage> {
  late final TextEditingController _idTypeController;
  late final TextEditingController _idPlaceOfIssueController;
  late final TextEditingController _idIssuerController;
  late final TextEditingController _idNumberController;

  String? _selectedIdType;
  DateTime? _idIssueDate;
  DateTime? _expiryDate;
  bool _sendEmail = false;
  bool _receiveSms = false;
  bool _requestHardwareToken = false;
  bool _requestInternetBanking = false;

  final _idTypes = [
    'DRIVER\'S LICENSE',
    'INT\'L PASSPORT',
    'NATIONAL ID',
    'OTHERS',
    'VOTER\'S ID CARD',
    'STUDENT ID'
  ];

  final initialDate = DateTime.now().subtract(const Duration(days: 365 * 14));
  final firstDate = DateTime.now().subtract(const Duration(days: 365 * 80));
  final lastDate = DateTime.now().subtract(const Duration(days: 365 * 13));

  @override
  void initState() {
    super.initState();
    _idTypeController = TextEditingController();
    _idPlaceOfIssueController = TextEditingController();
    _idIssuerController = TextEditingController();
    _idNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _idTypeController.dispose();
    _idPlaceOfIssueController.dispose();
    _idIssuerController.dispose();
    _idNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: meansOfIdFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select ID Type',
                      helperText: "* Required",
                    ),
                    value: _selectedIdType,
                    isDense: true,
                    items: _idTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedIdType = value;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please choose an ID type';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  TextFormField(
                    controller: _idPlaceOfIssueController,
                    decoration: const InputDecoration(
                      labelText: 'Place of Issue',
                      helperText: "* Required",
                      isDense: true,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter place of issue';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      InputDatePickerFormField(
                        firstDate: firstDate,
                        lastDate: lastDate,
                        initialDate: _idIssueDate,
                        errorInvalidText: 'Please enter a valid date',
                        fieldLabelText: 'Date of Issue',
                        fieldHintText: 'M/D/YYYY',
                        keyboardType: TextInputType.datetime,
                        onDateSubmitted: (DateTime value) {
                          setState(() {
                            _idIssueDate = value;
                          });
                        },
                        onDateSaved: (value) {
                          setState(() {
                            _idIssueDate = value;
                          });
                        },
                      ),
                      IconButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: firstDate,
                            lastDate: lastDate,
                          );

                          if (date != null) {
                            setState(() {
                              _idIssueDate = date;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '* Required',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                  gapH12,
                  TextFormField(
                    controller: _idIssuerController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'ID Issuer',
                      helperText: "* Required",
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the issuer of your ID';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  TextFormField(
                    controller: _idNumberController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'ID Number',
                      helperText: "* Required",
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number on your ID';
                      }
                      return null;
                    },
                  ),
                  gapH16,
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      InputDatePickerFormField(
                        firstDate: firstDate,
                        lastDate: lastDate,
                        initialDate: _expiryDate,
                        errorInvalidText: 'Please enter a valid expiry date',
                        fieldLabelText: 'Date of Issue',
                        fieldHintText: 'M/D/YYYY',
                        keyboardType: TextInputType.datetime,
                        onDateSubmitted: (DateTime value) {
                          setState(() {
                            _expiryDate = value;
                          });
                        },
                        onDateSaved: (value) {
                          setState(() {
                            _expiryDate = value;
                          });
                        },
                      ),
                      IconButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: firstDate,
                            lastDate: lastDate,
                          );

                          if (date != null) {
                            setState(() {
                              _expiryDate = date;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '* Required',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                  gapH12,
                  SwitchListTile.adaptive(
                    value: _sendEmail,
                    dense: true,
                    onChanged: (value) {
                      setState(() {
                        _sendEmail = value;
                      });
                    },
                    title: Text(
                      'Send statement to email',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  gapH16,
                  SwitchListTile.adaptive(
                    value: _receiveSms,
                    dense: true,
                    onChanged: (value) {
                      setState(() {
                        _receiveSms = value;
                      });
                    },
                    title: Text(
                      'Receive SMS alert',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  gapH16,
                  SwitchListTile.adaptive(
                    value: _requestHardwareToken,
                    dense: true,
                    onChanged: (value) {
                      setState(() {
                        _requestHardwareToken = value;
                      });
                    },
                    title: Text(
                      'Request hardware token',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  gapH16,
                  SwitchListTile.adaptive(
                    value: _requestInternetBanking,
                    dense: true,
                    onChanged: (value) {
                      setState(() {
                        _requestInternetBanking = value;
                      });
                    },
                    title: Text(
                      'Request Internet Banking',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
