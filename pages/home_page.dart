import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatslab4everyone_1/components/News/whatslab4_news_card.dart';
import 'package:whatslab4everyone_1/components/whatslab4_bottom_navigation_bar.dart';
import 'package:whatslab4everyone_1/components/whatslab4_float_action_button.dart';
import 'package:whatslab4everyone_1/services/news/get_news_service.dart';

import '../models/new_model.dart';


class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GetNewsService getNewsService = GetNewsService();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        title: Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
          child: const Center(child: Text("Home page")),
        ),
        leading: const ClipOval(
          child: Icon(Icons.call),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
      bottomNavigationBar: const Whatslab4BottomNavigationBar(),
      body: FutureBuilder(
        future: getNewsService.getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            List<New> news = snapshot.data as List<New>;
            return ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                return Whatslab4NewsCard(
                  title: news[index].title,
                  content: news[index].content,
                  goToUrl: news[index].goToUrl,
                  imageUrls: news[index].imageUrls,
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.done && (!snapshot.hasData || snapshot.data == [])) {
            return const Center(child: Text("has no news!"));
          } else {
            return const Center(child: Text("Error!"));
          }
        },
      ),
      floatingActionButton: const Whatslab4FloatActionButton(),
    );
  }
}
