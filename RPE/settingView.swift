import SwiftUI

import SwiftUI

struct settingView: View {
    
    @State private var weightToggle = false // Kg <-> Lbs
    @State private var lanToggle = false // Eng <-> Korean
    
    @State private var weightText = ""
    @State private var lanText = ""
    
    
    // showModal 바인딩
    @Binding var showModal: Bool  // 바인딩 추가
    init(showModal: Binding<Bool>) {
        _showModal = showModal
    }
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                HStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Weight :")
                    Toggle(isOn: $weightToggle) {
                        if weightToggle {
                            Text("Lbs")
                        } else {
                            Text("Kg")
                        }
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Languages :")
                    Toggle(isOn: $lanToggle) {
                        if lanToggle {
                            Text("Korean")
                        } else {
                            Text("English")
                        }
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
            }.navigationBarTitle("Setting",displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.showModal.toggle()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                })
        }
    }
}

struct settingView_Previews: PreviewProvider {
    static var previews: some View {
        settingView(showModal: .constant(true))
    }
}
