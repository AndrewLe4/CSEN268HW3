import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/book_cubit.dart';
import '../cubit/book_state.dart';
import '../models/book.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            // leading Widget for AppBar of book details
            leading: state.selectedBook == null
                ? IconButton(icon: const Icon(Icons.menu), onPressed: () {})
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.read<BookCubit>().deselectBook(); // Show book list
                    },
                  ),
            title: const Text('Book Club Home'),
            actions: [
              IconButton(icon: const Icon(Icons.person), onPressed: () {}),
            ],
          ),

          // transitions
          body: state.selectedBook == null
              ? _BookList(key: const ValueKey('list')) //book image
              : _BookDetail(
                  key: const ValueKey('detail'),
                  book: state.selectedBook!, // //all book details
                ),
        );
      },
    );
  }
}

class _BookList extends StatelessWidget {
  const _BookList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BookCubit>();
    final state = cubit.state;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Sort by'),
              const SizedBox(width: 8),
              _SortButton(
                label: 'Author',
                isSelected: state.sortType == BookSortType.author,
                onPressed: () => cubit.filterBooks(BookSortType.author),
              ),
              const SizedBox(width: 8),
              _SortButton(
                label: 'Title',
                isSelected: state.sortType == BookSortType.title,
                onPressed: () => cubit.filterBooks(BookSortType.title),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Books', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () => cubit.selectBook(book), // Show book detail
                    child: Container(
                      width: 150,
                      color: const Color.fromARGB(255, 217, 217, 217),
                      child: Center(
                        child: Text(
                          book.title, // Display book's image (title text)
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BookDetail extends StatelessWidget {
  final Book book;
  const _BookDetail({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: const Color.fromARGB(255, 229, 229, 229),
            child: Center(
              child: Text(
                book.title, // book's title
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            book.title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            //author
            'by ${book.author}',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontStyle: FontStyle.italic, color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          const SizedBox(height: 16),
          Text(
            //description
            book.description,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _SortButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color.fromARGB(255, 247, 211, 223) : const Color.fromARGB(255, 255, 248, 248),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      child: Text(label),
    );
  }
}
