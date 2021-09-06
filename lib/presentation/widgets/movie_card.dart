part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie; //parameter
  final Function onTap;

  MovieCard(this.movie, {this.onTap}); //onTap opsional dgn tambahan {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        height: 180,
        width: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(imageBaseURL + "w500" + movie.backdropPath),
                fit: BoxFit.cover)),
        child: Container(
          height: 180,
          width: 220,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.61),
                  Colors.black.withOpacity(0)
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: whiteTextFont.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                movie.releaseDate,
                style: whiteTextFont.copyWith(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
               Text(
                movie.overview,
                style: whiteTextFont.copyWith(fontSize: 10),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              // RatingStars(
              //   voteAverage: movie.voteAverage,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
