/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/domain/artist.dart';
import '/infraestructure/presentation/screens/widgets/artist_theme_model.dart';
import '/providers/artist_provider.dart';
import '../../repositories/api_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchFrame(),
    );
  }
}

class SearchFrame extends StatefulWidget {
  const SearchFrame({super.key});

  @override
  State<SearchFrame> createState() => _SearchFrameState();
}

class _SearchFrameState extends State<SearchFrame> {

  TextEditingController _controller = TextEditingController();

  static List<ArtistThemeModel> mainThemeList = [
    ArtistThemeModel("Aquiles Báez"),
    ArtistThemeModel("Aquiles Hernández"),
    ArtistThemeModel("Aquiles Bailo"),
  ];

  List<ArtistThemeModel> displayList = List.from(mainThemeList);

  String inputValue = '';

  void updateList(String value) async {
    inputValue = value;
    if (value.isNotEmpty) {
      List<Artist> newArtists = await getSearchArtists(value);
      setState(() {
        displayList = newArtists.map((artist) => ArtistThemeModel(artist.name)).toList();
      });
    } else {
      setState(() {
        displayList = List.from(mainThemeList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ArtistProvider(),
        )
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: <Color>[
                      Color(0xFF3C127E),
                      Color(0xFF3C127E),
                      Color(0xFF2A154E),
                      Color(0xFF261740),
                      Color(0xFF261740),
                      Color(0xFF2C1553),
                      Color(0xFF3E1283),
                      Color(0xFF3E1283),
                      // Colors.transparent,
                    ],
                  ),
                  // shape: BoxShape.circle,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Buscar artista o tema',
                        style: TextStyle(
                          fontFamily: 'Visby',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.0,
                          color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF372F47),
                            Color(0xFF462F64),
                            Color(0xFF462F64),
                          ],
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          onChanged: (value) => updateList(value),
                          style: TextStyle(
                              fontFamily: 'Visby',
                              fontSize: 18,
                              fontWeight: FontWeight.w300,color: Colors.white,
                          ),
                          controller: _controller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "¿Qué deseas escuchar?",
                            hintStyle: TextStyle(
                              fontFamily: 'visbycf-thin',
                              fontSize: 19,
                              fontWeight: FontWeight.w100,
                              letterSpacing: 1.5,
                              color: Color(0xFFC2C1C5),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.clear();
                                  updateList(_controller.text);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    inputValue.isEmpty
                      ? Container()
                      : Expanded(
                        child: displayList.isEmpty
                          ? Container(
                              padding: EdgeInsets.only(top: 4.0, left: 24.0),
                              child: Text(
                                "Lo sentimos, no se encontraron resultados.",
                                style: TextStyle(
                                  fontFamily: 'visbycf-thin',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 1.5,
                                  color: Color(0xFF0AACBE),
                                ),
                              ),
                            )
                            : ListView.builder(
                                itemCount: displayList.length,
                                itemBuilder: (context, index) => ListTile(
                                  contentPadding: EdgeInsets.only( top: 1.0, bottom: 1.0, left: 25.0),
                                  title: Text(displayList[index].artistName!,
                                    style: TextStyle(
                                      fontFamily: 'visbycf-thin',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 1.5,
                                      color: Colors.white,
                                    ),
                                  )
                                ),
                              ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/