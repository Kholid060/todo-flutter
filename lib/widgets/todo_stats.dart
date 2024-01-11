import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todo/main.dart';


const double containerHeight = 365;
const double minContainerHeight = 220;

class TodoStats extends SliverPersistentHeaderDelegate {
  final String title;
  final int totalItems;
  final int completedCount;

  double height = containerHeight;

  TodoStats({
    required this.title,
    required this.totalItems,
    required this.completedCount,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scale = 1 - max(0, shrinkOffset) / maxExtent;
    final offset = Offset(0, -((1 - scale) * minExtent));
    final double opacity = min(1, max(1 - shrinkOffset / (maxExtent * 0.3), 0));
    
    final isReduced = scale <= 0.8;
    
    final progress = (completedCount / totalItems).defaultIfNaN(0);

    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                top: 15,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 250, 253, 252),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: !isReduced,
                      child: Transform.translate(
                        offset: offset,
                        child: Opacity(
                          opacity: opacity,
                          child: Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600))
                        )
                      )
                    ),
                    Visibility(
                      visible: !isReduced,
                      child: Transform.translate(
                        offset: offset,
                        child: Opacity(
                          opacity: opacity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Text("TODAY'S PROGRESS"),
                                  const Spacer(),
                                  Text(
                                    '${(progress * 100).floor().toString()}%', 
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  color: Colors.cyan.shade500,
                                  backgroundColor: Colors.white10,
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
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
                                  (totalItems - completedCount).toString(),
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
                                ),
                                const Text('In progress '),
                              ],
                            )
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
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
                                  completedCount.toString(),
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
                                ),
                                const Text('Completed'),
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

  @override
  double get minExtent => minContainerHeight;

  @override
  double get maxExtent => containerHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}