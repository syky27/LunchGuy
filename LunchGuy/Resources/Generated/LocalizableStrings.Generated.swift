// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Error {
    /// Neočekávaná chyba serveru.
    static let invalidResponse = L10n.tr("Localizable", "error.invalid_response")
    /// Chyba
    static let title = L10n.tr("Localizable", "error.title")
    /// Neznámá chyba, zkuste to znovu.
    static let unknown = L10n.tr("Localizable", "error.unknown")
  }

  enum ExternalApp {
    /// Apple Maps
    static let appleMaps = L10n.tr("Localizable", "external_app.apple_maps")
    /// Google Maps
    static let googleMaps = L10n.tr("Localizable", "external_app.google_maps")
    /// Yelp
    static let yelp = L10n.tr("Localizable", "external_app.yelp")
  }

  enum General {
    /// Zrušit
    static let cancel = L10n.tr("Localizable", "general.cancel")
    /// Ok
    static let ok = L10n.tr("Localizable", "general.ok")
  }

  enum Meal {
    /// Vyberte aplikaci, ve které chcete restauraci otevřít.
    static let openInApp = L10n.tr("Localizable", "meal.open_in_app")
    /// %d Kč
    static func price(_ p1: Int) -> String {
      return L10n.tr("Localizable", "meal.price", p1)
    }
    /// Cena není známa
    static let priceUnknown = L10n.tr("Localizable", "meal.price_unknown")
  }

  enum Restaurants {
    /// Seznam
    static let list = L10n.tr("Localizable", "restaurants.list")
    /// Mapa
    static let map = L10n.tr("Localizable", "restaurants.map")
    /// Restaurace
    static let title = L10n.tr("Localizable", "restaurants.title")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
