import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:job_app/services/helpers/book_helper.dart';

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
    var bookMark = BookMarkHelper.getBookMark(jobId);
    bookMark.then((bookmark) => {
      if(bookmark == null){
        isBookmark = false,
        isBookmarkId = ''
      } else{
        isBookmark = true,
        isBookmarkId = bookmark.bookmarkId,
      }
    });
  }
  
  deteleBookMark(String jobId){
    BookMarkHelper.deleteBookMark(jobId).then((value) {
      if(value){
        Get.snackbar(
          'Bookmark successfully deleted',
          'Visit the bookmarks screen to see the changes',
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: const Icon(Icons.bookmark_remove_outlined)
        );
      }
      isBookmark = false;
    },);
  }

  getBookMarks(){
    bookmarks = BookMarkHelper.getAllBookMark();
  }
}