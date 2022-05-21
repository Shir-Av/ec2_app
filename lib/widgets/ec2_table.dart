import 'package:ec2_app/models/ec2_data.dart';
import 'package:flutter/material.dart';

class Ec2Table extends StatefulWidget {
  List<Ec2Data> ec2list;
  Ec2Table({
    Key? key,
    required this.ec2list,
  }) : super(key: key);

  @override
  State<Ec2Table> createState() => _Ec2TableState();
}

class _Ec2TableState extends State<Ec2Table> {
  bool _sortAsc = true;
  int _sortColumnIndex = 0;

  void _updateSortState(int columnIndex, bool sortAscending) {
    setState(() {
      if (columnIndex == _sortColumnIndex) {
        _sortAsc = sortAscending;
      } else {
        _sortColumnIndex = columnIndex;
      }
      widget.ec2list.sort((a, b) => a.name.compareTo(b.name));
      if (!_sortAsc) {
        widget.ec2list = widget.ec2list.reversed.toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAsc,
          headingTextStyle: const TextStyle(
            fontSize: 20,
          ),
          columns: [
            DataColumn(
              label: const Text('name'),
              onSort: (int columnIndex, bool sortAscending) {
                _updateSortState(columnIndex, sortAscending);
              },
            ),
            DataColumn(
              label: const Text('id'),
              onSort: (int columnIndex, bool sortAscending) {
                _updateSortState(columnIndex, sortAscending);
              },
            ),
            DataColumn(
              label: const Text('state'),
              onSort: (int columnIndex, bool sortAscending) {
                _updateSortState(columnIndex, sortAscending);
              },
            ),
            DataColumn(
              label: const Text('az'),
              onSort: (int columnIndex, bool sortAscending) {
                _updateSortState(columnIndex, sortAscending);
              },
            ),
            DataColumn(
              label: const Text('publicIP'),
              onSort: (int columnIndex, bool sortAscending) {
                _updateSortState(columnIndex, sortAscending);
              },
            ),
            DataColumn(
              label: const Text('privateIP'),
              onSort: (int columnIndex, bool sortAscending) {
                _updateSortState(columnIndex, sortAscending);
              },
            ),
          ],
          rows: widget.ec2list
              .map(
                (ec2) => DataRow(
                  cells: [
                    DataCell(Text(ec2.name)),
                    DataCell(Text(ec2.id)),
                    DataCell(Text(ec2.state)),
                    DataCell(Text(ec2.az)),
                    DataCell(Text(ec2.publicIP)),
                    DataCell(Text(ec2.privateIP)),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}