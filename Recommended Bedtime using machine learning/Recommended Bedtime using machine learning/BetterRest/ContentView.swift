//
//  ContentView.swift
//  BetterRest
//
//  Created by Trevor Kimble on 2/28/24.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var recommendedBedtime = ""
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    

    
    var body: some View {
        
        NavigationStack{
            Form {
                Section{
                    Text("When do you want to wake up?").font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                }
                
                Section{
                    Text("Desired amount of sleep").font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section{
                    Text("Daily coffee intake").font(.headline)
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                }
                
                Section{
                    Text("Recommended bed time")
                    Text(recommendedBedtime)
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar{
//                Button("Calculate", action: calculateBedtime)
//            }
//            
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("Ok"){}
//            } message: {
//                Text(alertMessage)
//            }
            .navigationTitle("BetterRest")
            //.toolbar{
            //    Button("Calculate", action: calculateBedtime)
            // }
        }
        .onAppear { calculateBedtime()}
        .onChange(of: wakeUp) { _ in  calculateBedtime() }
        .onChange(of: sleepAmount) { _ in  calculateBedtime() }
        .onChange(of: coffeeAmount) { _ in  calculateBedtime() }

    
    }
    
    func calculateBedtime(  )
    {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let componets = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (componets.hour ?? 0) * 60 * 60
            let minute = (componets.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
           // alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
           // alertTitle = "Error"
            alertMessage = "Sorry, there was an error when preforming calculations"
        }
//        showingAlert = true
        recommendedBedtime = alertMessage
    }
}

#Preview {
    ContentView()
}
