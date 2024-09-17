
import SwiftUI

struct MyRecordView: View {
    
    @ObservedObject var viewModel: MySBDViewModel
    @AppStorage("isText") private var isText: Bool = false
    
    @State private var showAlert = false
    @State var isModalSheetShown: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("total")
                        .font(.system(size: 27))
                    
                    let squatValue = Double(viewModel.squatValue) ?? 0.0
                    let benchValue = Double(viewModel.benchValue) ?? 0.0
                    let deadValue = Double(viewModel.deadValue) ?? 0.0
                    
                    let totalValue = squatValue + benchValue + deadValue
                    if totalValue.truncatingRemainder(dividingBy: 1) == 0 {
                        Text("\(Int(totalValue))")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.blue)
                    } else {
                        let formattedTotal = formatTotalValue(totalValue)
                        Text(formattedTotal)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.blue)
                    }
                    Text(isText ? "lb" : "kg")
                        .font(.system(size: 24))
                }
                
                HStack {
                    Text("SQ")
                        .font(.system(size: 24, weight: .light))
                    TextField("Enter weight", text: $viewModel.squatValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .fontWeight(.thin)
                        .multilineTextAlignment(.center)
                        .frame(width: 115)
                        .onChange(of: viewModel.squatValue) { newValue in
                            viewModel.squatValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                        }
                    Text(isText ? "lb" : "kg")
                }
                
                HStack {
                    Text("BP")
                        .font(.system(size: 24, weight: .light))
                    TextField("Enter weight", text: $viewModel.benchValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 115)
                        .fontWeight(.thin)
                        .onChange(of: viewModel.benchValue) { newValue in
                            viewModel.benchValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                        }
                    Text(isText ? "lb" : "kg")
                }
                
                HStack {
                    Text("DL")
                        .font(.system(size: 24, weight: .light))
                    TextField("Enter weight", text: $viewModel.deadValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 115)
                        .fontWeight(.thin)
                        .onChange(of: viewModel.deadValue) { newValue in
                            viewModel.deadValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                        }
                    Text(isText ? "lb" : "kg")
                }
                
                HStack {
                    Button(action: {
                        totalUpdate()
                    }) {
                        Text("UPDATE")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                            .cornerRadius(20)
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Message"),
                        message: Text("Please enter weight values for all types."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .onTapGesture {
                UIApplication.shared.windows.first?.endEditing(true)
            }
            .navigationBarTitle("Setting Weight", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                isModalSheetShown.toggle()
            }) {
                Image(systemName: "gear")
                    .foregroundColor(.black)
            }
                .sheet(isPresented: $isModalSheetShown) {
                    SettingView(showModal: $isModalSheetShown)
                }
            )
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func totalUpdate() {
        if viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty {
            showAlert = true
        } else {
            viewModel.saveData()
            UIApplication.shared.windows.first?.endEditing(true)
        }
    }
}

extension MyRecordView {
    private func formatTotalValue(_ totalValue: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.groupingSeparator = ""
        formatter.usesGroupingSeparator = false
        
        return formatter.string(from: NSNumber(value: totalValue)) ?? "\(totalValue)"
    }
}

#Preview {
    MyRecordView(viewModel: MySBDViewModel())
}
