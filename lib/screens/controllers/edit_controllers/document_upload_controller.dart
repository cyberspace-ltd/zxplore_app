import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zxplore_app/apis/endpoints.dart';
import 'package:path/path.dart' as path;

part 'document_upload_controller.g.dart';

class FileUploadService {
  final String apiKey;
  final String bearerToken;

  /// map value eg 12309
  final dynamic typeValue;

  /// map key e.g Requestid,DocumentId
  final dynamic typeKey;

  /// map value eg 12309
  final dynamic idValue;

  /// map key e.g Requestid,DocumentId
  final dynamic idKey;

  FileUploadService(
      {required this.apiKey,
      required this.bearerToken,
      this.idKey,
      this.idValue,
      this.typeKey,
      this.typeValue});

  Future<bool> uploadFileService(File file, String url,
  {
    /// map value eg 12309
  final dynamic typeValue,

  /// map key e.g Requestid,DocumentId
  final dynamic typeKey,

  /// map value eg 12309
  final dynamic idValue,

  /// map key e.g Requestid,DocumentId
  final dynamic idKey,
 } ) async {
    try {
      final uri = Uri.parse(url).replace(queryParameters: {
        idKey ?? 'RequestId': idValue,
        typeKey ?? 'DocumentType': typeValue,
      });

      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $bearerToken',
        'ApiKey': apiKey,
        'Content-Type': 'multipart/form-data'
      });

      // Add file to the request
      var multipartFile = await http.MultipartFile.fromPath(
        'file',
        file.path,
        filename: path.basename(file.path),
      );
      request.files.add(multipartFile);

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        return true;
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error uploading file: $e');
      return false;
    }
  }


  Future<bool> addSignatureService(File file, String url,
  {
    /// map value eg 12309
  final dynamic typeValue,

  /// map key e.g Requestid,DocumentId
  final dynamic typeKey,

  /// map value eg 12309
  final dynamic idValue,

  /// map key e.g Requestid,DocumentId
  final dynamic idKey,
 } ) async {
    try {
      final uri = Uri.parse(url).replace(queryParameters: {
        idKey ?? 'RequestId': idValue,
      });

      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll({
        'Authorization': 'Bearer $bearerToken',
        'ApiKey': apiKey,
        'Content-Type': 'multipart/form-data'
      });

      // Add file to the request
      var multipartFile = await http.MultipartFile.fromPath(
        'file',
        file.path,
        filename: path.basename(file.path),
      );
      request.files.add(multipartFile);

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        return true;
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error uploading file: $e');
      return false;
    }
  }
}

@riverpod
class FileUploadController extends _$FileUploadController {
  late FileUploadService _service;

  @override
  FutureOr<void> build() {
    _service = FileUploadService(
      apiKey: 'YOUR_API_KEY',
      bearerToken: 'YOUR_BEARER_TOKEN',
    );
  }

  Future<bool> uploadFile({
    File? file,
    String? url,
    required String? requestId,
    required String? documentType,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _service.uploadFileService(
          file!, '${Endpoints.EPMA_MIDDLEWARE_BASE_URL}Opearation/uploadFiles',idValue:requestId,typeValue: documentType );
      state = AsyncValue.data(null);
      return result;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }
    Future<bool> addSignature({
    File? file,
    String? url,
    required String? requestId,
    required String? documentType,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _service.addSignatureService(
          file!, '${Endpoints.EPMA_MIDDLEWARE_BASE_URL}Opearation/addSignature',idValue:requestId, );
      state = AsyncValue.data(null);
      return result;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }
}
