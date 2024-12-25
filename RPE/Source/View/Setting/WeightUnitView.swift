
import SwiftUI

struct WeightUnitView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @AppStorage("isText") private var isText: Bool = false
    
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
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop(color: Color.init(hex: "2F4753"), location: 0.1),
                    Gradient.Stop(color: Color.init(hex: "0B001F"), location: 0.4),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
    
    // Custom navigation back button
    var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
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
    WeightUnitView()
}
