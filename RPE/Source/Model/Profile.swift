//
//  Profile.swift
//  RPE
//
//  Created by 이상도 on 12/30/24.
//

import SwiftUI
import RealmSwift

class Profile: Object {
    // Primary Key
    @Persisted(primaryKey: true) var id: ObjectId
    
    // Properties
    @Persisted var nickname: String? = ""
    @Persisted var image: Data? // 이미지 데이터를 저장 (옵션)
    @Persisted var gender: String = "Male" // "Male" or "Female"
    @Persisted var bodyWeight: Double = 0.0 // 몸무게
    
    // Convenience initializer
    convenience init(nickname: String?, image: Data?, gender: String, bodyWeight: Double) {
        self.init()
        self.nickname = nickname
        self.image = image
        self.gender = gender
        self.bodyWeight = bodyWeight
    }
}
