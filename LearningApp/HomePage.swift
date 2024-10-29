//
//  HomePage.swift
//  LearningApp
//
//  Created by Banan Almehrej on 18/04/1446 AH.
//
import SwiftUI

struct HomePage: View {
    @ObservedObject var viewModel = WeeklyTaskViewModel()
    @State private var selectedDate = Date()
    
    // List of months and years
    let months = Calendar.current.monthSymbols
    let years = Array(2020...2030) // You can adjust this year range
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                
                
                Text(dayOfWeekFormatter.string(from: viewModel.currentWeek.selectedDay) + " " + monthYearFormatter.string(from: viewModel.currentWeek.selectedDay))
                    .font(.headline)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.018, brightness: 0.250)).padding(.trailing, 200.0)
                
                NavigationLink(destination: UpdatePage()) {
                    Text("🔥").background(
                        Circle()                  // Adds a circle background
                            .fill(Color(hue: 1.0, saturation: 0.02, brightness: 0.219))    // Set the color of the circle
                            .frame(width: 50, height: 50)  // Set the size of the circle
                    ).font(.system(size: 25)).padding(.leading, 300.0)
                } // navigation
                
                
                Text("LearningSwift").font(.system(size: 30))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white).padding(.trailing, 150.0)
                
                
                
                // Divider for visual separation
                //       Divider()
                
                
                
                // Calendar
                ZStack {
                    // Background Rounded Rectangle with border
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2) // Border styling
                        .background(Color.clear) // Optional: Background color inside the rectangle
                        .cornerRadius(20)
                    
                    
                    
                    // Navigation Buttons (Previous/Next week)
                    HStack {
                        // Picker for selecting the month and year
                        
                        Text(monthYearFormatter.string(from: viewModel.currentWeek.selectedDay))
                            .font(.title).padding(.trailing , 100)
                        
                        
                        
                        
                        // Spacer()
                        Button(action: viewModel.goToPreviousWeek) {
                            Image(systemName: "chevron.left").foregroundStyle(.orange)   }
                        
                        Button(action: viewModel.goToNextWeek) {
                            Image(systemName: "chevron.right").foregroundStyle(.orange) }
                        
                    }.padding(.bottom, 180.0)
                    
                    
                    // Calendar days
                    HStack {
                        ForEach(viewModel.currentWeek.days, id: \.self) { day in
                            VStack {
                                Text(dayOfWeekFormatter.string(from: day))
                                    .font(.caption)
                                    .foregroundColor(.white)
                                
                                // The day number with background colors depending on the day state
                                Text(dayOfMonthFormatter.string(from: day))
                                    .padding(10)
                                    .background(colorForDay(day: day))
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        // Update selected day when a day is tapped
                                        viewModel.currentWeek.selectedDay = day
                                    }
                            }
                        }
                    }
                    
                    // Streak & Freeze Counters
                    HStack {
                        VStack {
                            Text("\(viewModel.streak.dayStreak)" + "🔥")
                                .font(.largeTitle)
                            Text("Day streak")
                                .font(.caption)
                        }.padding(.trailing, 99.00)
                        
                        // Spacer()
                        Divider().overlay(.white)
                        
                        
                        VStack {
                            Text("\(viewModel.streak.frozenDays)" + "🧊")
                                .font(.largeTitle)
                            Text("Days frozen")
                                .font(.caption)
                        }.padding(.leading, 93.00)
                        
                        
                    } .padding(.top, 150.0)
                    
                    
                }
                .frame(height: 230) // Adjust height to fit the calendar content
                // .padding()  Padding between the calendar and surrounding content
                
                
                
                
                Spacer()
                
                // Log Button
                Button(action: {
                    viewModel.logTodayAsLearned()
                }) {
                    Text("Log today as Learned")
                        .frame(width: 250, height: 250)
                        .background(Color.orange).font(.system(size: 35))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                
                // Freeze Button
                Button(action: {
                    viewModel.freezeToday()
                    
                }) {
                    Text("Freeze day")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                // Freeze Usage Text
                Text("\(viewModel.streak.frozenDays) out of \(viewModel.streak.maxFreezes) freezes used")
                    .font(.caption)
            }
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
        }
    }
        // Helper method to determine the background color for each day
        func colorForDay(day: Date) -> Color {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date()) // Normalize to start of day
            
            // Determine if the day is the current day
            if calendar.isDate(today, inSameDayAs: day) {
                return Color.clear
                
                // Current day
            } else if viewModel.frozenDays.contains(calendar.startOfDay(for: day)) {
                return Color.blue // Frozen day
                
            } else if viewModel.learnedDays.contains(calendar.startOfDay(for: day)) {
                return Color.orange.opacity(0.9) // Learned day
            } else if day < today {
                return Color.orange.opacity(0.4) // Previous unlearned day
            }
            return Color.clear // Default day
        }
        
        // Date formatters
        var dayOfWeekFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE"
            return formatter
        }
        
        var dayOfMonthFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "d"
            return formatter
        }
        
        var monthYearFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            return formatter
        }
        
    }


struct WeeklyTaskView_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}



#Preview {
    HomePage()
}
