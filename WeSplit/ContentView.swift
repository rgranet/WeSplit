//
//  ContentView.swift
//  WeSplit
//
//  Created by Ruben Granet on 26/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var totalAmount = 0.0
    let tipPercetanges = [10, 15, 20, 25, 0]
    @FocusState private var amountIsFocused : Bool
    
    var totalPerPerson:Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        totalAmount = grandTotal
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercetanges, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave ?")
                }
                
                Section {
                    
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Each person has to pay ")
                }
                
                Section {
                    
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total to pay ")
                }
            }
        }
        .navigationTitle("WeSplit")
        .toolbar{
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
