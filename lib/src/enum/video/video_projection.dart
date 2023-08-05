enum VideoProjection {
  rectangular,
  threeSixty;

  static VideoProjection? fromString(String string) => switch (string) {
        "rectangular" => rectangular,
        "360" => threeSixty,
        _ => null,
      };
}
