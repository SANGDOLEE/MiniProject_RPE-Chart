
import SwiftUI

// MARK: - 앱의 첫 사용시에만 등장하는 뷰
struct OnboardingView: View {
    
    @StateObject private var viewModel = MySBDViewModel()
    @State private var showAlert = false
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isPresented = false
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
                            .foregroundColor(.accentColor)
                        Spacer()
                    }
                    HStack {
                        
                        ZStack {
                            TextField("Enter Weight", text: $viewModel.squatValue)
                                .font(.setPretendard(weight: .regular, size: 18))
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
                                Button {
                                    viewModel.squatValue = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 23, height: 23)
                                        .foregroundStyle(.myB9B9B9)
                                }
                                .opacity(viewModel.squatValue.count > 0 ? 1 : 0)
                                .padding(.trailing)
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
                            TextField("Enter Weight", text: $viewModel.benchValue)
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
                                Button {
                                    viewModel.benchValue = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 23, height: 23)
                                        .foregroundStyle(.myB9B9B9)
                                }
                                .opacity(viewModel.benchValue.count > 0 ? 1 : 0)
                                .padding(.trailing)
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
                            TextField("Enter Weight", text: $viewModel.deadValue)
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
                                Button {
                                    viewModel.deadValue = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 23, height: 23)
                                        .foregroundStyle(.myB9B9B9)
                                }
                                .opacity(viewModel.deadValue.count > 0 ? 1 : 0)
                                .padding(.trailing)
                            }
                        }
                        Spacer()
                    }
                }
                
                Spacer()
                
                Button("COMPLETE") {
                    /// 3개중 1개라도 값이 비어있다면 데이터 저장되지 않음
                    if viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty {
                        showAlert = true
                    } else {
                        viewModel.saveData()
                        UIApplication.shared.closeKeyboard()
                        isPresented = false /// Dismiss the sheet
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .font(.setPretendard(weight: .bold, size: 18))
                .foregroundStyle(viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty ? .white : .black)
                .background(viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty ? .gray : .myAccentcolor)
                .cornerRadius(12)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .padding()
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
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
    }
}

#Preview {
    OnboardingView(isPresented: .constant(true))
}
