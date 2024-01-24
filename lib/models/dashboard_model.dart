class DashboardData {
  bool status;
  int statusCode;
  String message;
  String supportWhatsappNumber;
  double extraIncome;
  int totalLinks;
  int totalClicks;
  int todayClicks;
  String topSource;
  String topLocation;
  String startTime;
  int linksCreatedToday;
  int appliedCampaign;
  Data data;

  DashboardData({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.supportWhatsappNumber,
    required this.extraIncome,
    required this.totalLinks,
    required this.totalClicks,
    required this.todayClicks,
    required this.topSource,
    required this.topLocation,
    required this.startTime,
    required this.linksCreatedToday,
    required this.appliedCampaign,
    required this.data,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        status: json['status'],
        statusCode: json['statusCode'],
        message: json['message'],
        supportWhatsappNumber: json['support_whatsapp_number'],
        extraIncome: json['extra_income'],
        totalLinks: json['total_links'],
        totalClicks: json['total_clicks'],
        todayClicks: json['today_clicks'],
        topSource: json['top_source'],
        topLocation: json['top_location'],
        startTime: json['startTime'],
        linksCreatedToday: json['links_created_today'],
        appliedCampaign: json['applied_campaign'],
        data: Data.fromJson(json['data']),
      );
}

class Data {
  List<Link> recentLinks;
  List<Link> topLinks;
  List<dynamic> favouriteLinks;
  Map<dynamic, dynamic> overallUrlChart;

  Data({
    required this.recentLinks,
    required this.topLinks,
    required this.favouriteLinks,
    required this.overallUrlChart,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        recentLinks:
            List<Link>.from(json['recent_links'].map((x) => Link.fromJson(x))),
        topLinks:
            List<Link>.from(json['recent_links'].map((x) => Link.fromJson(x))),
        favouriteLinks: json['favourite_links'],
        overallUrlChart: json['overall_url_chart'],
      );
}

class Link {
  int urlId;
  String webLink;
  String smartLink;
  String title;
  int totalClicks;
  String originalImage;
  dynamic thumbnail;
  String timesAgo;
  DateTime createdAt;
  String domainId;
  String? urlPrefix;
  String urlSuffix;
  String app;
  bool isFavourite;

  Link({
    required this.urlId,
    required this.webLink,
    required this.smartLink,
    required this.title,
    required this.totalClicks,
    required this.originalImage,
    required this.thumbnail,
    required this.timesAgo,
    required this.createdAt,
    required this.domainId,
    required this.urlPrefix,
    required this.urlSuffix,
    required this.app,
    required this.isFavourite,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        urlId: json['url_id'],
        webLink: json['web_link'],
        smartLink: json['smart_link'],
        title: json['title'],
        totalClicks: json['total_clicks'],
        originalImage: json['original_image'],
        thumbnail: json['thumbnail'],
        timesAgo: json['times_ago'],
        createdAt: DateTime.parse(json['created_at']),
        domainId: json['domain_id'],
        urlPrefix: json['url_prefix'],
        urlSuffix: json['url_suffix'],
        app: json['app'],
        isFavourite: json['is_favourite'],
      );
}

// class ChartData {
//   DateTime date;
//   int value;

//   ChartData({
//     required this.date,
//     required this.value,
//   });
// }
