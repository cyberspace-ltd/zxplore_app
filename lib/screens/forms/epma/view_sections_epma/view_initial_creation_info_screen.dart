import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/screens/controllers/epma_controllers/selected_request_provider.dart';

 class ViewInitialCreationInfoScreen extends ConsumerStatefulWidget {
  const ViewInitialCreationInfoScreen({super.key});

  @override
  ConsumerState<ViewInitialCreationInfoScreen> createState() => _ViewInitialCreationInfoScreenState();
}

class _ViewInitialCreationInfoScreenState extends ConsumerState<ViewInitialCreationInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class FormSectionScreen extends ConsumerWidget {
  final SelectedFormSection section;

  const FormSectionScreen({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, you would fetch this data from your state management solution
    final Map<String, dynamic> sectionData = _getSectionData(ref, section);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getSectionTitle(section)),
        actions: [
          TextButton(
            onPressed: () {
              // Implement edit functionality
              print('Edit button pressed for ${_getSectionTitle(section)}');
            },
            child: const Text('Edit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildSectionContent(sectionData),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement edit functionality
          print('FAB pressed for ${_getSectionTitle(section)}');
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildSectionContent(Map<String, dynamic> sectionData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sectionData.entries.map((entry) {
        if (entry.value is Map<String, dynamic>) {
          return _buildNestedSection(entry.key, entry.value);
        } else if (entry.value is List) {
          return _buildListSection(entry.key, entry.value);
        } else {
          return _buildSimpleField(entry.key, entry.value);
        }
      }).toList(),
    );
  }

  Widget _buildNestedSection(String title, Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: _buildSectionContent(data),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildListSection(String title, List data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...data.map((item) {
          if (item is Map<String, dynamic>) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: _buildSectionContent(item),
            );
          } else {
            return Text(item.toString(), style: const TextStyle(fontSize: 16));
          }
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSimpleField(String key, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(key, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(value.toString(), style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
      ],
    );
  }

  String _getSectionTitle(SelectedFormSection section) {
    return section.toString().split('.').last;
  }

  Map<String, dynamic> _getSectionData(WidgetRef ref, SelectedFormSection section) {
    // In a real app, you would fetch this data from your state management solution
    // For this example, we're using dummy data based on the JSON structure
    final Map<String, dynamic> fullData = {
      "formIndividual": [
        {
          "formId": 0,
          "reqId": "string",
          "stageId": 0,
          "rowVersion": 0,
          "itemStage": "string",
          "surname": "string",
          "firstName": "string",
          "otherNames": "string",
          // ... other fields ...
        }
      ],
      "productsServices": [
        {
          "productsServicesId": 0,
          "reqId": "string",
          "itemStage": "string",
          "rowVersion": 0,
          "adps": true,
          "easyPay": true,
          // ... other fields ...
        }
      ],
      "accountPurposes": [
        {
          "accountPurposesId": 0,
          "reqId": "string",
          "rowVersion": 0,
          "itemStage": "string",
          "salaryProcessing": true,
          "toOtainLoan": true,
          // ... other fields ...
        }
      ],
      "fundingSources": [
        {
          "fundingSourcesId": 0,
          "reqId": "string",
          "rowVersion": 0,
          "itemStage": "string",
          "commissions": true,
          "dividends": true,
          // ... other fields ...
        }
      ],
      // ... other sections ...
    };

    return fullData[section.toString().split('.').last] ?? {};
  }
}