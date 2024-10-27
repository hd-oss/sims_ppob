import '../../domain/entities/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel(
      {super.serviceCode,
      super.serviceIcon,
      super.serviceName,
      super.serviceTariff});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
        serviceCode: json['service_code'],
        serviceName: json['service_name'],
        serviceIcon: json['service_icon'],
        serviceTariff: json['service_tariff']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_code'] = serviceCode;
    data['service_name'] = serviceName;
    data['service_icon'] = serviceIcon;
    data['service_tariff'] = serviceTariff;
    return data;
  }
}
