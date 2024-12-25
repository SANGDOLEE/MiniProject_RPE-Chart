import SwiftUI
import StoreKit

struct SettingView: View {
    
    @AppStorage("isText") private var isText: Bool = false
    
    @State private var showAlert = false
//    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    @Binding var isTabBarMainVisible: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 30) {
                    // 상단 타이틀
                    HStack {
                        Text("Setting")
                            .font(.setPretendard(weight: .bold, size: 34))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    
                    // MARK: - Update
                    VStack(alignment: .leading, spacing: 8) {
                        Text("UPDATE")
                            .font(.setPretendard(weight: .medium, size: 16))
                            .foregroundStyle(.gray)
                            .padding(.leading, 8)
                        
                        // "My BigThree" 버튼
                        NavigationLink(destination: UpdateRecordView(viewModel: MySBDViewModel(),isTabBarMainVisible: $isTabBarMainVisible)) {
                            HStack {
                                Text("My BigThree")
                                    .font(.setPretendard(weight: .regular, size: 16))
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(Color(hex: "555556"))
                            }
                            .padding()
                            .background(.myBackBoxcolor)
                            .cornerRadius(8)
                        }
                    }
                    
                    // MARK: - Configuration
                    VStack(alignment: .leading, spacing: 8) {
                        Text("CONFIGURATION")
                            .font(.setPretendard(weight: .medium, size: 16))
                            .foregroundStyle(.gray)
                            .padding(.leading, 8)
                        
                        // "Weight Unit Conversion" 버튼
                        NavigationLink(destination: WeightUnitView(isTabBarMainVisible: $isTabBarMainVisible)) {
                            HStack {
                                Text("Weight Unit Conversion")
                                    .font(.setPretendard(weight: .regular, size: 16))
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(Color(hex: "555556"))
                            }
                            .padding()
                            .background(Color.myBackBoxcolor)
                            .cornerRadius(8)
                        }
                        
                        //                    HStack {
                        //                        Text("Display Mode")
                        //                        Spacer()
                        //                        Toggle("Auto Switch Mode", isOn: $isDarkModeEnabled)
                        //                            .labelsHidden()
                        //                            .onChange(of: isDarkModeEnabled) { value in
                        //                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        //                                    windowScene.windows.first?.overrideUserInterfaceStyle = value ? .dark : .light
                        //                                }
                        //                            }
                        //                    }
                    }
                    
                    // MARK: - 기타 정보 영역
                    VStack(alignment: .leading, spacing: 3) {
                        
                        // 앱 버전 정보
                        HStack {
                            Text("My RPE version")
                                .font(.setPretendard(weight: .regular, size: 16))
                                .foregroundStyle(.white)
                            Spacer()
                            Text(appVersion)
                                .font(.setPretendard(weight: .regular, size: 16))
                                .foregroundStyle(.white)
                        }
                        .padding()
                        .background(Color.myBackBoxcolor)
                        .cornerRadius(8)
                        
                        // 앱 리뷰 남기기
                        HStack {
                            Text("App reviews")
                                .font(.setPretendard(weight: .regular, size: 16))
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(Color(hex: "555556"))
                        }
                        .padding()
                        .background(Color.myBackBoxcolor)
                        .cornerRadius(8)
                        .onTapGesture {
                            if let scene = UIApplication.shared.connectedScenes
                                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                SKStoreReviewController.requestReview(in: scene)
                            }
                        }
                        
                        // 의견 및 피드백 남기기
                        HStack {
                            Text("Opinion and feedback")
                                .font(.setPretendard(weight: .regular, size: 16))
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(Color(hex: "555556"))
                        }
                        .padding()
                        .background(Color.myBackBoxcolor)
                        .cornerRadius(8)
                        .onTapGesture {
                            let urlString = "https://apps.apple.com/app/id6475646908?action=write-review"
                            if let url = URL(string: urlString) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                .padding()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(stops: [
                        Gradient.Stop(color: Color.init(hex: "2F4753"),    location: 0.1),
                        Gradient.Stop(color: Color.init(hex: "0B001F"), location: 0.4),
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
    }
    
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "\(version)"
    }
}

#Preview {
    SettingView(isTabBarMainVisible: .constant(true))
}
