import SwiftUI

// MARK: - SettingView ( kg <-> lb )
struct SettingView: View {
    
    @StateObject private var viewModel = IsTextViewModel()
    
    @State var weightToggle = false
    @Binding var isText : Bool
    
    // Binding
    @Binding var showModal: Bool
    init(showModal: Binding<Bool>, isText: Binding<Bool>) {
        _showModal = showModal
        _isText = isText
    }
    
    var body: some View {
        NavigationView{
            
            HStack(){
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                Text("Weight :")
                Toggle(isOn: Binding(
                    get: { viewModel.isText },
                    set: { newValue in
                        viewModel.isText = newValue
                        isText = newValue
                    }
                )) {
                    if viewModel.isText {
                        Text("Lb")
                            .foregroundColor(.blue)
                    } else {
                        Text("Kg")
                        
                    }
                }
                .onChange(of: viewModel.isText) { newValue in
                    // 현재 토글 상태 확인 
                    print("Toggle state changed to \(newValue)")
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .navigationBarTitle("Setting",displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showModal.toggle()
                self.viewModel.saveData()
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(showModal: .constant(true), isText: .constant(false))
    }
}
