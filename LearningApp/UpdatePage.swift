//
//  UpdatePage.swift
//  LearningApp
//
//  Created by Banan Almehrej on 24/04/1446 AH.
//

import SwiftUI

struct UpdatePage: View {
    @State private var inputText: String = ""  // State variable to hold the input
    
    @State private var selectedSubscription = "Month"  // Default selected option
    let subscriptionOptions = ["Week", "Month", "Year"]
    var body: some View {
        
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading){
                
                Text("I want to learn")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                TextField("", text: $inputText)
                    .foregroundColor(.white)          // Set the text color to white
                    .placeholder(when: inputText.isEmpty) {
                        Text("swift")
                            .foregroundColor(Color(hue: 1.0, saturation: 0.018, brightness: 0.290))
                            .padding(.leading)  // Set the placeholder color to gray
                    }
                    .padding(.bottom, 5)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(hue: 1.0, saturation: 0.018, brightness: 0.290)),
                        alignment: .bottom
                    ).padding(.bottom, 15.0)
                
                Text("I want to learn in a")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                HStack {
                    ForEach(subscriptionOptions, id: \.self) { option in
                        Button(action: {
                            selectedSubscription = option  // Update selected option
                        }) {
                            Text(option)
                                .padding()
                                .background(selectedSubscription == option ? Color.orange : Color.gray.opacity(0.3))  // Change background color based on selection
                                .foregroundColor(selectedSubscription == option ? .black : .orange)  // Change text color based on selection
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle()) // Use plain style to avoid default button styling
                    }
                } // End of Buttons HStack
                
                
                
            }.padding(.bottom, 250)// End of VStack
        } // End of Z stacky
    }
}

#Preview {
    UpdatePage()
}
