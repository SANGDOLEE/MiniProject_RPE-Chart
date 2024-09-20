import SwiftUI

// MARK: - ColorPicker
class ColorPickers {
    
    // ColorPicker 1
    class TypeColorData {
        
        private let COLOR_KEY = "TYPECOLOR"
        private let userDefaults = UserDefaults.standard
        
        func saveColor(color: Color) {
            let color = UIColor(color).cgColor
            
            if let components = color.components {
                userDefaults.set(components, forKey: COLOR_KEY)
            }
        }
        
        func loadColor() -> Color {
            guard let colorComponents = userDefaults.object(forKey: COLOR_KEY) as? [CGFloat] else {
                return Color.white /// 처음 기본색상 BLUE
            }
            
            let color = Color(.sRGB,
                              red: colorComponents[0],
                              green: colorComponents[1],
                              blue: colorComponents[2],
                              opacity: colorComponents[3]
            )
            return color
        }
    }
    
    // ColorPicker 2
    class TextColorData {
        
        private let COLOR_KEY = "TEXTCOLOR"
        private let userDefaults = UserDefaults.standard
        
        func saveColor(color: Color) {
            let color = UIColor(color).cgColor
            
            if let components = color.components {
                userDefaults.set(components, forKey: COLOR_KEY)
            }
        }
        
        func loadColor() -> Color {
            guard let colorComponents = userDefaults.object(forKey: COLOR_KEY) as? [CGFloat] else {
                return Color.black ///처음 기본색상 Black
            }
            
            let color = Color(.sRGB,
                              red: colorComponents[0],
                              green: colorComponents[1],
                              blue: colorComponents[2],
                              opacity: colorComponents[3]
            )
            return color
        }
    }
}
