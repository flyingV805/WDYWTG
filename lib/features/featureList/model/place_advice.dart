class PlaceAdvice {

  final String adviceTitle;
  final String adviceBody;

  PlaceAdvice({
    required this.adviceTitle,
    required this.adviceBody
  });

  PlaceAdvice.exampleAdvice() : this(
    adviceTitle: 'Pack an Umbrella!',
    adviceBody: 'An umbrella can always be useful! Even in hot sunny weather you can take shelter from the heat!'
  );

}