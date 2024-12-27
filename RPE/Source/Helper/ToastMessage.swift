//
//  ToastMessage.swift
//  RPE
//
//  Created by 이상도 on 12/27/24.
//

import SwiftUI

struct ToastMessage: View {
    var body: some View {
        Button {
            Toast.shared.present(
                text: "Record update completed",
                symbol: "complete",
                isUserInteractionEnabled: true,
                timing: .short
            )
        } label: {
            Text("ToastMessage")
        }
    }
}

#Preview {
    ToastMessage()
}
