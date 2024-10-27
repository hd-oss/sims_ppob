import '../../domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  BannerModel({super.bannerImage, super.bannerName, super.description});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerName: json['banner_name'],
      bannerImage: json['banner_image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_name'] = bannerName;
    data['banner_image'] = bannerImage;
    data['description'] = description;
    return data;
  }
}
