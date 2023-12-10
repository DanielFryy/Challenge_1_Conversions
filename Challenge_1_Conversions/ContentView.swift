//
//  ContentView.swift
//  Challenge_1_Conversions
//
//  Created by Daniel Freire on 12/9/23.
//

import SwiftUI

enum TemperatureUnits: String {
    case Celcius, Farenheit, Kelvin
}

struct ContentView: View {
    @State private var inputTemperatureUnit: TemperatureUnits = .Celcius
    @State private var outputTemperatureUnit: TemperatureUnits = .Celcius
    @State private var temperatureValue = 0.0
    @FocusState private var temperatureValueFocused: Bool
    
    let temparatureUnits: [TemperatureUnits] = [.Celcius, .Farenheit, .Kelvin]
    
    var temperatureUnitSymbol: String {
        switch outputTemperatureUnit {
        case .Celcius:
            return "°C"
        case .Farenheit:
            return "°F"
        case .Kelvin:
            return "K"
        }
    }
    
    var convertedTemperature: Double {
        if inputTemperatureUnit == outputTemperatureUnit {
            return temperatureValue
        }
        switch inputTemperatureUnit {
        case .Celcius:
            switch outputTemperatureUnit {
            case .Celcius:
                return temperatureValue
            case .Farenheit:
                // F = C(9⁄5) + 32
                return temperatureValue * 9 / 5 + 32
            case .Kelvin:
                // K = C + 273.15
                return temperatureValue + 273.15
            }
        case .Farenheit:
            let celsiusTemperature = (temperatureValue - 32) * 5 / 9
            switch outputTemperatureUnit {
            case .Celcius:
                // C = (F − 32) × 5⁄9
                return celsiusTemperature
            case .Farenheit:
                return temperatureValue
            case .Kelvin:
                // K = (F − 32) × 5⁄9 + 273.15
                return celsiusTemperature + 273.15
            }
        case .Kelvin:
            let kelvinTemperature = temperatureValue - 273.15
            switch outputTemperatureUnit {
            case .Celcius:
                // C = K − 273.15
                return kelvinTemperature
            case .Farenheit:
                // F = (K – 273.15) × 9⁄5 + 32
                return kelvinTemperature * 9 / 5 + 32
            case .Kelvin:
                return temperatureValue
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose the input unit") {
                    Picker("Temperature units", selection: $inputTemperatureUnit) {
                        ForEach(temparatureUnits, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    TextField("Temperature value", value: $temperatureValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($temperatureValueFocused)
                }
                Section("Choose the output unit") {
                    Picker("Temperature units", selection: $outputTemperatureUnit) {
                        ForEach(temparatureUnits, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(convertedTemperature, format: .number)
                }
            }
            .navigationTitle("Conversions")
            .toolbar {
                if temperatureValueFocused {
                    Button("Done") {
                        temperatureValueFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
