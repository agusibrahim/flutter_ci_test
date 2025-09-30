import 'package:flutter/material.dart';

/// Data model for a single page in the PageView.
///
/// Contains the title of the page and a list of strings, each representing a paragraph
/// of scrollable content for that page.
class PageData {
  final String title;
  final List<String> contentParagraphs;

  const PageData({
    required this.title,
    required this.contentParagraphs,
  });
}

/// A stateless widget responsible for displaying the content of a single page.
///
/// It takes a [PageData] object and renders its title and scrollable paragraphs.
class PageContentWidget extends StatelessWidget {
  final PageData pageData;

  const PageContentWidget({
    super.key,
    required this.pageData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            pageData.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                // Check for user-initiated drag updates for vertical scrolling.
                if (notification is ScrollUpdateNotification &&
                    notification.dragDetails != null &&
                    notification.metrics.axis == Axis.vertical) {
                  // If the ListView is at its very top (extentBefore == 0)
                  // and the user is pulling down (scrollDelta > 0, content moves down).
                  // In this case, allow the parent PageView to scroll to the previous page.
                  if (notification.metrics.extentBefore == 0 &&
                      notification.scrollDelta != null &&
                      notification.scrollDelta! > 0) {
                    return false; // Do not consume, propagate to parent.
                  }
                  // If the ListView is at its very bottom (extentAfter == 0)
                  // and the user is pulling up (scrollDelta < 0, content moves up).
                  // In this case, allow the parent PageView to scroll to the next page.
                  if (notification.metrics.extentAfter == 0 &&
                      notification.scrollDelta != null &&
                      notification.scrollDelta! < 0) {
                    return false; // Do not consume, propagate to parent.
                  }
                }
                // Consume all other notifications or if the ListView can still scroll,
                // preventing the parent PageView from scrolling prematurely.
                return true;
              },
              child: ListView.builder(
                // Use BouncingScrollPhysics to allow overscroll visuals,
                // making the transition to PageView scrolling feel more natural.
                physics: const BouncingScrollPhysics(),
                itemCount: pageData.contentParagraphs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      pageData.contentParagraphs[index],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The main application widget, setting up the Flutter app with a vertical PageView.
///
/// It uses [StatefulWidget] to manage the current page index.
class CustomPageViewApp extends StatefulWidget {
  const CustomPageViewApp({super.key});

  @override
  State<CustomPageViewApp> createState() => _CustomPageViewAppState();
}

class _CustomPageViewAppState extends State<CustomPageViewApp> {
  late final List<PageData> _pages;
  int _currentPageIndex = 0; // Initial page index

  @override
  void initState() {
    super.initState();
    _pages = _createSamplePages(); // Initialize pages
  }

  /// Generates a list of sample [PageData] objects to populate the PageView.
  /// This method can be replaced with actual data fetching logic in a real application.
  static List<PageData> _createSamplePages() {
    return <PageData>[
      PageData(
        title: 'Halaman 1: Pengenalan Flutter',
        contentParagraphs: List<String>.generate(
          20,
          (int i) =>
              'Ini adalah paragraf ke-${i + 1} untuk Halaman 1. Flutter adalah UI toolkit dari Google untuk membangun aplikasi secara native untuk mobile, web, dan desktop dari satu codebase. Dengan Flutter, Anda dapat membuat aplikasi yang indah dan berkinerja tinggi serta menikmati proses pengembangan yang cepat.',
        ),
      ),
      PageData(
        title: 'Halaman 2: Widget dan Composisi',
        contentParagraphs: List<String>.generate(
          25,
          (int i) =>
              'Paragraf ke-${i + 1} di Halaman 2. Dalam Flutter, hampir semua adalah widget. Anda mengkomposisikan widget untuk membangun antarmuka pengguna yang kompleks. Setiap bagian dari UI, mulai dari tombol hingga tata letak, adalah widget yang dapat disesuaikan.',
        ),
      ),
      PageData(
        title: 'Halaman 3: State Management',
        contentParagraphs: List<String>.generate(
          18,
          (int i) =>
              'Ini adalah paragraf ke-${i + 1} di Halaman 3. Mengelola state aplikasi adalah kunci dalam aplikasi Flutter yang berskala. Penggunaan `StatefulWidget` dengan `setState` adalah metode bawaan Flutter untuk mengelola state lokal.',
        ),
      ),
      PageData(
        title: 'Halaman 4: Desain Responsif',
        contentParagraphs: List<String>.generate(
          22,
          (int i) =>
              'Paragraf ke-${i + 1} di Halaman 4. Penting untuk mendesain UI yang responsif agar terlihat baik di berbagai ukuran perangkat dan orientasi. Menggunakan widget seperti `MediaQuery` dan `LayoutBuilder` dapat membantu Anda menyesuaikan tampilan aplikasi secara dinamis.',
        ),
      ),
      PageData(
        title: 'Halaman 5: Animasi dan Efek',
        contentParagraphs: List<String>.generate(
          30,
          (int i) =>
              'Ini adalah paragraf ke-${i + 1} untuk Halaman 5. Flutter menyediakan alat yang kuat untuk membuat animasi yang indah dan efek visual yang menarik. Anda bisa menggunakan `ImplicitlyAnimatedWidget` atau `AnimatedBuilder` untuk kontrol yang lebih granular dan kustomisasi animasi.',
        ),
      ),
    ];
  }

  /// Updates the current page index and triggers a UI rebuild.
  void _setCurrentPageIndex(int index) {
    if (_currentPageIndex != index) {
      setState(() {
        _currentPageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Halaman Vertikal',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 4.0,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 28.0, color: Colors.indigo),
          bodyLarge: TextStyle(fontSize: 16.0, height: 1.5),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Navigasi Halaman Vertikal'),
          centerTitle: true,
        ),
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _pages.length,
          onPageChanged: (int index) {
            _setCurrentPageIndex(index);
          },
          itemBuilder: (BuildContext context, int index) {
            final PageData pageData = _pages[index];
            return PageContentWidget(pageData: pageData);
          },
        ),
      ),
    );
  }
}
