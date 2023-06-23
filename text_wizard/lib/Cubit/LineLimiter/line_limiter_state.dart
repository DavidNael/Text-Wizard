
abstract class LineLimiterState {}

class LineLimiterInitialState extends LineLimiterState {}

class LineLimiterOptionChange extends LineLimiterState {}

class LineLimiterGeneratingText extends LineLimiterState {}

class LineLimiterGeneratedText extends LineLimiterState {}
