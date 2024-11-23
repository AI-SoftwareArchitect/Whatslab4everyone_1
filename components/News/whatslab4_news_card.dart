import 'package:flutter/material.dart';
import 'package:whatslab4everyone_1/components/whatslab4_button.dart';

class Whatslab4NewsCard extends StatelessWidget {
  final String title;
  final String content;
  final String goToUrl;
  final List<String>? imageUrls;

  final String _url = "http://10.0.2.2:3000";

  Whatslab4NewsCard({
    super.key,
    required this.title,
    required this.content,
    required this.goToUrl,
    this.imageUrls,
  });

  Widget getWidgetFromImageUrls() {
    if (imageUrls == null || imageUrls!.isEmpty) {
      return const SizedBox(height: 5);
    } else {
      return ListView.builder(
        shrinkWrap: true, // ListView'un boyutunu sınırlamak için
        physics: const NeverScrollableScrollPhysics(), // Kaydırmayı devre dışı bırak
        itemCount: imageUrls!.length,
        itemBuilder: (context, index) {
          return Image.network(
            _url + imageUrls![index],
            width: 200,
            height: 200,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              title,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Center(
            child: Text(
              content,
              overflow: TextOverflow.fade,
            ),
          ),
          getWidgetFromImageUrls(),
          SizedBox(height: 10,),
          Whatslab4Button(onPressed: () {

          },w4bSize: Whatslab4ButtonSize.small, title: "Go", fontSize: 22),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
