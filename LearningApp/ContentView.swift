//
//  ContentView.swift
//  LearningApp
//
//  Created by Banan Almehrej on 18/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""  // State variable to hold the input
    
    @State private var selectedSubscription = "Month"  // Default selected option
       let subscriptionOptions = ["Week", "Month", "Year"]
    
    var body: some View {
        NavigationView {
        
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                Text("🔥").background(
                    Circle()                  // Adds a circle background
                        .fill(Color(hue: 1.0, saturation: 0.02, brightness: 0.219))    // Set the color of the circle
                        .frame(width: 150, height: 150)  // Set the size of the circle
                ).font(.system(size: 75)).padding(.bottom, 580.0)
                
                
                VStack (alignment: .leading){
                    
                    Text("Hello Learner!").font(.system(size: 30))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                    Text("This app will help you learn everyday")
                        .font(.headline)
                        .foregroundColor(Color(hue: 1.0, saturation: 0.018, brightness: 0.250)).padding(.bottom, 30.0)
                    
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
                    
                    
                    
                } // End of VStack
                .padding(.bottom, 40.0)
                
                NavigationLink(destination: HomePage()) {
                    Text("Start!")  // Use Text directly within NavigationLink
                        .padding()
                        .frame(width: 200)  // Set the width
                        .background(Color.orange)  // Background color
                        .foregroundColor(.black)  // Text color
                        .cornerRadius(10)  // Rounded corners
                }
                .padding(.top, 400)  // Padding for positioning
            
            }

            
        }
    }
    }
// Custom placeholder modifier to display placeholder text
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}



#Preview {
    ContentView()
}
