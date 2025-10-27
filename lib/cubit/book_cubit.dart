import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/book.dart';
import 'book_state.dart';

// Cubit with HomePage
class BookCubit extends Cubit<BookState> {
  BookCubit() : super(const BookState());

  void init() {
    final books = List.generate(7, (index) {
      return Book(
        title: 'Book Title ${index + 1}',
        author: 'Author ${index + 1}',
        description: 'This is a description for Book ${index + 1}.',
      );
    });
    books.sort((a, b) => a.author.compareTo(b.author)); // Add this line
    emit(state.copyWith(books: books));
  }

//shows the book's details
  void selectBook(Book book) {
    emit(state.copyWith(selectedBook: book));
  }

//leading Widget for AppBar of book detail page
  void deselectBook() {
    emit(state.copyWith(deselectBook: true));
  }


//sort the list of books by author or title
  void filterBooks(BookSortType sortType) {
    final books = [...state.books];
    if (sortType == BookSortType.author) {
      books.sort((a, b) => a.author.compareTo(b.author));
    } else {
      books.sort((a, b) => a.title.compareTo(b.title));
    }
    emit(state.copyWith(books: books, sortType: sortType));
  }
}
