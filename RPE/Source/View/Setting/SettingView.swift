
import SwiftUI

struct SettingView: View {
    
    @AppStorage("isText") private var isText: Bool = false
    
    @State private var showAlert = false
    
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
