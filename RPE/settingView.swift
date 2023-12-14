import SwiftUI

import SwiftUI

struct settingView: View {
    
    @State private var weightToggle = false // Kg <-> Lbs
    @State private var lanToggle = false // Eng <-> Korean
    
    @State private var weightText = ""
    @State private var lanText = ""
    
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
        }
    }
}

#Preview {
    settingView()
}
