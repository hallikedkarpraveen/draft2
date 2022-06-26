import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../uploadpage/uploadpage_widget.dart';
import '../welcome/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  PagingController<DocumentSnapshot, VideosRecord> _pagingController;
  Query _pagingQuery;
  List<StreamSubscription> _streamSubscriptions = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).gray600,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (currentUserEmailVerified ?? true)
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: AuthUserStreamWidget(
                              child: Text(
                                currentUserDisplayName,
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .subtitle1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      InkWell(
                        onTap: () async {
                          await signOut();
                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeWidget(),
                            ),
                            (r) => false,
                          );
                        },
                        child: Icon(
                          Icons.notifications,
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 7),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderWidth: 1,
                          buttonSize: 40,
                          icon: Icon(
                            Icons.camera_alt,
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                            size: 30,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadpageWidget(),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 70,
                          icon: Icon(
                            Icons.location_history,
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                            size: 30,
                          ),
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                PagedListView<DocumentSnapshot<Object>, VideosRecord>(
                  pagingController: () {
                    final Query<Object> Function(Query<Object>) queryBuilder =
                        (videosRecord) => videosRecord;
                    if (_pagingController != null) {
                      final query = queryBuilder(VideosRecord.collection);
                      if (query != _pagingQuery) {
                        // The query has changed
                        _pagingQuery = query;
                        _streamSubscriptions.forEach((s) => s?.cancel());
                        _streamSubscriptions.clear();
                        _pagingController.refresh();
                      }
                      return _pagingController;
                    }

                    _pagingController = PagingController(firstPageKey: null);
                    _pagingQuery = queryBuilder(VideosRecord.collection);
                    _pagingController.addPageRequestListener((nextPageMarker) {
                      queryVideosRecordPage(
                        queryBuilder: (videosRecord) => videosRecord,
                        nextPageMarker: nextPageMarker,
                        pageSize: 25,
                        isStream: true,
                      ).then((page) {
                        _pagingController.appendPage(
                          page.data,
                          page.nextPageMarker,
                        );
                        final streamSubscription =
                            page.dataStream?.listen((data) {
                          final itemIndexes = _pagingController.itemList
                              .asMap()
                              .map((k, v) => MapEntry(v.reference.id, k));
                          data.forEach((item) {
                            final index = itemIndexes[item.reference.id];
                            final items = _pagingController.itemList;
                            if (index != null) {
                              items.replaceRange(index, index + 1, [item]);
                              _pagingController.itemList = {
                                for (var item in items) item.reference: item
                              }.values.toList();
                            }
                          });
                          setState(() {});
                        });
                        _streamSubscriptions.add(streamSubscription);
                      });
                    });
                    return _pagingController;
                  }(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  builderDelegate: PagedChildBuilderDelegate<VideosRecord>(
                    // Customize what your widget looks like when it's loading the first page.
                    firstPageProgressIndicatorBuilder: (_) => Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                      ),
                    ),

                    itemBuilder: (context, _, listViewIndex) {
                      final listViewVideosRecord =
                          _pagingController.itemList[listViewIndex];
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 350,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).textColor,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (responsiveVisibility(
                                    context: context,
                                    tablet: false,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                    Expanded(
                                      child: FlutterFlowVideoPlayer(
                                        path: listViewVideosRecord.videoUrl,
                                        videoType: VideoType.network,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        autoPlay: true,
                                        looping: false,
                                        showControls: true,
                                        allowFullScreen: false,
                                        allowPlaybackSpeedMenu: true,
                                        lazyLoad: true,
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 10, 15, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        StreamBuilder<List<VideosRecord>>(
                                          stream: queryVideosRecord(
                                            singleRecord: true,
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<VideosRecord>
                                                textVideosRecordList =
                                                snapshot.data;
                                            // Return an empty Container when the document does not exist.
                                            if (snapshot.data.isEmpty) {
                                              return Container();
                                            }
                                            final textVideosRecord =
                                                textVideosRecordList.isNotEmpty
                                                    ? textVideosRecordList.first
                                                    : null;
                                            return Text(
                                              listViewVideosRecord.tags,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBtnText,
                                                      ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 10, 15, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          listViewVideosRecord.title,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 10, 15, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          listViewVideosRecord.summary,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
