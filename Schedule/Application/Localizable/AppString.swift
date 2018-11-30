import Foundation

public class AppStrings {
    
    static let appVersionNumber         = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    static let appVersionName           = localized("app_version.name")
    public static let app_version       = "\(appVersionName) \(String(describing: appVersionNumber))"
    
    public static let app_name              = localized("app_name")
    public static let alert_title_error     = localized("alert.title_error")
    public static let alert_action_ok       = localized("alert.action_ok")
    public static let region_identifier     = localized("region_identifier")
    public static let date_format           = localized("date_format")
    public static let date_format_day_month = localized("date_format_day_month")
    public static let date_months_abbr  = ["",
                                           localized("date.months_abbr.january"),
                                           localized("date.months_abbr.february"),
                                           localized("date.months_abbr.march"),
                                           localized("date.months_abbr.april"),
                                           localized("date.months_abbr.may"),
                                           localized("date.months_abbr.june"),
                                           localized("date.months_abbr.July"),
                                           localized("date.months_abbr.august"),
                                           localized("date.months_abbr.september"),
                                           localized("date.months_abbr.october"),
                                           localized("date.months_abbr.november"),
                                           localized("date.months_abbr.december")]
    
    // MARK: Login Validation texts
    public static let swift_validator_email_empty_message    = localized("swift_validator.email_empty_message")
    public static let swift_validator_invalid_email_message  = localized("swift_validator.email_invalid_message")
    public static let swfit_validator_password_empty_message = localized("swift_validator.password_empty_message")
    
    public static let login_validation_unauthorized_message = localized("login_validation.unauthorized_message")
    public static let login_validation_offline_message      = localized("login_validation.offline_message")
    public static let login_validation_unknown_error        = localized("login_validation.unknown_error")
    public static let login_sync_error_message              = localized("login_sync.error_message")
    
    // MARK: Login View Controller texts
    public static let login_view_controller_email_text_field_placeholder    = localized("login_view_controller.email_text_field_placeholder")
    public static let login_view_controller_password_field_placeholder      = localized("login_view_controller.password_field_placeholder")
    public static let login_view_controller_forgot_password_field_label     = localized("login_view_controller.forgot_password_field_label")
    public static let login_view_controller_register_label                  = localized("login_view_controller.register_label")
    public static let login_view_controller_slogan_field_label              = localized("login_view_controller.slogan_field_label")
    public static let login_view_controller_navbar_title                    = localized("login_view_controller.navbar_title")
    public static let login_view_controller_button_title                    = localized("login_view_controller_button_title")
    public static let invalid_email                                         = localized("invalid_email")
    
    // MARK: Generics Validation
    public static let required_field = localized("required_field")
    
    public static func getLocalizedString(value: Any) -> String {
        if let value = value as? String {
            return localized(value)
        }
        return String(describing: value)
    }
    
    public static func localized(_ value: String) -> String {
        return NSLocalizedString(value, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
}
