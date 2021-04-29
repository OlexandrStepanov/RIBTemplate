// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// Are you sure?
  internal static let generalAreYouSureText = L10n.tr("Localizable", "general_areYouSure_text")
  /// Back
  internal static let generalBackButton = L10n.tr("Localizable", "general_back_button")
  /// Cancel
  internal static let generalCancelButton = L10n.tr("Localizable", "general_cancel_button")
  /// Done
  internal static let generalDoneButton = L10n.tr("Localizable", "general_done_button")
  /// Sorry, there's been an error
  internal static let generalErrorTitle = L10n.tr("Localizable", "general_error_title")
  /// No
  internal static let generalNoButton = L10n.tr("Localizable", "general_no_button")
  /// Ok
  internal static let generalOkButton = L10n.tr("Localizable", "general_ok_button")
  /// Operation has been canceled
  internal static let generalOperationCancelled = L10n.tr("Localizable", "general_operation_cancelled")
  /// Try again
  internal static let generalTryAgainButton = L10n.tr("Localizable", "general_tryAgain_button")
  /// Yes
  internal static let generalYesButton = L10n.tr("Localizable", "general_yes_button")
  /// Sorry, authorization failed. Please logout and login again.
  internal static let networkErrorAuthorizationFailed = L10n.tr("Localizable", "network_error_authorization_failed")
  /// Sorry, something went wrong. Please try again later.
  internal static let networkErrorGeneral = L10n.tr("Localizable", "network_error_general")
  /// Uh-oh. No internet connection.
  internal static let networkErrorNoConnection = L10n.tr("Localizable", "network_error_no_connection")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
