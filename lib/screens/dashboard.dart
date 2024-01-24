import 'dart:io';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_services.dart';
import '../widgets/link_card.dart';
import '../widgets/stat_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future _futureDashboardData;

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  openwhatsapp(phone) async {
    var url = '';
    if (Platform.isAndroid) {
      // add the [https]
      url = "https://wa.me/$phone/"; // new line
    } else {
      // add the [https]
      url = "https://api.whatsapp.com/send?phone=$phone"; // new line
    }

    await launchUrl(Uri.parse(url));
  }

  @override
  void initState() {
    _futureDashboardData = ApiServices().getDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String greeting = getGreeting();

    final List<ChartData> chartData = [
      ChartData(1924, 1),
      ChartData(1925, 3),
      ChartData(1926, 3),
      ChartData(1927, 2),
      ChartData(1928, 5),
    ];
    final List<Color> color = <Color>[];
    color.add(Colors.blue.shade50.withOpacity(0.5));
    color.add(Colors.blue.shade200.withOpacity(0.5));
    color.add(Colors.blue.withOpacity(0.5));

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
        LinearGradient(colors: color, stops: stops);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        title: const Text(
          "Dashboard",
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _futureDashboardData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var dashboardData = snapshot.data!;
            return SafeArea(
              child: ColoredBox(
                color: Colors.blue.shade600,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 10),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      // container with rounded edge
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Colors.grey.shade100),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),

                                // greetings based on time
                                Text(
                                  "Good $greeting,",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                // username
                                const Text(
                                  'Ajay Manva 👋',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(height: 20),

                                // stats graph
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  height: 200,
                                  width: double.infinity,
                                  child: SfCartesianChart(
                                    title: const ChartTitle(
                                      text: "Overview",
                                      textStyle: TextStyle(color: Colors.grey),
                                      alignment: ChartAlignment.near,
                                    ),
                                    primaryYAxis: const NumericAxis(
                                        labelFormat: '{value}'),
                                    series: <CartesianSeries>[
                                      // Renders area chart
                                      AreaSeries<ChartData, int>(
                                          dataSource: chartData,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          gradient: gradientColors)
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // stat cards scroll view
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      StatCard(
                                        icon: Icons.ads_click_rounded,
                                        iconColor: Colors.purple,
                                        title: dashboardData.todayClicks
                                            .toString(),
                                        subtitle: "Today's Clicks",
                                      ),
                                      StatCard(
                                        icon: Icons.location_on,
                                        iconColor: Colors.blue,
                                        title: dashboardData.topLocation,
                                        subtitle: "Top Location",
                                      ),
                                      StatCard(
                                        icon: CupertinoIcons.globe,
                                        iconColor: Colors.red,
                                        title: dashboardData.topSource,
                                        subtitle: "Top Source",
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 20),
                                // 'view analytics' button
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.all(15),
                                      foregroundColor: Colors.black,
                                      side:
                                          const BorderSide(color: Colors.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    icon: const Icon(Icons.auto_graph_rounded),
                                    label: const Text("View Analytics"),
                                  ),
                                ),

                                const SizedBox(height: 40),
                                // link cards
                                DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TabBar(
                                        dividerHeight: 0,
                                        unselectedLabelColor: Colors.grey,
                                        labelColor: Colors.white,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.blue,
                                        ),
                                        tabs: const [
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("Top Links"),
                                            ),
                                          ),
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("Recent Links"),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 170 * 3,
                                        child: TabBarView(children: [
                                          SingleChildScrollView(
                                            child: Column(
                                              children: dashboardData
                                                  .data.topLinks
                                                  .map<Widget>(
                                                    (linkData) => LinkCard(
                                                      imageUrl: linkData
                                                          .originalImage,
                                                      linkName: linkData.title,
                                                      date: DateFormat.yMMMMd()
                                                          .format(linkData
                                                              .createdAt),
                                                      linkUrl: linkData.webLink,
                                                      clicks:
                                                          linkData.totalClicks,
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            child: Column(
                                              children: dashboardData
                                                  .data.recentLinks
                                                  .map<Widget>(
                                                    (linkData) => LinkCard(
                                                      imageUrl: linkData
                                                          .originalImage,
                                                      linkName: linkData.title,
                                                      date: linkData.createdAt
                                                          .toString(),
                                                      linkUrl: linkData.webLink,
                                                      clicks:
                                                          linkData.totalClicks,
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        ]),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // view all links button
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.all(15),
                                      foregroundColor: Colors.black,
                                      side:
                                          const BorderSide(color: Colors.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    icon: const Icon(Icons.link_rounded),
                                    label: const Text("View all Links"),
                                  ),
                                ),
                                const SizedBox(height: 50),

                                // whatsapp chat button
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.all(15),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.green.shade50,
                                      side: BorderSide(
                                          color: Colors.green.shade100),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      openwhatsapp(
                                          dashboardData.supportWhatsappNumber);
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green,
                                    ),
                                    label: const Text("Talk with us"),
                                  ),
                                ),

                                const SizedBox(height: 20),
                                // faq button
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.all(15),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.blue.shade50,
                                      side: BorderSide(
                                          color: Colors.blue.shade100),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.help_outline_rounded,
                                      color: Colors.blue,
                                    ),
                                    label: const Text(
                                        "Frequently Asked Questions"),
                                  ),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        color: Colors.grey,
        backgroundColor: Colors.white,
        activeColor: Colors.blue,
        height: 70,
        style: TabStyle.fixedCircle,
        elevation: 0.5,
        shadowColor: Colors.grey.shade300,
        curveSize: 90,
        items: const [
          TabItem(icon: Icons.link_rounded, title: 'Links'),
          TabItem(icon: Icons.menu_book_rounded, title: 'Courses'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: FontAwesomeIcons.bullhorn, title: 'Campaign'),
          TabItem(icon: Icons.person_outline, title: 'Profile'),
        ],
        onTap: (index) {},
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
