import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kraut_rueben/models/recipe.dart';

class RecipePopup extends StatelessWidget {
  final Recipe recipe;
  RecipePopup({Key? key, required this.recipe}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.5;
    double height = MediaQuery.of(context).size.height * 0.75;
    EdgeInsets padding = EdgeInsets.symmetric(
        vertical: 15, horizontal: MediaQuery.of(context).size.width * 0.05);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned.fill(
              child: UnconstrainedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      color: Colors.white.withOpacity(0.4),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                                width: width,
                                constraints: BoxConstraints(maxHeight: height),
                                padding: padding,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        recipe.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 25),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        recipe.content,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.65),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: width - padding.horizontal,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Builder(builder: (context) {
                                            double price = 0;
                                            int calories = 0;
                                            double protein = 0;
                                            double carbohydrates = 0;
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Zutaten:",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: List.generate(
                                                                recipe
                                                                    .ingredients
                                                                    .length,
                                                                (index) {
                                                              final ingredient =
                                                                  recipe.ingredients
                                                                          .keys
                                                                          .toList()[
                                                                      index];
                                                              final amount = recipe
                                                                      .ingredients
                                                                      .values
                                                                      .toList()[
                                                                  index];

                                                              price += ingredient
                                                                      .price *
                                                                  amount;
                                                              calories += ingredient
                                                                      .calories *
                                                                  amount;
                                                              protein += ingredient
                                                                      .protein *
                                                                  amount;
                                                              carbohydrates +=
                                                                  ingredient
                                                                          .carboHydrates *
                                                                      amount;
                                                              return Text(
                                                                  "${ingredient.name}, ${amount} ${ingredient.unit}");
                                                            }),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Informationen:",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  "Kalorien: ${calories.toStringAsFixed(1)} kcal"),
                                                              Text(
                                                                  "Protein: ${protein.toStringAsFixed(1)}g"),
                                                              Text(
                                                                  "Kohlenhydrate: ${carbohydrates.toStringAsFixed(1)}g"),
                                                              Text(
                                                                "Preis: ${price.toStringAsFixed(2)}€",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text("Intoleranzen:",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    Builder(builder: (context) {
                                                      List<String>
                                                          intolerances = [];
                                                      recipe.ingredients
                                                          .forEach(
                                                        (key, value) {
                                                          key.intolerances
                                                              .forEach(
                                                                  (element) {
                                                            intolerances.add(
                                                                element.name);
                                                          });
                                                        },
                                                      );
                                                      return Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children:
                                                              List.generate(
                                                                  intolerances
                                                                      .toSet()
                                                                      .length,
                                                                  (index) {
                                                            return Text(
                                                                "${intolerances.toSet().elementAt(index)}, ");
                                                          }));
                                                    }),
                                                  ],
                                                )
                                              ],
                                            );
                                          }),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )),
                            Container(
                              color: Colors.black.withOpacity(0.2),
                              height: 1,
                              width: width,
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: width,
                                    child: MaterialButton(
                                      onPressed: () => Navigator.pop(context),
                                      splashColor: Colors.transparent,
                                      child: const Text(
                                        "Close",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
