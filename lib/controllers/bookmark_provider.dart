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

// class BookNotifier extends ChangeNotifier {
//   late Future<List<AllBookMarks>> bookmarks;
//   final Map<String, bool> _bookmarksStatus = {}; // Lưu trạng thái bookmark theo jobId
//   final Map<String, String> _bookmarksIds = {};   // Lưu bookmarkId theo jobId
//
//   bool isBookmarked(String jobId) => _bookmarksStatus[jobId] ?? false;
//   String getBookmarkId(String jobId) => _bookmarksIds[jobId] ?? '';
//
//   Future<void> addBookMark(String jobId, String model) async {
//     try {
//       // Cập nhật trạng thái ngay lập tức
//       _bookmarksStatus[jobId] = true;
//       notifyListeners();
//
//       final bookmark = await BookMarkHelper.addBookMark(model);
//       _bookmarksIds[jobId] = bookmark.bookmarkId;
//       notifyListeners();
//     } catch (e) {
//       // Revert nếu có lỗi
//       _bookmarksStatus.remove(jobId);
//       _bookmarksIds.remove(jobId);
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   Future<void> deleteBookMark(String jobId) async {
//     final bookmarkId = _bookmarksIds[jobId];
//     if (bookmarkId == null) return;
//
//     try {
//       // Cập nhật ngay lập tức
//       _bookmarksStatus.remove(jobId);
//       _bookmarksIds.remove(jobId);
//       notifyListeners();
//
//       await BookMarkHelper.deleteBookMark(bookmarkId);
//     } catch (e) {
//       // Khôi phục nếu có lỗi
//       _bookmarksStatus[jobId] = true;
//       _bookmarksIds[jobId] = bookmarkId;
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   Future<void> getBookMark(String jobId) async {
//     try {
//       final bookmark = await BookMarkHelper.getBookMark(jobId);
//       if (bookmark != null) {
//         _bookmarksStatus[jobId] = true;
//         _bookmarksIds[jobId] = bookmark.bookmarkId;
//       } else {
//         _bookmarksStatus.remove(jobId);
//         _bookmarksIds.remove(jobId);
//       }
//       notifyListeners();
//     } catch (e) {
//       // Xử lý lỗi nếu cần
//       debugPrint('Error checking bookmark: $e');
//     }
//   }
//
//   getBookMarks() {
//     bookmarks = BookMarkHelper.getAllBookMark();
//   }
//
// }