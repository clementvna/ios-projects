//
//  ContentView.swift
//  Edutainment
//
//  Created by Clément Villanueva on 10/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var maxTable = 6
    @State private var minTable = 2
    
    @State private var valueOne = Int.random(in: 2...6)
    @State private var valueTwo = Int.random(in: 2...6)
            
    var questionCountPossible = [5, 10, 20]
    @State private var questionsToAsk = 10
    @State private var questionsCount = 0
    var currentQuestion: String {
        return "What is \(valueOne) X \(valueTwo) ?"
    }
    
    @State private var userAnswer = ""
    @State private var userScore = 0
    
    @State private var isPresentedAlert = false
    
    @FocusState private var valueIsFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Stepper("Tables from 1 to \(maxTable)", value: $maxTable, in: minTable...12, step: 1)
                    }
                    
                    Section {
                        Picker("", selection: $questionsToAsk) {
                            ForEach(questionCountPossible, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("How many questions should be asked?")
                    }
                }
                
                Text(currentQuestion)
                    .font(.title)
                
                TextField("Enter the answer", text: $userAnswer)
                    .keyboardType(.decimalPad)
                    .focused($valueIsFocused)
                
                HStack {
                    Button("Validate") {
                        checkAnswer()
                        userAnswer = ""
                        createQuestion()
                    }
                    
                    Button("Clear") {
                        userAnswer = ""
                    }
                }
                
                Text("Score: \(userScore)")
                    .font(.title)
            }
            .navigationTitle("Multiplication")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
        }
        .alert("End of questions", isPresented: $isPresentedAlert) {
            Button("OK", action: restart)
        } message: {
            Text("Your final score is \(userScore)/\(questionsToAsk)")
        }
    }
    
    func restart() {
        maxTable = 6
        minTable = 2
        questionsToAsk = 10
        questionsCount = 0
        userScore = 0
        isPresentedAlert = false
        
        createQuestion()
    }
    
    func createQuestion() {
        valueOne = Int.random(in: minTable...maxTable)
        valueTwo = Int.random(in: minTable...maxTable)
    }
    
    func checkAnswer() {
        if valueOne * valueTwo == Int(userAnswer) {
            userScore += 1
        } else {
            userScore -= 1
        }
        
        questionsCount += 1
        
        if questionsCount == questionsToAsk {
            isPresentedAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
