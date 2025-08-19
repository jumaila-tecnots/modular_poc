import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_failure.freezed.dart';

@freezed
class MainFailure with _$MainFailure {
  /// A client-side error, such as a bad request or a network issue.
  const factory MainFailure.clientFailure({required String message}) = _ClientFailure;

  /// A server-side error, such as a 500 or other HTTP issues.
  const factory MainFailure.serverFailure({required String message}) = _ServerFailure;

  /// A custom error with a specific message.
  const factory MainFailure.errorMessage({required String message}) = _ErrorMessage;

  /// Predefined network error message.
  factory MainFailure.networkFailure() =>
      const MainFailure.errorMessage(message: "No Internet connection. Please check your network.");

  /// Predefined server error message.
  factory MainFailure.serverFailureWithMessage() =>
      const MainFailure.serverFailure(message: "Couldn't connect to the server. Please try again later.");

  /// Predefined unexpected error message.
  factory MainFailure.unexpectedFailure() =>
      const MainFailure.errorMessage(message: "An unexpected error occurred.");

  /// Predefined cache failure message.
  factory MainFailure.cacheFailure() =>
      const MainFailure.errorMessage(message: "Cache error occurred.");
}
