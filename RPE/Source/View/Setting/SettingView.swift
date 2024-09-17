
import SwiftUI

struct SettingView: View {
    
    @AppStorage("isText") private var isText: Bool = false
    @Binding var showModal: Bool
    
    var body: some View {
        NavigationView {
            HStack {
                Text("Weight :")
                
                Toggle(isOn: $isText) {
                    Text(isText ? "Lb" : "Kg")
                        .foregroundColor(isText ? .blue : .primary)
                }
            }
            .navigationBarTitle("Setting", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                showModal.toggle()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            })
        }
    }
}

#Preview {
    SettingView(showModal: .constant(true))
}
