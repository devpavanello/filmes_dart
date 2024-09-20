import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_credits_model.dart';

class CreditHorizontalItem extends StatelessWidget {
  const CreditHorizontalItem({
    super.key,
    required this.cast,
  });

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 140,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: cast.profilePath != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('$imageUrl${cast.profilePath}'),
                  )
                : null,
            color: Colors.grey[300], // Cor de fundo caso não tenha imagem
          ),
        ),
        Positioned(
          left: 15,
          right: 15,
          bottom: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cast.name ?? "No Name",
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                cast.character ?? "Unknown Character",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    cast.popularity?.toStringAsFixed(1) ?? "0.0",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
