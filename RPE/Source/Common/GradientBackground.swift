//
//  GradientBackground.swift
//  RPE
//
//  Created by 이상도 on 12/26/24.
//

import SwiftUI

// 메인 배경 컬러
extension View {
    func applyGradientBackground() -> some View {
        self.background(
            LinearGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop(color: Color(hex: "2F4753"), location: 0.1),
                    Gradient.Stop(color: Color(hex: "0B001F"), location: 0.4),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}
