
import SwiftUI

struct WeightUnitView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @AppStorage("isText") private var unitOfWeight: Bool = false
    @State private var tappedUnit: Bool = false
    
    @Binding var isMainTabbarVisible: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack {
                    Text("Unit of measure :")
                        .padding(.leading)
                        .foregroundStyle(.white)
                    
                    Text(unitOfWeight ? "Lb" : "Kg")
                        .font(.setPretendard(weight: .bold, size: 18))
                        .foregroundColor(unitOfWeight ? .myAccentcolor : .white)
                    
                    Spacer()
                    
                    Toggle(isOn: $unitOfWeight) { }
                        .frame(width: 80)
                        .padding(.trailing)
                        .onChange(of: unitOfWeight) { oldValue, newValue in
                            tappedUnit.toggle()
                        }
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.myBackBoxcolor)
                .cornerRadius(10)
                .padding(.top)
                
                if unitOfWeight {
                    HStack(alignment: .top, spacing: 4) {
                        Image(systemName: "exclamationmark.circle")
                            .foregroundStyle(.green)
                            .font(.setPretendard(weight: .medium, size: 12))
                        
                        Text("If lb, Dots & Wilks Point may have an error of about 0.02")
                            .font(.setPretendard(weight: .medium, size: 12))
                            .foregroundStyle(.green)
                            .lineSpacing(2)
                        
                        Spacer()
                    }
                }
                
                if tappedUnit {
                    HStack(alignment: .top, spacing: 4) {
                        Image(systemName: "exclamationmark.circle")
                            .foregroundStyle(.green)
                            .font(.setPretendard(weight: .medium, size: 12))
                        
                        Text("If you change units, please note that the bodyweight\nand the Big three weight values you enter will not be automatically converted.")
                            .font(.setPretendard(weight: .medium, size: 12))
                            .foregroundStyle(.green)
                            .lineSpacing(2)
                        
                        Spacer()
                    }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .applyGradientBackground()
        .onAppear {
            isMainTabbarVisible = false
        }
    }
    
    // Custom navigation back button
    var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
            isMainTabbarVisible = true
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .frame(width: 24, height: 24)
                    .tint(.white)
            }
        }
    }
}

#Preview {
    WeightUnitView(isMainTabbarVisible: .constant(true))
}
