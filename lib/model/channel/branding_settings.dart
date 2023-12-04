class ChannelBrandingSettings {
  const ChannelBrandingSettings({
    this.title,
    this.description,
    this.keywords,
    this.trackingAnalyticsAccountId,
    this.moderateComments,
    this.unsubscribedTrailer,
    this.defaultLanguage,
    this.country,
  });
  factory ChannelBrandingSettings.fromJsonData(Map<String, dynamic> data) {
    final channel = data["channel"] as Map<String, dynamic>;
    final title = channel["title"];
    final description = channel["description"];
    final keywords = _parseKeywords(channel["keywords"] ?? '');
    final trackingAnalyticsAccountId = channel["trackingAnalyticsAccountId"];
    final moderateComments = channel["moderateComments"];
    final unsubscribedTrailer = channel["unsubscribedTrailer"];
    final defaultLanguage = channel["defaultLanguage"];
    final country = channel["country"];
    return ChannelBrandingSettings(
      title: title,
      description: description,
      keywords: keywords,
      trackingAnalyticsAccountId: trackingAnalyticsAccountId,
      moderateComments: moderateComments,
      unsubscribedTrailer: unsubscribedTrailer,
      defaultLanguage: defaultLanguage,
      country: country,
    );
  }

  /// The channel's title. The title has a maximum length of 30 characters.
  final String? title;

  /// The channel description, which appears in the channel information box on
  /// your channel page. The property's value has a maximum length of 1000
  /// characters.
  final String? description;

  /// Keywords associated with your channel. The value is a space-separated list
  /// of strings. Channel keywords might be truncated if they exceed the maximum
  /// allowed length of 500 characters or if they contained unescaped quotation
  /// marks ("). Note that the 500 character limit is not a per-keyword limit
  /// but rather a limit on the total length of all keywords.
  final List<String>? keywords;

  /// The ID for a [Google Analytics
  /// account](http://www.google.com/analytics/index.html) that you want to use
  /// to track and measure traffic to your channel.
  ///
  /// `string`
  final String? trackingAnalyticsAccountId;

  /// This setting determines whether user-submitted comments left on the
  /// channel page need to be approved by the channel owner to be publicly
  /// visible. The default value is `false`.
  final bool? moderateComments;

  /// The video that should play in the featured video module in the channel
  /// page's browse view for unsubscribed viewers. Subscribed viewers may see a
  /// different video that highlights more recent channel activity.
  ///
  /// If specified, the property's value must be the YouTube video ID of a
  /// public or unlisted video that is owned by the channel owner.
  final String? unsubscribedTrailer;

  /// The language of the text in the `channel` resource's `snippet.title` and
  /// `snippet.description` properties.
  final String? defaultLanguage;

  /// The country with which the channel is associated. Update this property to
  /// set the value of the `snippet.country` property.
  final String? country;

  static List<String> _parseKeywords(String keywordsString) {
    // Split the input string by space character and remove any empty strings
    List<String> keywordsList = keywordsString
        .split(' ')
        .where((keyword) => keyword.isNotEmpty)
        .toList();

    // Join adjacent strings enclosed in double quotes (") and add them as a
    //  single keyword
    List<String> finalKeywords = [];
    String currentKeyword = '';

    for (var keyword in keywordsList) {
      if (keyword.startsWith('"') && keyword.endsWith('"')) {
        // If the keyword is enclosed in double quotes, add it as a single
        //  keyword
        finalKeywords.add(keyword.substring(1, keyword.length - 1));
      } else if (keyword.startsWith('"')) {
        // If the keyword starts with double quotes, start building the complete
        //  keyword
        currentKeyword = keyword.substring(1);
      } else if (keyword.endsWith('"')) {
        // If the keyword ends with double quotes, complete the keyword and add
        //  it to the list
        currentKeyword += ' ' + keyword.substring(0, keyword.length - 1);
        finalKeywords.add(currentKeyword);
        currentKeyword = '';
      } else if (currentKeyword.isNotEmpty) {
        // If inside a quoted keyword, continue building it
        currentKeyword += ' ' + keyword;
      } else {
        // Otherwise, it's a normal keyword, add it to the list
        finalKeywords.add(keyword);
      }
    }

    return finalKeywords;
  }
}
