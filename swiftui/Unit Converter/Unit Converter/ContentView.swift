//
//  ContentView.swift
//  Unit Converter
//
//  Created by Clément Villanueva on 16/09/2022.
//

import SwiftUI

struct ContentView: View {
    let dataTypes = ["Temperature", "Length", "Time", "Volume"]
    
    let temperatureUnits = ["Celcius", "Farenheit", "Kelvin"]
    let lengthUnits = ["Meter", "Foot", "Yard", "Mile"]
    let timeUnits = ["Second", "Minute", "Hour", "Day"]
    let volumeUnits = ["Milliliter", "Liter", "Cup", "Pint", "Gallon"]
    
    @FocusState private var valueIsFocused: Bool
    
    @State private var value: Double = 0.0
    @State private var currentUnit: String = "Celcius"
    @State private var conversionUnit: String = "Celcius"
    @State private var currentDataType: String = "Temperature"
    
    var dataTypeUnits: [String] {
        switch currentDataType {
        case "Temperature":
            return temperatureUnits
        case "Length":
            return lengthUnits
        case "Time":
            return timeUnits
        case "Volume":
            return volumeUnits
        default:
            return temperatureUnits
        }
    }
    
    var valueConversion: Double {
        let conversion = (currentUnit, conversionUnit)
        switch currentDataType {
        case "Temperature":
            switch conversion {
            case ("Celcius", "Farenheit"):
                return value * 1.8 + 32
            case ("Celcius", "Kelvin"):
                return value + 273.15
            case ("Farenheit", "Celcius"):
                return (value - 32) / 1.8
            case ("Farenheit", "Kelvin"):
                return (value - 32) / 1.8 + 273.15
            case ("Kelvin", "Celcius"):
                return value - 273.15
            case ("Kelvin", "Farenheit"):
                return (value - 273.15) * 1.8 + 32
            default:
                return value
            }
        case "Length":
            switch conversion {
            case ("Meter", "Foot"):
                return value * 3.2808
            case ("Meter", "Yard"):
                return value * 1.0936
            case ("Meter", "Mile"):
                return value * 0.00062137
            case ("Foot", "Meter"):
                return value / 3.2808
            case ("Foot", "Yard"):
                return value * 0.33333
            case ("Foot", "Mile"):
                return value * 0.00018939
            case ("Yard", "Meter"):
                return value / 1.0936
            case ("Yard", "Foot"):
                return value * 3
            case ("Yard", "Mile"):
                return value * 0.00056818
            case ("Mile", "Meter"):
                return value / 0.00062137
            case ("Mile", "Foot"):
                return value * 5280
            case ("Mile", "Yard"):
                return value * 1760
            default:
                return value
            }
        case "Time":
            switch conversion {
            case ("Second", "Minute"):
                return value / 60
            case ("Second", "Hour"):
                return value / 3600
            case ("Second", "Day"):
                return value / 86400
            case ("Minute", "Second"):
                return value * 60
            case ("Minute", "Hour"):
                return value / 60
            case ("Minute", "Day"):
                return value / 1440
            case ("Hour", "Second"):
                return value * 3600
            case ("Hour", "Minute"):
                return value * 60
            case ("Hour", "Day"):
                return value * 24
            default:
                return value
            }
        case "Volume":
            switch conversion {
            case ("Milliliter", "Liter"):
                return value / 1000
            case ("Milliliter", "Cup"):
                return value * 0.0042268
            case ("Milliliter", "Pint"):
                return value * 0.0021134
            case ("Milliliter", "Gallon"):
                return value * 0.00026417
            case ("Liter", "Milliliter"):
                return value * 1000
            case ("Liter", "Cup"):
                return value * 4.2268
            case ("Liter", "Pint"):
                return value * 2.1134
            case ("Liter", "Gallon"):
                return value * 0.26417
            case ("Cup", "Milliliter"):
                return value / 0.0042268
            case ("Cup", "Liter"):
                return value / 4.2268
            case ("Cup", "Pint"):
                return value / 2
            case ("Cup", "Gallon"):
                return value * 0.062500
            case ("Pint", "Milliliter"):
                return value / 0.0021134
            case ("Pint", "Liter"):
                return value / 2.1134
            case ("Pint", "Cup"):
                return value * 2
            case ("Pint", "Gallon"):
                return value * 0.12500
            case ("Gallon", "Milliliter"):
                return value / 0.00026417
            case ("Gallon", "Liter"):
                return value / 0.26417
            case ("Gallon", "Cup"):
                return value * 16
            case ("Gallon", "Pint"):
                return value * 6.8749
            default:
                return value
            }
        default:
            return value
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Data type", selection: $currentDataType) {
                    ForEach(dataTypes, id: \.self) {
                        Text($0)
                    }
                }
                Section {
                    TextField("Value", value: $value, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                    
                    Picker("Unit", selection: $currentUnit) {
                        ForEach(dataTypeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(valueConversion, format: .number)
                    
                    Picker("Unit", selection: $conversionUnit) {
                        ForEach(dataTypeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text(currentDataType)
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        valueIsFocused = false
                    }
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
