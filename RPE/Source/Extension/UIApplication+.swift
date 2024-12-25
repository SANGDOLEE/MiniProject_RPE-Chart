//
//  UIApplication+.swift
//  RPE
//
//  Created by 이상도 on 12/25/24.
//

import SwiftUI

extension UIApplication {
    
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
