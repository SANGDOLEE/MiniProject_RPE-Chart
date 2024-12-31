import SwiftUI
import StoreKit
import RealmSwift

struct ProfileView: View {
    
    @Binding var isMainTabbarVisible: Bool
    @ObservedObject var viewModel: BigThreeViewModel
    @State private var profile: Profile? // Profile 데이터를 저장할 변수
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Profile")
                            .font(.setPretendard(weight: .bold, size: 34))
                            .foregroundStyle(.white)
                        Spacer()
                        NavigationLink(destination: SettingView(isMainTabbarVisible: $isMainTabbarVisible)) {
                            Image("gear")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    // 상단 타이틀
                    ScrollView {
                        VStack(spacing: 10) {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 112, height: 112)
                            
                            Text(getUserNickname())
                                .font(.setPretendard(weight: .semiBold, size: 18))
                                .foregroundStyle(.white)
                                .kerning(2)
                            
                            Text("\(getUserGender()) \(getUserBodyweight())+")
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
                                
                                // ⚠️ 나중에 정수형으로 딱 떨어지면, 소수점 표시 X
                                Text("\(viewModel.totalValue, specifier: "%.1f")")
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
                                
                                Text(getDotsScore())
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
                        .padding(.top)
                        
                        // MARK: - 기타 정보 영역
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Customer Services")
                                .font(.setPretendard(weight: .semiBold, size: 14))
                                .foregroundStyle(.myB9B9B9)
                                .padding(.bottom, 8)
                            
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
                        .padding(.top, 32)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 68)
            }
            .applyGradientBackground()
        }
    }
    
    // User 닉네임
    private func getUserNickname() -> String {
        let realm = try! Realm()
        
        if let profileData = realm.objects(Profile.self).first {
            let userNickname = profileData.nickname
            return userNickname
        } else {
            print("⚠️ 유저 성별 입력되지 않음")
            return "Hello, Lifter"
        }
    }
    
    // User 체중
    private func getUserGender() -> String {
        let realm = try! Realm()
        
        if let profileData = realm.objects(Profile.self).first {
            let userGender = profileData.gender
            return userGender
        } else {
            print("⚠️ 유저 성별 입력되지 않음")
            return "N/A"
        }
    }
    
    // User 체중
    private func getUserBodyweight() -> String {
        let realm = try! Realm()
        
        if let profileData = realm.objects(Profile.self).first {
            let bodyWeight = profileData.bodyWeight
            
            // 소수점이 0인지 확인 후 형식 지정
            let formattedWeight: String
            if bodyWeight.truncatingRemainder(dividingBy: 1) == 0 {
                formattedWeight = String(format: "%.0f", bodyWeight) // 정수로 출력
            } else {
                formattedWeight = String(format: "%.1f", bodyWeight) // 소수점 1자리까지 출력
            }
            return formattedWeight
        } else {
            print("No profile data found. Returning default body weight of 0.0.")
            return "N/A"
        }
    }
    // Dots 계산 함수
    private func getDotsScore() -> String {
        let realm = try! Realm()
        
        guard let profileData = realm.objects(Profile.self).first else {
            print("⚠️ Profile 데이터 없음")
            return "N/A"
        }
        
        let bodyWeight = profileData.bodyWeight
        let isMale = profileData.gender == "Male" // 성별 확인
        let totalWeight = viewModel.totalValue // Total Weight
        
        guard totalWeight > 0 else {
            print("⚠️ Total Weight 없음")
            return "N/A"
        }
        
        return calculateDots(totalWeight: totalWeight, bodyWeight: bodyWeight, isMale: isMale)
    }
    
    // Dots 계산 추가 로직
    private func calculateDots(totalWeight: Double, bodyWeight: Double, isMale: Bool) -> String {
        guard bodyWeight > 0 else { return "N/A" }
        
        let constants = isMale
            ? [-216.0475144, 16.2606339, -0.002388645, -0.00113732, 7.01863e-6, -1.291e-8]
            : [594.31747775582, -27.23842536447, 0.82112226871, -0.00930733913, 4.731582e-5, -9.054e-8]
        
        let denominator = constants.enumerated().reduce(0.0) { partialResult, term in
            let (index, coefficient) = term
            return partialResult + coefficient * pow(bodyWeight, Double(index))
        }
        
        let dotsScore = (500 * totalWeight) / denominator
        return dotsScore.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", dotsScore) // 정수로 출력
            : String(format: "%.2f", dotsScore) // 소수점 1자리까지 출력
    }
    
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "\(version)"
    }
}

#Preview {
    ProfileView(isMainTabbarVisible: .constant(true), viewModel: BigThreeViewModel())
}
