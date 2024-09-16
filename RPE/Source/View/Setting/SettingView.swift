
import SwiftUI

struct SettingView: View {
    
    @StateObject private var viewModel = IsTextViewModel()
    
    @State var weightToggle = false
    @Binding var isText: Bool
    @Binding var showModal: Bool
    
    init(showModal: Binding<Bool>, isText: Binding<Bool>) {
        _showModal = showModal
        _isText = isText
    }
    
    var body: some View {
        NavigationView{
            HStack {
                Text("Weight :")
                
                Toggle(isOn: $viewModel.isText) {
                    Text(viewModel.isText ? "Lb" : "Kg")
                        .foregroundColor(viewModel.isText ? .blue : .primary)
                }
                .onChange(of: viewModel.isText) { newValue in
                    isText = newValue
                }
            }
            .navigationBarTitle("Setting", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                showModal.toggle()
                viewModel.saveData()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            })
        }
        .onAppear {
            viewModel.isText = UserDefaults.standard.bool(forKey: "isText")
        }
    }
}

#Preview {
    SettingView(showModal: .constant(true), isText: .constant(false))
}
