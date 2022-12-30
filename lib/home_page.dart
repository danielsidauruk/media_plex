import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homePageRoute';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'MEDIA PLEX',
          style: TextStyle(
            fontFamily: 'Fugaz',
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.bookmark),
          ),
        ],
      ),
      body: buildBody(context),
    );
  }

  SingleChildScrollView buildBody(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: const Text('MEDIA PLEX is a App to provide an information about Movie, Series, and Book around the world.'),
            ),

            const SizedBox(height: 8.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTile((){}, 'Movie', 'assets/images/movie_icon.png'),

                const SizedBox(width: 8.0),

                buildTile((){}, 'Series', 'assets/images/tv_icon.png'),
              ],
            ),

            const SizedBox(height: 8.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTile((){}, 'Book', 'assets/images/book_icon.png'),

                const SizedBox(width: 8.0),

                buildTile((){}, 'Random Useless Fact', 'assets/images/useless_fact.png'),
              ],
            ),

            const SizedBox(height: 8.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTile((){}, 'Random Dog Images', 'assets/images/dog_icon.png'),

                const SizedBox(width: 8.0),

                buildTile((){}, 'Random Useless Fact', 'assets/images/useless_fact.png'),
              ],
            ),

            const SizedBox(height: 8.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTile((){}, 'Random Dog Images', 'assets/images/dog_icon.png'),

                const SizedBox(width: 8.0),

                buildTile((){}, 'Random Useless Fact', 'assets/images/useless_fact.png'),
              ],
            ),
          ],
        )
      ),
    );
  }

  InkWell buildTile(Function() onTap, String title, String path) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(8.0),
        width: 150,
        height: 180,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.blueGrey,
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Image.asset(
              path,
              width: 110,
            )
          ],
        ),
      ),
    );
  }
}
