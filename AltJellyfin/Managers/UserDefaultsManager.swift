//
//  UserDefaultsManager.swift
//  AltJellyfin
//
//  Created by Aleksey Mironov on 18.06.2024.
//

import Foundation

struct UserDefaultsManager {
    enum Key: String {
        case accessToken // String
        case user // String
        case password // String
      
        var keyType: Any.Type {
            Int.self
        }
    }
}

// MARK: - methods
extension UserDefaultsManager {
    static func getValueForKey(_ key: Key) -> Any? {
        UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    static func setValueForKey(_ key: Key, value: Any?) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func saveCodableObject<T: Codable>(_ data: T?, forKey defaultName: Key) {
        let encoded = try? JSONEncoder().encode(data)
        
        UserDefaults.standard.set(encoded, forKey: defaultName.rawValue)
    }
    
    static func fetchCodableObject<T: Codable>(dataType: T.Type, key: Key) -> T? {
        guard let userDefaultData = UserDefaults.standard.data(forKey: key.rawValue) else {
            return nil
        }
        
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
}
