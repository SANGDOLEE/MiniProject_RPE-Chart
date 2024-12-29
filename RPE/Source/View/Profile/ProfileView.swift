import SwiftUI
import StoreKit

struct ProfileView: View {
    
    @Binding var isMainTabbarVisible: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 30) {
                        // 상단 타이틀
                        HStack {
                            Text("Profile")
                                .font(.setPretendard(weight: .bold, size: 34))
                                .foregroundStyle(.white)
                            Spacer()
                            NavigationLink(destination: SettingView(isMainTabbarVisible: $isMainTabbarVisible)) {
                                Image("gear")
                            }
                        }
                        
                        VStack(spacing: 10) {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 112, height: 112)
                            
                            Text("Hello, Lifter")
                                .font(.setPretendard(weight: .semiBold, size: 18))
                                .foregroundStyle(.white)
                                .kerning(2)
                            
                            Text("Male 77.6+")
                                .font(.setPretendard(weight: .regular, size: 14))
                                .foregroundStyle(.my1DA4E7)
                                .kerning(1)
                        }
                        
                        HStack(spacing: 10) {
                            VStack(spacing: 0) {
                                Image(systemName: "bolt.fill")
                                    .padding()
                                    .background(.my181A32)
                                    .foregroundStyle(.red)
                                    .clipShape(Circle())
                                    .padding(.vertical)
                                
                                Text("485")
                                    .font(.setPretendard(weight: .bold, size: 24))
                                    .foregroundStyle(.white)
                                    .kerning(0.6)
                                    .padding(.bottom, 4)
                                
                                Text("Total")
                                    .font(.setPretendard(weight: .regular, size: 12))
                                    .foregroundStyle(.myB9B9B9)
                                    .kerning(0.6)
                                    .padding(.bottom)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 166)
                            .background(.myBackBoxcolor)
                            .cornerRadius(12)
                            
                            VStack(spacing: 0) {
                                Image(systemName: "atom")
                                    .padding()
                                    .background(.my181A32)
                                    .foregroundStyle(.yellow)
                                    .clipShape(Circle())
                                    .padding(.vertical)
                                
                                Text("355.5")
                                    .font(.setPretendard(weight: .bold, size: 24))
                                    .foregroundStyle(.white)
                                    .kerning(0.6)
                                    .padding(.bottom, 4)
                                
                                Text("Dots")
                                    .font(.setPretendard(weight: .regular, size: 12))
                                    .foregroundStyle(.myB9B9B9)
                                    .kerning(0.6)
                                    .padding(.bottom)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 166)
                            .background(.myBackBoxcolor)
                            .cornerRadius(12)
                            
                            VStack(spacing: 0) {
                                Image(systemName: "globe")
                                    .padding()
                                    .background(.my181A32)
                                    .foregroundStyle(.blue)
                                    .clipShape(Circle())
                                    .padding(.vertical)
                                
                                Text("360.5")
                                    .font(.setPretendard(weight: .bold, size: 24))
                                    .foregroundStyle(.white)
                                    .kerning(0.6)
                                    .padding(.bottom, 4)
                                
                                Text("Wilks")
                                    .font(.setPretendard(weight: .regular, size: 12))
                                    .foregroundStyle(.myB9B9B9)
                                    .kerning(0.6)
                                    .padding(.bottom)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 166)
                            .background(.myBackBoxcolor)
                            .cornerRadius(12)
                            
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
                    }
                    .padding()
                    .padding(.bottom, 12)
                }
                .padding(.bottom, 68)
            }
            .applyGradientBackground()
        }
    }
    
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "\(version)"
    }
}

#Preview {
    ProfileView(isMainTabbarVisible: .constant(true))
}
