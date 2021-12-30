import 'package:flutter/material.dart';

class UserFriendsList extends StatefulWidget {
  const UserFriendsList({Key? key}) : super(key: key);

  @override
  _UserFriendsListState createState() => _UserFriendsListState();
}

class _UserFriendsListState extends State<UserFriendsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              width: 300.0,
              height: 300.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(columns: [
                  DataColumn(
                      label: Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.amber[800]),
                  )),
                  DataColumn(
                      label: Text(
                    'Points',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.amber[800]),
                  )),
                ], rows: const [
                  DataRow(cells: [
                    DataCell(Text('Adam Nowak')),
                    DataCell(Text('30')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Dawid Nowy')),
                    DataCell(Text('21')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Andrzej Konieczny')),
                    DataCell(Text('29')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Jacek Piekarz')),
                    DataCell(Text('29')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Tomek Szybki')),
                    DataCell(Text('29')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Tomek Szybki')),
                    DataCell(Text('29')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Tomek Szybki')),
                    DataCell(Text('29')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Tomek Szybki')),
                    DataCell(Text('29')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Tomek Szybki')),
                    DataCell(Text('29')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Tomek Szybki')),
                    DataCell(Text('29')),
                  ]),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
