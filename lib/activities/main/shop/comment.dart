import 'package:flutter/material.dart';


class CommentWidget extends StatefulWidget {
  /// Widget that contains user comment and his basic information.
  const CommentWidget({super.key});

  // object with comment information

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {

  // basic variables: username, image, date, commentContent, likes, isLiked.

  // method to work with object that contains comment information

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //TODO: change to image widget
          Container(
            width: 36,
            height: 36,
            color: Colors.amber,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 32 - 36 - 12,
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Jane Cooper",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14,
                    height: 1.5
                  ),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, donec fringilla quam eu faci lisis mollis.",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "24 March 2021",
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    // TODO: change with user defined LikeButton
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.favorite_border),
                          Text("12")
                        ],
                      )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
