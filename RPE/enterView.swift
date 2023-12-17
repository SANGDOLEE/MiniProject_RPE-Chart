import SwiftUI

struct EnterView: View {
    
    
    @StateObject private var viewModel = MySBDViewModel()
    @State private var showAlert = false
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10) {
            Text("Hello\n ")
            Text("Please enter 1RM records\n of your squat, benchpress, and \n deadlift to take advantage of the RPE chart.")
                .multilineTextAlignment(.center)
            VStack{
                HStack {
                    Text("SQ")
                        .font(.system(size: 24))
                    TextField("Enter Weight", text: $viewModel.squatValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 115)
                        .onChange(of: viewModel.squatValue) { newValue in
                            viewModel.squatValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                        }
                    Text("kg")
                }
                .padding(.top,20)
                
                HStack {
                    Text("BP")
                        .font(.system(size: 24))
                    TextField("Enter Weight", text: $viewModel.benchValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 115)
                        .onChange(of: viewModel.benchValue) { newValue in
                            viewModel.benchValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                        }
                    Text("kg")
                }
                
                HStack {
                    Text("DL")
                        .font(.system(size: 24))
                    TextField("Enter Weight", text: $viewModel.deadValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 115)
                        .onChange(of: viewModel.deadValue) { newValue in
                            viewModel.deadValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                        }
                    Text("kg")
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
                .padding(.top,20)
                
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Message"),
                        message: Text("Please enter weight values \n for all types."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
            }
            .padding(.top, 20) // 추가된 부분: 상단에 여백 추가
                        
                        Spacer() // 추가된 부분: 남은 공간을 차지하여 화면 상단으로 이동
            // .padding(.bottom,200)
            .onTapGesture {
                UIApplication.shared.windows.first?.endEditing(true)
            }
            
        }
        .padding(.top,75) // 추가된 부분: 전체적인 여백 추가
    }
}

#Preview {
    EnterView(isPresented: .constant(true))
}
