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
                                
                                Text(getWilksScore())
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
        
        // @nikkiselev/ipf 에서 발췌한 Dots 계수
        // 남성(m), 여성(f)에 따른 서로 다른 5개 항
        let constants = isMale
            ? [-1.093e-6, 7.391293e-4, -0.1918759221, 24.0900756, -307.75076]
            : [-1.0706e-6, 5.158568e-4, -0.1126655495, 13.6175032, -57.96288]
        
        // 분모 계산: a*x^4 + b*x^3 + c*x^2 + d*x + e
        let x4 = constants[0] * pow(bodyWeight, 4)
        let x3 = constants[1] * pow(bodyWeight, 3)
        let x2 = constants[2] * pow(bodyWeight, 2)
        let x1 = constants[3] * bodyWeight
        let x0 = constants[4]
        
        let denominator = x4 + x3 + x2 + x1 + x0
        
        // dotsScore = totalWeight * (500 / 분모)
        let dotsScore = totalWeight * (500.0 / denominator)
        
        // 소수점 이하가 0이면 정수, 아니면 소수점 둘째 자리까지
        return dotsScore.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", dotsScore)
            : String(format: "%.2f", dotsScore)
    }
    
    // Wilks 계산 함수
    private func getWilksScore() -> String {
        let realm = try! Realm()
        
        guard let profileData = realm.objects(Profile.self).first else {
            print("⚠️ Profile 데이터 없음")
            return "N/A"
        }
        
        let bodyWeight = profileData.bodyWeight
        let isMale = profileData.gender == "Male"
        let totalWeight = viewModel.totalValue
        
        guard totalWeight > 0 else {
            print("⚠️ Total Weight 없음")
            return "N/A"
        }
        
        return calculateWilks(totalWeight: totalWeight, bodyWeight: bodyWeight, isMale: isMale)
    }
    
    // Wilks 계산 로직
    private func calculateWilks(totalWeight: Double, bodyWeight: Double, isMale: Bool) -> String {
        guard bodyWeight > 0 else { return "N/A" }
        
        // Wilks 상수 (성별에 따라 다름)
        let constants = isMale
            ? [-216.0475144, 16.2606339, -0.002388645, -0.00113732, 7.01863e-6, -1.291e-8]
            : [594.31747775582, -27.23842536447, 0.82112226871, -0.00930733913, 4.731582e-5, -9.054e-8]
        
        // 분모 계산
        let denominator = constants.enumerated().reduce(0.0) { partialResult, term in
            let (index, coefficient) = term
            return partialResult + coefficient * pow(bodyWeight, Double(index))
        }
        
        // Wilks 점수 계산
        let wilksScore = (500 * totalWeight) / denominator
        return wilksScore.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", wilksScore) // 정수로 출력
            : String(format: "%.2f", wilksScore) // 소수점 2자리까지 출력
    }
    
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "\(version)"
    }
}

#Preview {
    ProfileView(isMainTabbarVisible: .constant(true), viewModel: BigThreeViewModel())
}
