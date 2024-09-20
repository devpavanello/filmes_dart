import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_credits_model.dart';
import 'package:movie_app/pages/movie_detail/widgets/credit_horizontal_item.dart';

class CreditsHorizontalList extends StatelessWidget {
  final List<Cast> cast;

  const CreditsHorizontalList({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemBuilder: (context, index) {
          final casts = cast[index];

          return CreditHorizontalItem(cast: casts);
        },
      ),
    );
  }
}
