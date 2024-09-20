import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart'; // Certifique-se de que o modelo Movie está definido corretamente
import 'package:movie_app/pages/movie_detail/movie_detail_page.dart'; // Página de detalhes do filme
import 'package:movie_app/pages/now_playing/widgets/now_playing_movie.dart'; // Widget para exibir o filme em cartaz
import 'package:movie_app/services/api_services.dart'; // Serviço de API

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  ApiServices apiServices = ApiServices();
  late Future<Result> moviesFuture;

  @override
  void initState() {
    moviesFuture =
        apiServices.getNowPlayingMovies(); // Busca os filmes em cartaz
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes em Cartaz'),
      ),
      body: FutureBuilder<Result>(
        future: moviesFuture,
        builder: (context, snapshot) {
          // Exibe um indicador de progresso enquanto os dados estão sendo carregados
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Exibe uma mensagem de erro, se houver erro na requisição
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          // Se os dados foram carregados corretamente
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.movies.length, // Quantidade de filmes
              itemBuilder: (context, index) {
                // Cada item da lista será clicável (GestureDetector)
                return GestureDetector(
                  onTap: () {
                    // Ao clicar, navega para a página de detalhes do filme com o ID correto
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                          movieId: snapshot.data!.movies[index]
                              .id, // Passa o movieId para a página de detalhes
                        ),
                      ),
                    );
                  },
                  child: NowPlayingMovie(
                      movie: snapshot
                          .data!.movies[index]), // Exibe o filme na lista
                );
              },
            );
          }
          // Se não houver dados
          return const Center(child: Text('Nenhum dado encontrado'));
        },
      ),
    );
  }
}
