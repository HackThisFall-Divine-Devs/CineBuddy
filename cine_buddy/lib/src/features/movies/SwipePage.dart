import 'package:flutter/material.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

class SwipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Matchmaking",
          style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18.0),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SwipingCardDeck(
          cardDeck: <Card>[
            Card(
              color: Colors.red,
              child: const SizedBox(height: 300, width: 200),
            ),
            Card(
              color: Colors.green,
              child: const SizedBox(height: 300, width: 200),
            ),
          ],
          onDeckEmpty: () => debugPrint("Card deck empty"),
          onLeftSwipe: (Card card) => debugPrint("Swiped left!"),
          onRightSwipe: (Card card) => debugPrint("Swiped right!"),
          swipeThreshold: MediaQuery.of(context).size.width / 4,
          minimumVelocity: 1000,
          cardWidth: 200,
          rotationFactor: 0.8 / 3.14,
          swipeAnimationDuration: const Duration(milliseconds: 500),
          disableDragging: false,
        ),
      ),
    );
  }
}
