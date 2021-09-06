part of 'pages.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  ScrollController comingSoonController;
  List<Movie> findMovie = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    init();
    comingSoonController = new PageController();
  }

  Future init() async {
    final findMovie = await MovieRepository.searchMovies(query);

    setState(() => this.findMovie = findMovie);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 35),
        height: MediaQuery.of(context).size.height * 2 - 100,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          // note: Membuat HEADER
          Container(
              padding:
                  EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
              child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                if (userState is UserLoaded) {
                  if (imageFileToUpload != null) {
                    uploadImage(imageFileToUpload).then((downloadURL) {
                      imageFileToUpload = null;
                      context.bloc<UserBloc>().add(UpdateData(
                          profileImage: downloadURL)); //Update Data User
                    });
                  }

                  return Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width -
                                2 * defaultMargin -
                                50 -
                                12 -
                                16,
                            child: Text(
                              "Hello, ${userState.user.name}",
                              style: boldTextFont.copyWith(fontSize: 18),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Text(
                            "Book your favorite movie",
                            style: greyTextFont,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          )
                        ],
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToProfilePage());
                        },
                        child: Container(
                            // padding: EdgeInsets.all(5),

                            child: Stack(
                          children: <Widget>[
                            SpinKitFadingCircle(
                              color: accentColor2,
                              size: 50,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: (userState.user.profilePicture ==
                                              ''
                                          ? AssetImage("assets/user_pic.png")
                                          : NetworkImage(
                                              userState.user.profilePicture)),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        )),
                      ),
                    ],
                  );
                } else {
                  return SpinKitFadingCircle(
                    color: accentColor2,
                    size: 50,
                  );
                }
              })),

          //! Search Movie
          SearchWidget(
              text: query, onChanged: searchService, hintText: 'Search Movie'),

          // note: TITLE

          (query.isNotEmpty)
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: findMovie.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final myMovie = findMovie[index];
                        print('Disini.. $buildFindMovies(myMovie)');
                        return buildFindMovies(myMovie, index);
                      }))
              : Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
                  child: Text("Trending Now",
                      style: blackTextFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
          SizedBox(
            height: 180,
            child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies.sublist(0, 6);

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (_, index) => Container(
                          margin: EdgeInsets.only(
                              left: (index == 0) ? defaultMargin : 0,
                              right: (index == movies.length - 1)
                                  ? defaultMargin
                                  : 16),
                          child: MovieCard(
                            movies[index],
                            onTap: () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToMovieDetailPage(movies[index]));
                            },
                          ),
                        ));
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            }),
          ),

          // note: BROWSE MOVIE
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
            child: Text(
              "Your Genre",
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: SingleChildScrollView(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              userState.user.selectedGenres.length, (index) {
                            // BrowseButton(userState.user.selectedGenres[index])

                            final genre = userState.user.selectedGenres[index];

                            return _itemCategoryWidget(i: index, title: genre);
                          })),
                    ));
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            },
          ),

          // note: COMING SOON
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
            child: Text("Coming Soon",
                style: blackTextFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold)),
          ),

          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: comingSoonController,
                    children: [
                      ListComingSoon(context: context),
                      ListComingSoonNext()
                    ],
                  ),
                ),
               
              ],
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new IconButton(
                
                  icon: new Icon(Icons.navigate_before, size: 35,),
                  onPressed: () {
                    //c.animateTo(MediaQuery.of(context).size.width, duration: new Duration(seconds: 1), curve: Curves.easeIn);
                    comingSoonController.jumpTo(0.0);
                  }),
              new Container(
                width: 15.0,
              ),
              new IconButton(
                  icon: new Icon(Icons.navigate_next, size: 35,),
                  onPressed: () {
                    comingSoonController.animateTo(
                        MediaQuery.of(context).size.width,
                        duration: new Duration(seconds: 1),
                        curve: Curves.easeIn);
                  }),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 10)
          // ListComingSoonNext()
        ]),
      ),
    );
  }

  Future searchService(String query) async {
    final findMovie = await MovieRepository.searchMovies(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.findMovie = findMovie;
    });
  }

  Widget buildFindMovies(Movie movie, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage(imageBaseURL + "w92" + movie.backdropPath),
              )),
          title: Text(movie.title, style: blackTextFont.copyWith(fontSize: 16)),
          subtitle: Text(movie.voteAverage.toString(),
              style: greyTextFont.copyWith(fontSize: 12)),
          onTap: () => context
              .bloc<PageBloc>()
              .add(GoToMovieDetailPage(findMovie[index]))),
    );
  }

  _itemCategoryWidget({int i, String title}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: (i == 0) ? whiteColor : mainColor,
          border: (i != 0) ? Border.all(color: whiteColor) : null),
      child: Text(
        title,
        style: (i == 0) ? blackTextFont : whiteTextFont,
      ),
    );
  }
}
