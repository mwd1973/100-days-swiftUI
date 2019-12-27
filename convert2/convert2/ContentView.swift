//
//  ContentView.swift
//  UniversalConverter
//
//  Created by Martin Douglas on 12/22/19.
//  Copyright © 2019 Doghouse Industries. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usStandardsIndex = 0
    @State private var metricIndex = 0
    
    var usStandardTypes = ["-","Miles", "Feet", "Inches"]
    var metricTypes = ["-","Kilometers","Meters", "Centimeters", "Milimeters"]
    var unitLengths: [String: UnitLength] = ["Miles": UnitLength.miles, "Feet": UnitLength.feet, "Inches": UnitLength.inches, "Kilometers" : UnitLength.kilometers, "Meters" : UnitLength.meters, "Centimeters" : UnitLength.centimeters, "Milimeters" : UnitLength.millimeters]
    
    
    
    @State private var fromValue =  ""
    @State private var resultValue = "0.0"
    
    @State private var fromTypeSelected = "-"
    @State private var toTypeSelected = "-"
    @State private var convertEnabled = true
    
    var body: some View {
        
        NavigationView{
            VStack {
                Text("\(fromTypeSelected) to \(toTypeSelected)").padding()
                      TextField("Enter value to convert", text: $fromValue)
                        .keyboardType(.numbersAndPunctuation)
                    Text("\(resultValue)")
                    
                    Button(action: {
                        self.doConversions()
                    })
                    {
                        Text("Convert")
                }.padding()
                Section {
                    HStack {
                        TabView {
                            Picker(selection: $fromTypeSelected, label: Text("")) {
                                ForEach(metricTypes, id: \.self) { type in
                                    Text("\(type)")
                                }
                            }
                            .tabItem {
                                
                                Text("Metric")
                            }
                            Picker(selection: $fromTypeSelected, label: Text("")) {
                                ForEach(usStandardTypes, id: \.self) { type in
                                    Text("\(type)")
                                }
                            }
                            .tabItem {
                                Text("US Standard")
                            }
                        }
                        TabView {
                            Picker(selection: $toTypeSelected, label: Text("")) {
                                ForEach(metricTypes, id: \.self) { type in
                                    Text("\(type)")
                                }
                            }
                            .tabItem {
                                
                                Text("Metric")
                            }
                            Picker(selection: $toTypeSelected, label: Text("")) {
                                ForEach(usStandardTypes, id: \.self) { type in
                                    Text("\(type)")
                                }
                            }
                            .tabItem {
                                Text("US Standard")
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("Conversion Tool"))
                .padding()
        }
    }

    func doConversions() {
        let fromValueAsDouble = Double(fromValue) ?? 0.0
        if  fromTypeSelected != "-" && toTypeSelected != "-" {
            let startValue = Measurement(value: fromValueAsDouble, unit: unitLengths[fromTypeSelected]! )
            self.resultValue = startValue.converted(to: unitLengths[toTypeSelected]!).description
        } else {
            self.resultValue = "0.0"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
