//
//  SessionManager.swift
//  Horoscope-iOS
//
//  Created by Mananas on 11/11/25.
//

import Foundation

class SessionManager {
    
    private let defaults = UserDefaults.standard
    
    static let FAVORITE_HOROSCOPE_KEY = "FAVORITE_HOROSCOPE"
    
    func setFavorite(sign: String) {
        defaults.set(sign, forKey: SessionManager.FAVORITE_HOROSCOPE_KEY)
    }
    
    func getFavorite() -> String {
        return defaults.string(forKey: SessionManager.FAVORITE_HOROSCOPE_KEY) ?? ""
    }
    
    func isFavorite(sign: String) -> Bool {
        return getFavorite() == sign
    }
}
