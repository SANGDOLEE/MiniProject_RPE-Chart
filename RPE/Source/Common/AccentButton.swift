//
//  AccentButton.swift
//  RPE
//
//  Created by 이상도 on 12/26/24.
//

import SwiftUI

// AccentColor 메인 버튼 ( Wide )
struct AccentButton<Content: View>: View {
    
    let label: Content
    let action: () -> Void
    
    init(action: @escaping () -> Void, @ViewBuilder label: () -> Content) {
        self.label = label()
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            label
                .font(.setPretendard(weight: .bold, size: 18))
                .foregroundStyle(.black)
                .cornerRadius(12)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(.myAccentcolor)
        .cornerRadius(12)
    }
}
