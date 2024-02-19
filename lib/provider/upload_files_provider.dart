import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../services/app_exceptions.dart';
import '../services/network_service.dart';
import '../utils/app_constants.dart';
import '../utils/toast.dart';

enum LoadingState { initial, loading, success, error }
class UploadAttachmentProvider extends ChangeNotifier {
  var _requestState = LoadingState.initial;

  get requestState => _requestState;

  void uploadAttachmentImage(
      XFile file,
      String comment,
      String id,
      ) async {
    _requestState = LoadingState.loading;
    notifyListeners();
    String sFileName = file.name.toString();

    try {
      final NetworkService apiService = NetworkService();

      Uri postUri =
      Uri.parse(apiService.baseUrl + ApiEndPoints().taskAttachment);

      debugPrint('post_url=$postUri');

      var request = MultipartRequest("POST", postUri);

      request.files.add(
        await MultipartFile.fromPath(
          "attachment_file",
          file.path,
          filename: file.path.split("/").last,
        ),
      );
      request.fields['comments'] = comment;
      request.fields['attachment_filename'] = sFileName;
      request.fields['csa_id'] = id;

      var response = await request.send();

      debugPrint('media_upload_response=$response');
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        _requestState = LoadingState.success;
        notifyListeners();
        showToast('Uploaded Successfully');
      } else {
        _requestState = LoadingState.error;
        notifyListeners();

        debugPrint("Error while Uploading Attachment ");
        debugPrint("Something Went Wrong");
      }
    } on AppException catch (error) {
      _requestState = LoadingState.error;
      notifyListeners();
      String ss = error.toString();
      debugPrint("Error while Uploading Attachment === $ss");
    }
  }

  void editAttachmentImage(
      XFile file,
      String comment,
      AttachmentsModel data,
      String id,
      ) async {
    String sFileName = file.name.toString();
    try {
      final NetworkService apiService = NetworkService();

      Uri postUri = Uri.parse(
          "${apiService.baseUrl + ApiEndPoints().taskAttachment}${data.id}");

      debugPrint('post_url=$postUri');

      var request = MultipartRequest("PUT", postUri);

      request.files.add(
        await MultipartFile.fromPath(
          "attachment_file",
          file.path,
          filename: file.path.split("/").last,
        ),
      );
      request.fields['comments'] = comment;
      request.fields['attachment_filename'] = sFileName;
      request.fields['csa_id'] = id;
      request.fields['id'] = data.id.toString();

      var response = await request.send();

      debugPrint('media_upload_response=$response');
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        showToast('Updated Successfully');
      } else {
        debugPrint("Error while Uploading Attachment ");
        // showErrorToast("Something Went Wrong");
      }
    } on AppException catch (error) {
      String ss = error.toString();
      debugPrint("Error while Uploading Attachment === $ss");
      //  showErrorToast("Something Went Wrong");
    }
  }

  void editAttachment(
      AttachmentsModel data,
      String comment,
      String id,
      ) async {
    var reqBody = {
      "attachment_filename": data.attachmentFilename,
      "comments": comment,
      "csa_id": id,
      'id': data.id,
    };
    try {
      debugPrint('Edit Attachment');
      final NetworkService apiService = NetworkService();

      Response response = await apiService.putResponse(
          '${ApiEndPoints().taskAttachment}${data.id}/', reqBody);

      debugPrint('Edit_task_respo==${response.body.toString()}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        showToast("Task Updated");

        debugPrint("Sucess");
      } else {
        debugPrint("failure");
        ErrorResponseModel errorResponse =
        ErrorResponseModel.fromJson(jsonDecode(response.body));
        debugPrint(
            "Error Whilse Edit Attachment in Action Item data === ${errorResponse.message}");

        // showErrorToast("Something Went Wrong");
      }
    } catch (error) {
      debugPrint(error.toString());

      debugPrint(
          "Error Whilse Edit Attachment  in Action Item data === $error");

      //  showErrorToast("Something Went Wrong");
    }
  }
}
class AttachmentsModel {
  int? id;
  String? attachmentFilename;
  String? attachmentFile;
  String? comments;
  String? attachmentDownloadLink;
  dynamic amaId;
  dynamic csaId;
  dynamic lpaId;
  dynamic isDeleted;

  AttachmentsModel(
      {this.id,
        this.attachmentFilename,
        this.attachmentFile,
        this.comments,
        this.attachmentDownloadLink,
        this.amaId,
        this.csaId,
        this.lpaId,
        this.isDeleted});

  AttachmentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attachmentFilename = json['attachment_filename'];
    attachmentFile = json['attachment_file'];
    comments = json['comments'];
    attachmentDownloadLink = json['attachment_download_link'];
    amaId = json['ama_id'];
    csaId = json['csa_id'];
    lpaId = json['lpa_id'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['attachment_filename'] = attachmentFilename;
    data['attachment_file'] = attachmentFile;
    data['comments'] = comments;
    data['attachment_download_link'] = attachmentDownloadLink;
    data['ama_id'] = amaId;
    data['csa_id'] = csaId;
    data['lpa_id'] = lpaId;
    data['is_deleted'] = isDeleted;
    return data;
  }
}