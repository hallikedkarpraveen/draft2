import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadvideoWidget extends StatefulWidget {
  const UploadvideoWidget({Key key}) : super(key: key);

  @override
  _UploadvideoWidgetState createState() => _UploadvideoWidgetState();
}

class _UploadvideoWidgetState extends State<UploadvideoWidget> {
  String uploadedFileUrl1 = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String uploadedFileUrl2 = '';

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      final selectedMedia = await selectMedia(
        isVideo: true,
        multiImage: false,
      );
      if (selectedMedia != null &&
          selectedMedia
              .every((m) => validateFileFormat(m.storagePath, context))) {
        showUploadMessage(
          context,
          'Uploading file...',
          showLoading: true,
        );
        final downloadUrls = (await Future.wait(selectedMedia
                .map((m) async => await uploadData(m.storagePath, m.bytes))))
            .where((u) => u != null)
            .toList();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        if (downloadUrls != null &&
            downloadUrls.length == selectedMedia.length) {
          setState(() => uploadedFileUrl1 = downloadUrls.first);
          showUploadMessage(
            context,
            'Success!',
          );
        } else {
          showUploadMessage(
            context,
            'Failed to upload media',
          );
          return;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Video Upload ',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                final selectedMedia = await selectMedia(
                  isVideo: true,
                  multiImage: false,
                );
                if (selectedMedia != null &&
                    selectedMedia.every(
                        (m) => validateFileFormat(m.storagePath, context))) {
                  showUploadMessage(
                    context,
                    'Uploading file...',
                    showLoading: true,
                  );
                  final downloadUrls = (await Future.wait(selectedMedia.map(
                          (m) async =>
                              await uploadData(m.storagePath, m.bytes))))
                      .where((u) => u != null)
                      .toList();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  if (downloadUrls != null &&
                      downloadUrls.length == selectedMedia.length) {
                    setState(() => uploadedFileUrl2 = downloadUrls.first);
                    showUploadMessage(
                      context,
                      'Success!',
                    );
                  } else {
                    showUploadMessage(
                      context,
                      'Failed to upload media',
                    );
                    return;
                  }
                }

                final usersUpdateData = createUsersRecordData(
                  videoUrl: uploadedFileUrl1,
                );
                await currentUserReference.update(usersUpdateData);
              },
              text: 'upload',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
