import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/colors.dart';
import 'package:zxplore_app/models/epma_models/get_doc_obtained_response.dart';
import 'package:zxplore_app/models/epma_models/meta/document_types.dart';
import 'package:zxplore_app/screens/controllers/edit_controllers/document_upload_controller.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/actively_viewed_request.dart';
import 'package:zxplore_app/screens/controllers/meta/get_documents_types.dart';
import 'package:zxplore_app/screens/forms/epma/create_new_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/base_edit_screen.dart';
import 'package:zxplore_app/screens/forms/epma/edit_sections_forms_epma/edit_personal_info.dart';
import 'package:zxplore_app/utils/app_sizes.dart';
import 'package:zxplore_app/utils/string_extentions.dart';
import 'package:zxplore_app/widgets/async_ui.dart';
import 'package:zxplore_app/widgets/custom_text_field.dart';
import 'package:zxplore_app/widgets/submit_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:zxplore_app/widgets/zxplore_progress.dart';

class EditAttachedDocument extends ConsumerStatefulWidget {
  const EditAttachedDocument({super.key, this.data});
  final GetDocumentAttachedToEditResponse? data;

  @override
  ConsumerState<EditAttachedDocument> createState() =>
      _EditAttachedDocumentState();
}

class _EditAttachedDocumentState extends ConsumerState<EditAttachedDocument> {
  final docNumberController = TextEditingController();
  final _uploadFormKey = GlobalKey<FormState>();
  DocumentTypesDatum? selectedValue;
  // ignore: unused_field
  String? _documentTypeCode;
  String? _documentTypeName;

  /// File
  File? selectedFile;
  double fileSizeInMB = 0.0;
  bool makingANetworkCall = false;

  /// When true shows the preview image of pdf/png/jpeg
  bool previewValidSelected = false;
  bool fileIsPdf = false;
  String? documentTittle = '';
  int? documentTypeId = -1;

  final TextEditingController prevItemStageController = TextEditingController();
    String? selectedItemStage;
  bool hidePrevItemStage = false;
  void togglePrevItemStage() {
    setState(() {
      hidePrevItemStage = !hidePrevItemStage;
    });
  }

  @override
  void dispose() {
    docNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      fileUploadControllerProvider,
      (_, state) =>
          state.showAlertDialogOnError(context, errorMsg: state.error),
    );
    return ZxploreProgress(
      inAsyncCall: ref.watch(fileUploadControllerProvider).isLoading,
      child: BaseEditForm(
        title: 'Upload Documents',
        widgetToGoOnCancel: Container(),
        onCancel: () => Navigator.pop(context),
        data: {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _uploadFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Select Documents',
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                          div,
                  gapH16,
                  // if (!hidePrevItemStage) ...[
                  //   CustomTextFormField(
                  //     title: "Item Stage",
                  //     fillColor: Colors.transparent,
                  //     controller: prevItemStageController,
                  //     hint: '',
                  //     readOnly: true,
                  //     showCursor: false,
                  //     suffixIcon: Icon(Icons.close_sharp),
                  //     inputType: TextInputType.text,
                  //     useDefaultErrorText: false,
                  //     showDropDownSuffixIcon: true,
                  //     onTap: () {
                  //       togglePrevItemStage();
                  //     },
                  //     validator: (value) {
                  //       return null;
                  //     },
                  //   )
                  // ],
                  // if (hidePrevItemStage) ...[
                  //   Row(children: [
                  //     Text(
                  //       "Item Stage",
                  //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  //           fontWeight: FontWeight.w700, fontSize: 16),
                  //     )
                  //   ]),
                  //   gapH4,
                  //   DropdownButtonHideUnderline(
                  //     child: DropdownButton2<String?>(
                  //       isExpanded: true,
                  //       hint: Text(
                  //         'Select stage',
                  //         style: TextStyle(
                  //           fontSize: 16.0,
                  //           fontWeight: FontWeight.normal,
                  //           color: ZxplorePrimaryColor,
                  //         ),
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //       items: itemStages
                  //           .map<DropdownMenuItem<String?>>(
                  //               (item) => DropdownMenuItem<String?>(
                  //                     value: item,
                  //                     child: Text(
                  //                       item ?? '',
                  //                       style: const TextStyle(
                  //                         fontSize: 16,
                  //                         fontWeight: FontWeight.normal,
                  //                         color: ZxplorePrimaryColor,
                  //                       ),
                  //                       overflow: TextOverflow.ellipsis,
                  //                     ),
                  //                   ))
                  //           .toList(),
                  //       value: selectedItemStage,
                  //       onChanged: (String? newValue) {
                  //         setState(() {
                  //           /// Set selected item params
                  //           selectedItemStage = newValue;
                  //         });
                  //       },
                  //       buttonStyleData: ButtonStyleData(
                  //         height: 60,
                  //         // width: 160,
                  //         padding: const EdgeInsets.only(left: 0, right: 14),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(14),
                  //           border: Border.all(
                  //             color: ZxplorePrimaryColor,
                  //           ),
                  //         ),
                  //         elevation: 0,
                  //       ),
                  //       iconStyleData: const IconStyleData(
                  //         icon: Icon(
                  //           CupertinoIcons.chevron_down,
                  //         ),
                  //         iconSize: 14,
                  //         iconEnabledColor: ZxplorePrimaryColor,
                  //         iconDisabledColor: Colors.grey,
                  //       ),
                  //       dropdownStyleData: DropdownStyleData(
                  //         maxHeight: 200,
                  //         // width: 200,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(14),
                  //         ),
                  //         // offset: const Offset(0, 0),
                  //         scrollbarTheme: const ScrollbarThemeData(
                  //           radius: Radius.circular(40),
                  //           thickness: WidgetStatePropertyAll<double>(6),
                  //           thumbVisibility: WidgetStatePropertyAll<bool>(true),
                  //         ),
                  //       ),
                  //       menuItemStyleData: const MenuItemStyleData(
                  //         height: 40,
                  //         padding: EdgeInsets.only(left: 14, right: 14),
                  //       ),
                  //     ),
                  //   ),
                  // ],
                 
                  gapH16,
                  Row(
                    children: [
                      Text(
                        'Document Type',
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  gapH12,
                  Consumer(
                    builder: (context, ref, child) {
                      return ref.watch(getDocumentTypesProvider).when(
                          data: (data) => (data != null &&
                                  data.isNotEmpty == true)
                              ? DropdownButtonHideUnderline(
                                  child: DropdownButton2<DocumentTypesDatum>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Select Document Type',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: ZxplorePrimaryColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: data
                                        .map<
                                                DropdownMenuItem<
                                                    DocumentTypesDatum>>(
                                            (DocumentTypesDatum item) =>
                                                DropdownMenuItem<
                                                    DocumentTypesDatum>(
                                                  value: item,
                                                  child: Text(
                                                    item.documentTypeName,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color:
                                                          ZxplorePrimaryColor,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (DocumentTypesDatum? newValue) {
                                      setState(() {
                                        /// Set selected item params
                                        selectedValue = newValue;
                                        _documentTypeCode =
                                            newValue?.documentTypeCode;
                                        _documentTypeName =
                                            newValue?.documentTypeName;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 60,
                                      // width: 160,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color:
                                              ZxplorePrimaryColor.withOpacity(
                                                  0.6),
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
                                        thickness:
                                            WidgetStatePropertyAll<double>(6),
                                        thumbVisibility:
                                            WidgetStatePropertyAll<bool>(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          error: (e, s) => const SizedBox.shrink(),
                          loading: () => gapH64);
                    },
                  ),
                  gapH12,
                  CustomTextFormField(
                    fillColor: Colors.transparent,
                    title: 'Document ID',
                    hint: 'Enter Document Number',
                    maxLenght: 25,
                    inputType: TextInputType.phone,
                    controller: docNumberController,
                    validator: (value) {
                      if (_documentTypeName != null &&
                          !_documentTypeName!.toLowerCase().contains('signature')) {
                        if (value.toString().isEmpty) {
                          return 'Enter valid number';
                        }
                      }

                      return null;
                    },
                  ),
                  gapH12,
                  if (selectedValue != null) ...[
                    Row(
                      children: [
                        Text(
                          'Preview',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                  ],
                  gapH12,
                  SizedBox(
                    height: screenSize(context).height * 0.25,
                    width: screenSize(context).width,
                    child: GestureDetector(
                      onTap: () {
                        if (selectedValue == null) {
                          if (mounted) {
                            zXFlushBar(context, 'Select document type');
                          }
                          return;
                        }

                        ///reset all set states
                        setState(() {
                          previewValidSelected = false;
                          fileIsPdf = false;
                        });

                        /// pick a new file
                        pickFile();
                      },
                      child: Container(
                        height: 0.36,
                        width: 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // color:  Colors.grey.shade100,
                        ),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(8),
                          color: ZxplorePrimaryColor,
                          dashPattern: const [4, 4],
                          padding: const EdgeInsets.all(12),
                          child: previewValidSelected
                              ? Column(children: [
                                  /// show it in a pdf view if it is pdf
                                  if (selectedFile != null) ...[
                                    if (fileIsPdf)
                                      SizedBox(
                                          height: 116,
                                          child: Text('${selectedFile!.path}'))
                                    else

                                      /// show image in an  image view if it is a jpeg/png
                                      SizedBox(
                                        child: Image.file(
                                          selectedFile!,
                                          height:
                                              screenSize(context).height * 0.15,
                                          width: screenSize(context).width,
                                          cacheHeight: 50,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    gapH12,
                                    GestureDetector(
                                      onTap: pickFile,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 106,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.refresh),
                                                gapW8,
                                                Text(
                                                  'Replace',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontSize: 16,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 48, 78, 102),
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]
                                ])
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.upload),
                                    gapH16,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Select a file to upload',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    fontSize: 16,
                                                    color: ZxplorePrimaryColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        gapH8,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'max:10mb (png, jpg, docx, pdf)',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: ZxplorePrimaryColor
                                                        .withOpacity(0.5),
                                                    fontSize: 16,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    /// dotted box
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  gapH16,
                  PrimaryButton(
                    title: 'Save',
                    onPressed: () {
                      /// validaate feilds and values annd submit
                      if (!_uploadFormKey.currentState!.validate()) {
                        return;
                      }
                      if (_documentTypeName!
                          .toLowerCase()
                          .contains('signature')) {
                        uploadSignature(context: context);
                      } else {
                        uploadSelectedDocument(context: context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Function to pick a file
  Future<void> pickFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        final String? filePath = result.files.single.path;
        final String fileExtension = filePath!.split('.').last.toLowerCase();
        // Check if the file extension is one of the specified types
        if (['jpg', 'jpeg', 'pdf', 'docx', 'png'].contains(fileExtension)) {
          setState(() {
            selectedFile = File(filePath);
          });
          if (selectedFile != null) {
            // Get the size of the selected file
            final int fileSizeInBytes = selectedFile!.lengthSync();
            final double fileSizeInKB = fileSizeInBytes / 1024.0;
            setState(() {
              fileSizeInMB = fileSizeInKB / 1024.0;
            });

            /// check if its a preview-able file
            if (['jpg', 'jpeg', 'pdf', 'png'].contains(fileExtension)) {
              setState(() {
                previewValidSelected = true;
              });
              if (['pdf'].contains(fileExtension)) {
                setState(() {
                  fileIsPdf = true;
                });
              }
            }
          }
        } else {
          if (mounted) {
            zXFlushBar(context,
                "Invalid file type. Supported types are: jpg, jpeg, pdf, docx, png");
          }
        }
      }
    } catch (e) {
      if (mounted) {
        zXFlushBar(context, "Error picking file: $e");
      }
    }
  }

  Future<void> uploadSelectedDocument({
    required BuildContext context,
  }) async {
    if (fileSizeInMB.toInt() <= 10) {
      if (selectedFile != null) {
        await ref.watch(fileUploadControllerProvider.notifier).uploadFile(
            context: context,
            file: File(selectedFile!.path),
            documentType: _documentTypeCode,
            requestId: ref.read(activelyViewedRequestProvider)?.data?.reqId,
            afterSuccess: () {
              if (mounted) {
                zXFlushBar(context, "Document Uploaded successfully");
              }
            });
      }
    } else {
      if (mounted) {
        zXFlushBar(context, 'File lager than 10 MB');
      }
    }
  }

  Future<void> uploadSignature({
    required BuildContext context,
  }) async {
    if (fileSizeInMB.toInt() <= 10) {
      if (selectedFile != null) {
        await ref.read(fileUploadControllerProvider.notifier).uploadSignaature(
            context: context,
            file: File(selectedFile!.path),
            documentType: _documentTypeCode,
            requestId: ref.read(activelyViewedRequestProvider)?.data?.reqId,
            afterSuccess: () {
              if (mounted) {
                zXFlushBar(context, "Document Uploaded successfully");
              }
            });
      }
    } else {
      if (mounted) {
        zXFlushBar(context, 'File lager than 10 MB');
      }
    }
  }
}
