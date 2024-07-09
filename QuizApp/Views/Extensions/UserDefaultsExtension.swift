import Foundation

extension UserDefaults {
    private enum Keys {
        static let username = "username"
    }
    
    var username: String? {
        get {
            return string(forKey: Keys.username)
        }
        set {
            set(newValue, forKey: Keys.username)
        }
    }
}
