//
//  ContentView.swift
//  WeSplit
//
//  Created by Trevor Kimble on 2/14/24.
//

import SwiftUI

struct ContentView: View 
{
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    
    var totalPerPerson: Double{
        let numPeople = Double(numberOfPeople + 2)
        let tip = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tip
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / numPeople
        
        return amountPerPerson
    }
    
    var body: some View 
    {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                
                Section("Tip"){
              
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total") {
                    Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                
            }
            .navigationTitle("Check Splitter")
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}


//struct ContentView: View {
//    
//   
//
//}

#Preview {
    ContentView()
}
