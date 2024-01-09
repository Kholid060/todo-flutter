import 'package:flutter/material.dart';

class TodoStats extends StatefulWidget {
  final int totalItems; 
  final int completedCount;

  const TodoStats({ 
    Key? key, 
    required this.completedCount,
    required this.totalItems
  }) : super(key: key);

  @override
  _TodoStatsState createState() => _TodoStatsState();
}

class _TodoStatsState extends State<TodoStats> {
  String greeting = '';

  @override
  void initState() {
    // Greeting
    int hour = DateTime.now().hour;
    if (hour >= 0 && hour <= 12) { greeting = 'Good Morning!'; }
    else if (hour > 12 && hour <= 18) { greeting = 'Good Afternoon!'; }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height * 0.35;

    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: SizedBox(
        height: heightFactor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text("TODAY'S PROGRESS"),
                          const Spacer(),
                          Text(
                            '${((widget.completedCount / widget.totalItems) * 100).floor().toString()}%', 
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white10,
                          value: widget.completedCount / widget.totalItems,
                        )
                      )
                    ],
                  )
                ),
              ),
              SizedBox(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(width: 2, color: Colors.amber.shade400, ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (widget.totalItems - widget.completedCount).toString(),
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
                            ),
                            const Text('In progress '),
                          ],
                        )
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.cyan.shade500,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(width: 2, color: Colors.cyan.shade400, ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.totalItems.toString(),
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
                            ),
                            const Text('Completed'),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}