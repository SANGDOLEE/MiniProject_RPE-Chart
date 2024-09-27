
import SwiftUI

struct SettingView: View {
    
    @AppStorage("isText") private var isText: Bool = false
    
    @State private var showAlert = false
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "F3F2F8")
                    .ignoresSafeArea()
                
                VStack {
                    List {
                        Section(header: Text("Update")) {
                            NavigationLink(destination: UpdateRecordView(viewModel: MySBDViewModel())) {
                                HStack {
                                    Text("My BigThree")
                                    Spacer()
                                }
                            }
                        }
                        
                        Section(header: Text("Configuration")) {
                            
                            NavigationLink(destination: WeightUnitView()) {
                                HStack {
                                    Text("Weight Unit Conversion")
                                    Spacer()
                                }
                            }
                            
                            HStack {
                                Text("Display Mode")
                                Spacer()
                                Toggle("Auto Switch Mode", isOn: $isDarkModeEnabled)
                                    .labelsHidden()
                                    .onChange(of: isDarkModeEnabled) { value in
                                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                            windowScene.windows.first?.overrideUserInterfaceStyle = value ? .dark : .light
                                        }
                                    }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
                .navigationBarTitle("Setting", displayMode: .inline)
            }
        }
    }
}

#Preview {
    SettingView()
}
