import 'package:flutter/material.dart';
import 'package:openin_test/widgets/link_card.dart';
import 'package:openin_test/widgets/stat_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
        body: SafeArea(
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
                                  fontSize: 25, fontWeight: FontWeight.bold),
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
                                primaryYAxis:
                                    const NumericAxis(labelFormat: '{value}'),
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

                            // scrollable cards
                            const SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  // cards placeholder
                                  StatCard(
                                    icon: Icons.ads_click_rounded,
                                    iconColor: Colors.purple,
                                    title: "123",
                                    subtitle: "Today's Clicks",
                                  ),
                                  StatCard(
                                    icon: Icons.location_on,
                                    iconColor: Colors.blue,
                                    title: "Ahmedabad",
                                    subtitle: "Top Location",
                                  ),
                                  StatCard(
                                    icon: Icons.location_city,
                                    iconColor: Colors.red,
                                    title: "Instagram",
                                    subtitle: "Top Source",
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),
                            // view analytics button
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(15),
                                  foregroundColor: Colors.black,
                                  side: const BorderSide(color: Colors.grey),
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
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
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
                                  const SizedBox(
                                    height: 170 * 3,
                                    child: TabBarView(children: [
                                      Column(
                                        children: [
                                          LinkCard(
                                            linkName: "Amazon",
                                            date: '22 July 2023',
                                            linkUrl: "https://www.google.com",
                                            clicks: 123,
                                          ),
                                          LinkCard(
                                            linkName: "Amazon",
                                            date: '22 July 2023',
                                            linkUrl: "https://www.google.com",
                                            clicks: 123,
                                          ),
                                          LinkCard(
                                            linkName: "Amazon",
                                            date: '22 July 2023',
                                            linkUrl: "https://www.google.com",
                                            clicks: 123,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          LinkCard(
                                            linkName: "Amazon",
                                            date: '22 July 2023',
                                            linkUrl: "https://www.google.com",
                                            clicks: 123,
                                          ),
                                          LinkCard(
                                            linkName: "Amazon",
                                            date: '22 July 2023',
                                            linkUrl: "https://www.google.com",
                                            clicks: 123,
                                          ),
                                          LinkCard(
                                            linkName: "Amazon",
                                            date: '22 July 2023',
                                            linkUrl: "https://www.google.com",
                                            clicks: 123,
                                          ),
                                        ],
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
                                  side: const BorderSide(color: Colors.grey),
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
                                  side:
                                      BorderSide(color: Colors.green.shade100),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.chat_bubble_outline_rounded,
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
                                  side: BorderSide(color: Colors.blue.shade100),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.help_outline_rounded,
                                  color: Colors.blue,
                                ),
                                label: const Text("Frequently Asked Questions"),
                              ),
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
