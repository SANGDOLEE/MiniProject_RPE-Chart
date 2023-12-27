import SwiftUI


class IsTextViewModel: ObservableObject {
    @Published var isText: Bool
    
    init() {
        self.isText = UserDefaults.standard.bool(forKey: "isText")
    }
    
    func saveData() {
        UserDefaults.standard.setValue(self.isText, forKey: "isText")
    }
}


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
            VStack{
                HStack {
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
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }.navigationBarTitle("Setting",displayMode: .inline)
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
            // Load the saved data when the view appears
            viewModel.isText = UserDefaults.standard.bool(forKey: "isText")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(showModal: .constant(true), isText: .constant(false))
    }
}
