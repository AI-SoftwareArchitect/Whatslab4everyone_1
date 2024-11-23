
class New {
    String title;
    String content;
    String goToUrl;
    List<String>? imageUrls;

    New({
      required this.title,
      required this.content,
      required this.goToUrl,
      this.imageUrls,
    });

    Map<String,dynamic> toJson() {
        return {
          "title": title,
          "content": content,
          "goToUrl": goToUrl,
          "images": imageUrls
        };
    }

    factory New.fromJson(Map<String, dynamic> json) {
      return New(
        title: json["title"] ?? "No Title",
        content: json["content"] ?? "No Content",
        goToUrl: json["goToUrl"] ?? "",
        imageUrls: json["imageUrls"] != null
            ? List<String>.from(json["imageUrls"])
            : [], // Boş bir liste döndür
      );
    }



}