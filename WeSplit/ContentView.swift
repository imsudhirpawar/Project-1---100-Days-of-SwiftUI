    //
    //  ContentView.swift
    //  WeSplit
    //
    //  Created by Sudhir Pawar on 06/12/23.
    //

import SwiftUI
struct ContentView: View {
    
    @State private var billAmount: Double = 50
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    private let tipPercentages = [ 5, 10, 15, 20, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = billAmount / 100 * tipSelection
        let grandTotal = tipValue + billAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section{
                    TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach (2..<31) {
                            Text("\($0) people")
                        }
                        
                    }
                }
                
                Section("How much tip do you want to leave?") {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Summery"){
                    Text("Your Bill Amount is:", billAmount)
                    Text("Your Tip Amount is:", tipPercentage, billAmount)
                    Text("Your Total Per Person is:", totalPerPerson)
                        .bold()
                        .font(.system(size: 17))
                        .foregroundStyle(.mint)
                }
                
                
            }
            .navigationTitle("WeSplit")
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

extension Text {
    
    init(_ prefix: String, _ value: Int, _ billAmount: Double){
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier ?? "INR"
        
        let tipValue = billAmount / 100 * Double(value)
        
        
        let formattedValue = formatter.string(from: NSNumber(value: tipValue)) ?? "\(tipValue)"
        
        self.init("\(prefix)  \(formattedValue)")
    }
    
    init(_ prefix: String, _ value: Double){
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier ?? "INR"
        
        let formattedValue = formatter.string(from: NSNumber(value: value)) ?? "\(value)"
        
        self.init("\(prefix)  \(formattedValue)")
    }
}



#Preview {
    ContentView()
}
