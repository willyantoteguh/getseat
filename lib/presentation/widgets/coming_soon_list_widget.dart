part of 'widgets.dart';

class ListComingSoon extends StatelessWidget {
  const ListComingSoon({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      // width: double.infinity - 30,
      child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
        if (movieState is MovieLoaded) {
          List<Movie> movies = movieState.movies.sublist(6, 12);

          return GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
              physics: NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (_, index) => Container(
                    child: ComingSoonCard(movies[index]),
                  ));
        } else {
          return SpinKitFadingCircle(
            color: mainColor,
            size: 50,
          );
        }
      }),
    );
  }
}

class ListComingSoonNext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
        if (movieState is MovieLoaded) {
          List<Movie> movies = movieState.movies.sublist(12, 20);

          return GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
              physics: NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (_, index) => Container(
                    child: ComingSoonCard(movies[index]),
                  ));
        } else {
          return SpinKitFadingCircle(
            color: mainColor,
            size: 50,
          );
        }
      }),
    );
  }
}