
import SwiftUI

struct WeightUnitView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @AppStorage("isText") private var isText: Bool = false
    
    @Binding var isTabBarMainVisible: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Unit of Weight :")
                        .padding(.leading)
                        .foregroundStyle(.white)
                    
                    Text(isText ? "Lb" : "Kg")
                        .font(.setPretendard(weight: .bold, size: 18))
                        .foregroundColor(isText ? .myAccentcolor : .white)
                    
                    Spacer()
                    
                    Toggle(isOn: $isText) { }
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
            isTabBarMainVisible = false
        }
    }
    
    // Custom navigation back button
    var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
            isTabBarMainVisible = true
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .tint(.white)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    WeightUnitView(isTabBarMainVisible: .constant(true))
}
