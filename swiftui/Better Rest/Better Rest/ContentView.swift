//
//  ContentView.swift
//  Better Rest
//
//  Created by Clément Villanueva on 23/09/2022.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var idealBedtime: String {
        var result = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            result = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was an error calculating your bedtime."
            showingAlert = true
        }
        
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Wake up time") {
                    DatePicker("Please enter a time amount", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                }
                
                Section("Targeted sleep duration") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section("Daily coffee cups intake") {
                    Picker("\(coffeeAmount)", selection: $coffeeAmount) {
                        ForEach(0..<6) { amount in
                            Text("\(amount)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Ideal bedtime") {
                    Text(idealBedtime)
                        .font(.largeTitle)
                }
            }
            .navigationTitle("Better Rest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
