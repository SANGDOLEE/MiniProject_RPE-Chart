//
//  TabView.swift
//  RPE
//
//  Created by 이상도 on 9/17/24.
//

import SwiftUI

struct TabViewManagement: View {
    
    @StateObject private var viewModel = MySBDViewModel() // 뷰 모델 생성
    
    var body: some View {
        TabView {
            MainView(viewModel: viewModel) // 뷰 모델 전달
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                }
            
            MyRecordView() // 뷰 모델 전달
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}


#Preview {
    TabViewManagement()
}
