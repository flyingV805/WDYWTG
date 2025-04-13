class PlaceAdvice {

  final String adviceTitle;
  final String adviceBody;

  PlaceAdvice({
    required this.adviceTitle,
    required this.adviceBody
  });

  PlaceAdvice.exampleAdvice() : this(
    adviceTitle: 'Pack an Umbrella2!',
    adviceBody: 'Pack an Umbrella!Pack an Umbrella!Pack an Umbrella!Pack an Umbrella!Pack an Umbrella!Pack an Umbrella!Pack an Umbrella!Pack an Umbrella!'
  );

}