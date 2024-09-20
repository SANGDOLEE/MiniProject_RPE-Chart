
import SwiftUI

struct WeightUnitView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @AppStorage("isText") private var isText: Bool = false
    
    var body: some View {
        ZStack {
            Color(hex: "F3F2F8")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Unit of Weight :")
                        .padding(.leading)
                    
                    Text(isText ? "Lb" : "Kg")
                        .bold()
                        .foregroundColor(isText ? .blue : .primary)
                    
                    Spacer()
                    
                    Toggle(isOn: $isText) { }
                        .frame(width: 80)
                        .padding(.trailing)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(10)
                .padding()
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    // Custom navigation back button
    var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                    .bold()
            }
        }
    }
}

#Preview {
    WeightUnitView()
}
