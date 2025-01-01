//
//  NavigationRouter.swift
//  RPE
//
//  Created by 이상도 on 12/29/24.
//

import SwiftUI

enum PathType: Hashable {
    // 온보딩 case
    case onboardingView
    case onboardingUserInformation
}

extension PathType {
    @ViewBuilder
    func NavigatingView() -> some View {
        switch self {
            // 온보딩 case
        case .onboardingView:
            OnboardingView(isPresented: .constant(true))
                .navigationBarBackButtonHidden()
        case .onboardingUserInformation:
            UserInformationView(isPresented: .constant(true))
                .navigationBarBackButtonHidden()
        }
    }
}

@Observable
class NavigationRouter {
    var path: [PathType]
    init(
        path: [PathType] = []
    ){
        self.path = path
    }
}

extension NavigationRouter {
    func push(to pathType: PathType) {
        path.append(pathType)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func pop(to pathType: PathType) {
        guard let lastIndex = path.lastIndex(of: pathType) else { return }
        path.removeLast(path.count - (lastIndex + 1))
    }
}
