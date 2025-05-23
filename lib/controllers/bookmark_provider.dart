import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:job_app/services/helpers/book_helper.dart';
import 'package:job_app/views/screens/bookmark/bookmarks_screen.dart';

class BookNotifier extends ChangeNotifier{
  late Future<List<AllBookMarks>> bookmarks;
  bool _bookmark = false;

  bool get bookmark => _bookmark;

  set isBookmark(bool newState){
    if(_bookmark != newState){
      _bookmark = newState;
      notifyListeners();
    }
  }

  String _bookmarkId = '';

  String get bookmarkId => _bookmarkId;

  set isBookmarkId(String newState){
    if(_bookmarkId != newState){
      _bookmarkId = newState;
      notifyListeners();
    }
  }

  addBookMark(String model){
    BookMarkHelper.addBookMark(model).then((bookmark){
      isBookmark = true;
      isBookmarkId = bookmark.bookmarkId;
    });
  }

  getBookMark(String jobId){
    var bookmark = BookMarkHelper.getBookMark(jobId);
    bookmark.then((bookmark) => {
      if(bookmark == null){
        isBookmark = false,
        isBookmarkId = ''
      } else{
        isBookmark = bookmark.status,
        isBookmarkId = bookmark.bookmarkId,
      }
    });
  }

  deleteBookMark(String jobId) {
    BookMarkHelper.deleteBookMark(jobId).then((value) {
      if(value){
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: const Text('Bookmark deleted successfully'),
            backgroundColor: Color(kDark.value),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'View',
              textColor: Color(kLight.value),
              onPressed: () {
                Get.to(()=> BookmarksScreen());
              },
            ),
          ),
        );
      }
      isBookmark = false;
    },);
  }

  Future<List<AllBookMarks>> getBookMarks(){
    bookmarks = BookMarkHelper.getAllBookMark();
    return bookmarks;

  }
}