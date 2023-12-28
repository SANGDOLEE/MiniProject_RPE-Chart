import SwiftUI


// 수정완료
struct EnterView: View {
    
    @StateObject private var viewModel = MySBDViewModel()
    @State private var showAlert = false
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button("SKIP") {
                        isPresented = false
                    }
                    .buttonStyle(PlainButtonStyle())
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
                    .bold()
                    // .padding(.top, 20)
                    .padding(.trailing, 20)
                }
                .padding(.horizontal) // Add some horizontal padding
                Spacer()
                
                VStack(alignment: .center, spacing: 10) {
                    Text("Hello\n ")
                    Text("Please enter 1RM records of\nyour three major weight to take\nadvantage of the RPE chart.")
                        .multilineTextAlignment(.center)
                    
                }
                VStack {
                    HStack {
                        Text("SQ")
                            .font(.system(size: 24))
                            .fontWeight(.light)
                        TextField("Enter Weight", text: $viewModel.squatValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 14))
                            .keyboardType(.decimalPad)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .onChange(of: viewModel.squatValue) { newValue in
                                viewModel.squatValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                    }
                    
                    HStack {
                        Text("BP")
                            .font(.system(size: 24))
                            .fontWeight(.light)
                        TextField("Enter Weight", text: $viewModel.benchValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 14))
                            .fontWeight(.thin)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .onChange(of: viewModel.benchValue) { newValue in
                                viewModel.benchValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                    }
                    
                    HStack {
                        Text("DL")
                            .font(.system(size: 24))
                            .fontWeight(.light)
                        TextField("Enter Weight", text: $viewModel.deadValue)
                            .font(.system(size: 14))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .onChange(of: viewModel.deadValue) { newValue in
                                viewModel.deadValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                    }
                    
                    Button("OK") {
                        // 3개중 1개라도 값이 비어있다면 데이터 저장되지 않음
                        if viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty {
                            showAlert = true
                        } else {
                            viewModel.saveData()
                            UIApplication.shared.windows.first?.endEditing(true)
                            isPresented = false // Dismiss the sheet
                        }
                    }
                    
                    .buttonStyle(PlainButtonStyle())
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
                    .bold()
                    .padding(.top, 20)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Message"),
                            message: Text("Please enter weight values \n for all types."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .padding(.top, 20) // 상단에 여백 추가
                
                Spacer() // 남은 공간을 차지하여 화면 상단으로 이동
                    .onTapGesture {
                        UIApplication.shared.windows.first?.endEditing(true)
                    }
            }
            .padding(.bottom, 100) // top으로부터 여백 0
            
        }
        .onTapGesture {
            hideKeyboardEnterView()
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboardEnterView() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    EnterView(isPresented: .constant(true))
}
