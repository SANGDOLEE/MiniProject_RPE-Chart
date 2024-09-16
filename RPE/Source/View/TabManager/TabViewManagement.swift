//
//  TabView.swift
//  RPE
//
//  Created by 이상도 on 9/17/24.
//

import SwiftUI

struct TabViewManagement: View {
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                }
            
            MyRecordView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

#Preview {
    TabViewManagement()
}
