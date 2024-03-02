import 'package:flutter/material.dart';
import 'package:plantsility_app/models/plant.dart';

import 'package:plantsility_app/services/database.dart';

import 'package:plantsility_app/widgets/info_card/info_card.dart';


class EncyclopediaScreen extends StatefulWidget {
  const EncyclopediaScreen({super.key});

  @override
  State<EncyclopediaScreen> createState() => _EncyclopediaScreenState();
}


class _EncyclopediaScreenState extends State<EncyclopediaScreen> {

  final List<bool> categories = [true, false, false, false, false];
  final List<Widget> categoryNames = const [
    Text("All"),
    Text("Indoor"),
    Text("Outdoor"),
    Text("Exotic"),
    Text("Recommend"),
  ];

  String keyword = "";
  int selectedCategory = 0;
  // TODO: make more efficient structure
  Map<String, List> plants = {};

  Map<String, List> get plantsEmpty {
    return {
      "All": [],
      "Indoor": [],
      "Outdoor": [],
      "Exotic": [],
      "Recommend": []
    };
  }

  Map<String, List> _setPlantByCategory(List<PlantModel>? data) {
    plants = plantsEmpty;
    if (data != null) {
      plants["All"] = data;
      for (PlantModel plant in data) {
        plants[plant.category]!.add(plant);
      }
    }
    return plants;
  }

  // TODO: improve category changing and cards display mechanisms
  // TODO: bug here when changing category or keyword if there was card on screen on next screen will be exact that card
  List<InformationCard> _getPlantsOfCategory(int category){
    List<String> categories = ["All", "Indoor", "Outdoor", "Exotic", "Recommend"];
    // debugPrint(plants.toString());
    List <InformationCard> infoCards = [];
    for (PlantModel plant in plants[categories[category]]!){
      if (plant.name.contains(keyword)) {
        infoCards.add(InformationCard(obj: plant,));
      }
    }

    return infoCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Plantsility",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 226, 227, 228),
            height: 1,
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: SearchBar(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 248, 248, 250)),
              leading: const Icon(Icons.search),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 23)),
              side: MaterialStateProperty.all(const BorderSide(color: Color.fromARGB(255, 226, 227, 228))),
              hintText: "Search",
              textStyle: MaterialStateProperty.all(const TextStyle(color: Color.fromARGB(255, 104, 103, 119))),
              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
              },
            )
          ),

          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0; i < categories.length; i++) {
                            categories[i] = i == index;
                          }
                          selectedCategory = index;
                        });
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      selectedColor: Colors.white,
                      fillColor: const Color.fromARGB(255, 44, 94, 70),
                      color: Colors.black,
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 120.0,
                      ),
                      isSelected: categories,
                      children: categoryNames
                  ),
                ],
              ),
            ),
          ),

          const Padding(padding: EdgeInsets.only(bottom: 25)),

          Expanded(
            child: StreamBuilder(
              initialData: null,
              stream: DatabaseService().plants,
              builder: (context, snapshot) {
                plants = _setPlantByCategory(snapshot.data);

                return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 26,
                    childAspectRatio: (175 / 275),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  children: _getPlantsOfCategory(selectedCategory),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

