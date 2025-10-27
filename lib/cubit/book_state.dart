import 'package:equatable/equatable.dart';
import '../models/book.dart';

enum BookSortType { author, title }

class BookState {
  final List<Book> books;
  final BookSortType sortType;
  final Book? selectedBook;

  const BookState({
    this.books = const [],
    this.sortType = BookSortType.author,
    this.selectedBook,
  });
  
  BookState copyWith({
    List<Book>? books,
    BookSortType? sortType,
    Book? selectedBook,
    bool deselectBook = false,
  }) {
    return BookState(
      books: books ?? this.books,
      sortType: sortType ?? this.sortType,
      selectedBook: deselectBook ? null : selectedBook ?? this.selectedBook,
    );
  }
}
