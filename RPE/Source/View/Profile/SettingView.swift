//
//  SettingView.swift
//  RPE
//
//  Created by 이상도 on 12/30/24.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var isMainTabbarVisible: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        dismiss()
                        isMainTabbarVisible = true
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 24, height: 24)
                            .tint(.white)
                    }
                    Spacer()
                    Text("Setting")
                        .font(.setPretendard(weight: .semiBold, size: 17))
                        .foregroundStyle(.white)
                        .padding(.trailing, 16)
                    Spacer()
                }
                
                
                
                Spacer()
                
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .applyGradientBackground()
        .onAppear {
            isMainTabbarVisible = false
        }
    }
}

#Preview {
    SettingView(isMainTabbarVisible: .constant(true))
}
