//
//  XmarkButton.swift
//  RPE
//
//  Created by 이상도 on 12/26/24.
//

import SwiftUI

// TextField 내 Xmark 버튼
struct XmarkButton: View {
    
    @Binding var text: String // TextField에 바인딩할 값
    
    var body: some View {
        Button {
            text = "" // 버튼 클릭 시 text 초기화
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 23, height: 23)
                .foregroundStyle(.myB9B9B9)
        }
        .opacity(text.count > 0 ? 1 : 0)
        .padding(.trailing)
    }
}

#Preview {
    XmarkButton(text: .constant("160"))
}
