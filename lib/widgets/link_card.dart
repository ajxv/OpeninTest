import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

class LinkCard extends StatelessWidget {
  final String linkName;
  final String date;
  final String linkUrl;
  final int clicks;

  const LinkCard({
    super.key,
    required this.linkName,
    required this.date,
    required this.linkUrl,
    required this.clicks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
            leading: Container(
              height: 70,
              width: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset('assets/logos/amazon_logo.png'),
            ),
            title: Text(linkName),
            subtitle: Text(
              date,
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(clicks.toString()),
                const SizedBox(height: 2),
                const Text(
                  "Clicks",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            decoration: DottedDecoration(
              color: Colors.blue.shade300,
              dash: const [2, 2],
              shape: Shape.box,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            child: ListTile(
              tileColor: Colors.blue.shade100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              title: Text(
                linkUrl,
                style: const TextStyle(color: Colors.blue),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.copy_rounded,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
