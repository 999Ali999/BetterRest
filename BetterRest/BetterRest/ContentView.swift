//
//  ContentView.swift
//  BetterRest
//
//  Created by Ali on 01/12/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section("When to wake up?") {

                    VStack(alignment: .center) {
                        DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute)
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                                .environment(\.locale, Locale(identifier: "en_GB"))
                    }
                }
                
                Section("Desired amount of sleep") {
                    VStack(alignment: .leading) {
                        Stepper("\(sleepAmount.formatted()) Hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                }
                                
                Section("Daily coffee intake") {
                    VStack(alignment: .leading) {
                        Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                        
//                        Picker("Cups", selection: $coffeeAmount) {
//                            ForEach((1...20), id: \.self) {
//                                Text("\($0)")
//                            }
//                        }.pickerStyle(.automatic)
                    }
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeeAmount)))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
    
}

#Preview {
    ContentView()
}
