
import SwiftUI

// MARK: - 앱의 첫 사용시에만 등장하는 뷰
struct OnboardingView: View {
    
    @Environment(NavigationRouter.self) var navigationRouter
    @StateObject private var viewModel = BigThreeViewModel()
    
    @AppStorage("isFirstRun") private var isFirstRun: Bool?
    @Binding var isPresented: Bool
    
    @State private var showAlert = false
    
    var body: some View {
            VStack {
                HStack {
                    Button {
                        navigationRouter.pop()
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 24, height: 24)
                            .tint(.white)
                    }
                    Spacer()
                    Button {
                        isPresented = false
                        isFirstRun = false
                    } label: {
                        Text("SKIP")
                            .font(.setPretendard(weight: .semiBold, size: 18))
                            .foregroundStyle(.white)
                    }
                }
                
                VStack(alignment: .center, spacing: 10) {
                    Text("Fill Out Your Information")
                        .font(.setPretendard(weight: .semiBold, size: 26))
                        .foregroundStyle(.white)
                    Text("This is used to calculate\nyour Big Three total")
                        .font(.setPretendard(weight: .medium, size: 18))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                VStack(spacing: 22) {
                    VStack {
                        HStack {
                            Text("Squat")
                                .font(.setPretendard(weight: .bold, size: 18))
                                .foregroundStyle(.myAccentcolor)
                            Spacer()
                        }
                        HStack {
                            ZStack {
                                TextField("Squat Weight", text: $viewModel.squatValue)
                                    .multilineTextAlignment(.leading)
                                    .frame(height: 44)
                                    .padding(.horizontal)
                                    .background(.white)
                                    .cornerRadius(12)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: viewModel.squatValue) { oldValue, newValue in
                                        viewModel.squatValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                                    }
                                HStack {
                                    Spacer()
                                    XmarkButton(text: $viewModel.squatValue)
                                }
                            }
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        HStack {
                            Text("BenchPress")
                                .font(.setPretendard(weight: .bold, size: 18))
                                .foregroundStyle(.myAccentcolor)
                            Spacer()
                        }
                        HStack {
                            ZStack {
                                TextField("BenchPress Weight", text: $viewModel.benchValue)
                                    .multilineTextAlignment(.leading)
                                    .frame(height: 44)
                                    .padding(.horizontal)
                                    .background(.white)
                                    .cornerRadius(12)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: viewModel.benchValue) { oldValue, newValue in
                                        viewModel.benchValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                                    }
                                HStack {
                                    Spacer()
                                    XmarkButton(text: $viewModel.benchValue)
                                }
                            }
                            Spacer()
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text("Deadlift")
                                .font(.setPretendard(weight: .bold, size: 18))
                                .foregroundStyle(.myAccentcolor)
                            Spacer()
                        }
                        HStack {
                            ZStack {
                                TextField("Deadlift Weight", text: $viewModel.deadValue)
                                    .multilineTextAlignment(.leading)
                                    .frame(height: 44)
                                    .padding(.horizontal)
                                    .background(.white)
                                    .cornerRadius(12)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: viewModel.deadValue) { oldValue, newValue in
                                        viewModel.deadValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                                    }
                                HStack {
                                    Spacer()
                                    XmarkButton(text: $viewModel.deadValue)
                                }
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    
                    Button {
                        /// 3개 중 1개라도 값이 비어있다면 데이터 저장되지 않음
                        if viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty {
                            showAlert = true
                        } else {
                            viewModel.saveData()
                            UIApplication.shared.closeKeyboard()
                            isFirstRun = false
                            
                        }
                    } label: {
                        Text("COMPLETE")
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .font(.setPretendard(weight: .bold, size: 18))
                            .foregroundStyle(viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty ? .white : .black)
                            .background(viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty ? .myB9B9B9 : .myAccentcolor)
                            .cornerRadius(12)
                    }
                    .padding(.top, 20)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Message"),
                            message: Text("Please enter weight values \n for all types."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .padding(.top, 36)
            }
            .ignoresSafeArea(.keyboard, edges: .all)
            .padding()
            .applyGradientBackground()
            .onTapGesture {
                UIApplication.shared.closeKeyboard()
            }
    }
}

#Preview {
    OnboardingView(isPresented: .constant(true))
        .environment(NavigationRouter())
}
