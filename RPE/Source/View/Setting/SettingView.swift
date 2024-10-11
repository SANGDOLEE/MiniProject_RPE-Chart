
import SwiftUI
import StoreKit

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
                        
                        Section(header: Text("")) {
                            // 리뷰 남기기
                            HStack{
                                Button(action: {
                                    if let scene = UIApplication.shared.connectedScenes
                                        .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                        SKStoreReviewController.requestReview(in: scene)
                                    }
                                }) {
                                    Text("App reviews")
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(Color(hex: "555556"))
                            }
                            
                            // 의견 및 피드백남기기
                            HStack{
                                Text("Opinion and feedback")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(Color(hex: "555556"))
                            }
                            .onTapGesture {
                                let urlString = "https://apps.apple.com/app/id6475646908?action=write-review"
                                if let url = URL(string: urlString) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
