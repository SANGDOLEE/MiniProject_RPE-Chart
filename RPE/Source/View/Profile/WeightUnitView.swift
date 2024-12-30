
import SwiftUI

struct WeightUnitView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @AppStorage("isText") private var unitOfWeight: Bool = false
    
    @Binding var isMainTabbarVisible: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Unit of Weight :")
                        .padding(.leading)
                        .foregroundStyle(.white)
                    
                    Text(unitOfWeight ? "Lb" : "Kg")
                        .font(.setPretendard(weight: .bold, size: 18))
                        .foregroundColor(unitOfWeight ? .myAccentcolor : .white)
                    
                    Spacer()
                    
                    Toggle(isOn: $unitOfWeight) { }
                        .frame(width: 80)
                        .padding(.trailing)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.myBackBoxcolor)
                .cornerRadius(10)
                .padding()
                
                Spacer()
            }
        }
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
