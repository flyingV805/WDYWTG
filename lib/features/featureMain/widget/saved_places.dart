import 'package:flutter/material.dart';

class SavedPlaces extends StatelessWidget {

  const SavedPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Row(
            children: [
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('item.name'),
                  Text('item.name')
                ],
              ),
            ],
          ),
          children: <Widget>[
            Text('item.description'),
            Text('item.description'),
            Text('item.description'),
            Text('item.description'),
            Text('item.description'),
            Text('item.description'),
            Text('item.description'),
            Text('item.description'),
            Text('item.description'),
            Text('item.description'),
            Text('item.description'),
            Text('item.description'),
          ],
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
    );
  }



}