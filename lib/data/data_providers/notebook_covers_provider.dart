class NotebookCover {
  final int id;
  final String name;
  final String url;
  const NotebookCover({
    required this.id,
    required this.name,
    required this.url,
  });
}

class NotebookCoversProvider {
  List<NotebookCover> notebookCovers = [
    const NotebookCover(
      id: 1,
      name: 'cover_1',
      url: 'assets/images/notebooks/bg-1.jpg',
    ),
    const NotebookCover(
      id: 2,
      name: 'cover_2',
      url: 'assets/images/notebooks/bg-2.jpg',
    ),
    const NotebookCover(
      id: 2,
      name: 'cover_2',
      url: 'assets/images/notebooks/bg-2.jpg',
    ),
    const NotebookCover(
      id: 2,
      name: 'cover_2',
      url: 'assets/images/notebooks/bg-2.jpg',
    ),
    const NotebookCover(
      id: 2,
      name: 'cover_2',
      url: 'assets/images/notebooks/bg-2.jpg',
    ),
  ];
}
