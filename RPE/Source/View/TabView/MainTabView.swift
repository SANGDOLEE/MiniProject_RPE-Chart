import SwiftUI

struct MainTabView: View {
    
    // 실제로 보여줄 화면에 필요한 ViewModel
    @StateObject private var viewModel = BigThreeViewModel()
    @State var isMainTabbarVisible = true  // 처음엔 보이도록 가정
    
    // 현재 선택된 탭
    @State private var selectedTab = "main"
    
    // 커스텀 곡선 위치 계산용
    @State private var xAxis: CGFloat = 0
    @Namespace private var animation
    
    let tabs = ["main", "profile"]
    
    init() {
        // 시스템 탭 바 숨기기
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // MARK: - 본문 컨텐츠(탭마다 다른 View)
            TabView(selection: $selectedTab) {
                MainView(viewModel: viewModel)
                    .tag("main")
                
                ProfileView(isMainTabbarVisible: $isMainTabbarVisible)
                    .tag("profile")
            }
            .onChange(of: selectedTab) { oldValue, newValue in
                triggerHaptic()
            }
            
            HStack {
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { tab in
                        GeometryReader { reader in
                            Button(action: {
                                withAnimation(.spring()) {
                                    selectedTab = tab
                                    xAxis = reader.frame(in: .global).minX
                                }
                            }, label: {
                                // 탭 아이콘
                                Image(systemName: getSystemImageName(for: tab))
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(selectedTab == tab ? getColor(for: tab) : .gray)
                                    .padding(selectedTab == tab ? 15 : 0)
                                    .background(
                                        Color.myBackBoxcolor
                                            .opacity(selectedTab == tab ? 1 : 0)
                                            .clipShape(Circle())
                                    )
                                    .matchedGeometryEffect(id: tab, in: animation)
                                    .offset(
                                        x: selectedTab == tab
                                        ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX)
                                        : 0,
                                        y: selectedTab == tab ? -50 : 0
                                    )
                            })
                            .onAppear {
                                if tab == tabs.first {
                                    // 초기 위치
                                    xAxis = reader.frame(in: .global).minX
                                }
                            }
                        }
                        .frame(width: 25, height: 30)
                        
                        if tab != tabs.last {
                            Spacer(minLength: 0)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical)
                .background(
                    Color.myBackBoxcolor
                        .clipShape(CustomShape(xAxis: xAxis))
                        .cornerRadius(12)
                )
                .padding(.horizontal)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
            }
            .opacity(isMainTabbarVisible ? 1 : 0)
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    // 탭별 아이콘
    func getSystemImageName(for tab: String) -> String {
        switch tab {
        case "main":
            return "chart.bar.fill"
        case "profile":
            return "person.fill"
        default:
            return "questionmark"
        }
    }
    
    // 탭별 색상
    func getColor(for tab: String) -> Color {
        switch tab {
        case "main":
            return .blue
        case "profile":
            return .blue
        default:
            return .gray
        }
    }
    
    // 햅틱
    private func triggerHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
}

// 곡선 Shape
struct CustomShape: Shape {
    
    var xAxis: CGFloat
    var animatableData: CGFloat {
        get { xAxis }
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
// MARK: - 프리뷰
#Preview {
    MainTabView()
}
