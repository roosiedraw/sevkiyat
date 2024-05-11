import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRange extends StatefulWidget {
  DateRange({Key? key}) : super(key: key);

  @override
  State<DateRange> createState() => _DateRangeState();
}

class _DateRangeState extends State<DateRange> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2021, 11, 5),
    end: DateTime(2030, 12, 10),
  );
  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    return Scaffold(
      body: Container(
          child: Column(children: [
        const Text(
          'Date Range',
          style: TextStyle(fontSize: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: ElevatedButton(
                child: Text(
                  '${start.year}/${start.month}/${start.day}',
                ),
                onPressed: pickDateRange,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: ElevatedButton(
                child: Text(
                  '${end.year}/${end.month}/${end.day}',
                ),
                onPressed: pickDateRange,
              ),
            ),
          ],
        )
      ])),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      currentDate: DateTime.now(),
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2019),
      lastDate: DateTime(2023),
    );
    setState(() {
      dateRange = newDateRange ?? dateRange;

      // if (newDateRange == null) return;
      // setState(() => dateRange = newDateRange);
    });
  }
}
