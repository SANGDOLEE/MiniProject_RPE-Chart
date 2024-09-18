
import SwiftUI

struct MyRecordView: View {
    
    @AppStorage("isText") private var isText: Bool = false
    
    @State private var showAlert = false
    @State var isModalSheetShown: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGray).opacity(0.3)
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
                            NavigationLink(destination: UpdateRecordView(viewModel: MySBDViewModel())) {
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
                .navigationBarItems(trailing:
                                        Button(action: {
                    isModalSheetShown.toggle()
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(.black)
                }
                    .sheet(isPresented: $isModalSheetShown) {
                        SettingView(showModal: $isModalSheetShown)
                    }
                )
            }
        }
    }
}

#Preview {
    MyRecordView()
}
