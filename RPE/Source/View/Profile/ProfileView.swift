import SwiftUI
import StoreKit
import RealmSwift

struct ProfileView: View {
    
    @Binding var isMainTabbarVisible: Bool
    @ObservedObject var viewModel: BigThreeViewModel
    @State private var profile: Profile? // Profile 데이터를 저장할 변수
    @AppStorage("isText") private var unitOfWeight: Bool = false
    
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
                            if let uiImage = getUserImage() {
                                    // 이미지가 있으면 저장된 이미지 표시
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 112, height: 112)
                                        .clipShape(Circle())
                                } else {
                                    // 이미지가 없을 경우 대체 이미지
                                    Image(systemName: "person.crop.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .tint(.myB9B9B9) // 원하는 색상
                                        .frame(width: 112, height: 112)
                                        .clipShape(Circle())
                                }
                            
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
                                Text(formattedTotal(viewModel.totalValue))
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
    // 기존에 저장된 이미지를 로드해 UI에 표시
    private func getUserImage() -> UIImage? {
        let realm = try! Realm()
        if let profile = realm.objects(Profile.self).first,
           let imgData = profile.image,
           let uiImage = UIImage(data: imgData) {
            return uiImage
        } else {
            // 이미지가 없으면 `nil` 반환
            return nil
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
        
        // (1) unitOfWeight == true → 사용자 입력이 LB 모드
        var bw = bodyWeight
        var tw = totalWeight
        
        if unitOfWeight {
            // 실제 nikkiselev/ipf에 맞춰서, "lb -> kg"로 환산:
            // kg = lb / 2.2046226218
            bw = bodyWeight / 2.2046226218
            tw = totalWeight / 2.2046226218
        }
        
        // (2) Dots 계수 (nikkiselev/ipf)
        let constants = isMale
            ? [-1.093e-6, 7.391293e-4, -0.1918759221, 24.0900756, -307.75076]
            : [-1.0706e-6, 5.158568e-4, -0.1126655495, 13.6175032, -57.96288]
        
        // (3) 분모 계산: a*x^4 + b*x^3 + c*x^2 + d*x + e
        let x4 = constants[0] * pow(bw, 4)
        let x3 = constants[1] * pow(bw, 3)
        let x2 = constants[2] * pow(bw, 2)
        let x1 = constants[3] * bw
        let x0 = constants[4]
        
        let denominator = x4 + x3 + x2 + x1 + x0
        
        // (4) dotsScore = (kg기준 totalWeight) * (500 / 분모)
        let dotsScore = tw * (500.0 / denominator)
        
        // (5) 출력 (정수 or 소수점 둘째 자리)
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
        
        // (1) 단위 변환 처리
        // unitOfWeight == true → LB 모드라면 lb -> kg 로 환산
        var bw = bodyWeight
        var tw = totalWeight
        if unitOfWeight {
            // lb를 kg로 변환 (1 lb ≈ 0.45359237 kg)
            bw = bodyWeight * 0.45359237
            tw = totalWeight * 0.45359237
        }
        
        // (2) Wilks 상수 (성별에 따라 다름)
        let constants = isMale
            ? [-216.0475144, 16.2606339, -0.002388645, -0.00113732, 7.01863e-6, -1.291e-8]
            : [594.31747775582, -27.23842536447, 0.82112226871, -0.00930733913, 4.731582e-5, -9.054e-8]
        
        // (3) 분모 계산
        let denominator = constants.enumerated().reduce(0.0) { partialResult, term in
            let (index, coefficient) = term
            return partialResult + coefficient * pow(bw, Double(index))
        }
        
        // (4) Wilks 점수 계산
        let wilksScore = (500.0 * tw) / denominator
        
        // (5) 정수/소수점 출력
        return wilksScore.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", wilksScore)  // 정수로 출력
            : String(format: "%.2f", wilksScore)  // 소수점 2자리까지 출력
    }
    
    /// 사용자 Total `Double` 값에 대해, 소수점이 0이면 정수로, 아니면 소수점 한 자리까지만 출력
    func formattedTotal(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            // 정수로 표기 (ex: 123)
            return String(format: "%.0f", value)
        } else {
            // 소수점 한 자리만 표기 (ex: 123.4)
            return String(format: "%.1f", value)
        }
    }
    
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "\(version)"
    }
}

#Preview {
    ProfileView(isMainTabbarVisible: .constant(true), viewModel: BigThreeViewModel())
}
