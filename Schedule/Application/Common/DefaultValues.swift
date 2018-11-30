import Foundation

public class DefaultValues {
    
    public static func defaultStringIfNil(_ value: String?, defaultValue: String = "") -> String {
        return defaultIfNil(value, defaultValue: defaultValue)
    }
    
    public static func defaultIntIfNil(_ value: Int?, defaultValue: Int = 0) -> Int {
        return defaultIfNil(value, defaultValue: defaultValue)
    }
    
    public static func defaultFloatIfNil(_ value: Float?, defaultValue: Float = 0.0) -> Float {
        return defaultIfNil(value, defaultValue: defaultValue)
    }
    
    public static func defaultDateIfNil(_ value: Date?, defaultValue: Date = Date()) -> Date {
        return defaultIfNil(value, defaultValue: defaultValue)
    }
    
    public static func defaultBoolIfNil(_ value: Bool?, defaultValue: Bool = false) -> Bool {
        return defaultIfNil(value, defaultValue: defaultValue)
    }
    
    public static func defaultDataIfNil(_ value: Data?, defaultValue: Data = Data()) -> Data {
        return defaultIfNil(value, defaultValue: defaultValue)
    }
    
    public static func defaultIfNil<T>(_ value: T?, defaultValue: T) -> T {
        if value == nil {
            return defaultValue
        }
        return value!
    }
}
