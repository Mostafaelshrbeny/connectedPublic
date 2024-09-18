import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PopularSearchesCard extends StatelessWidget {
  const PopularSearchesCard({super.key, required this.searchKeyWord});
  final String searchKeyWord;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(156, 163, 175, 1)),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(156, 163, 175, 1),
                borderRadius: BorderRadius.circular(8)),
            child: const Icon(
              Icons.trending_up_rounded,
              color: Colors.white,
            ),
          ),
          const Gap(6),
          Text(
            searchKeyWord,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
