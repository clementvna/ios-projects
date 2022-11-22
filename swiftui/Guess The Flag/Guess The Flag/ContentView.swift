//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Clément Villanueva on 17/09/2022.
//

import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .shadow(radius: 5.0)
    }
}

extension View {
    func flagImage() -> some View {
        modifier(FlagImage())
    }
}

struct ContentView: View {
    @State private var showingCurrentScore = false
    @State private var showingFinalScore = false
    
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionCount = 0
    
    @State private var rotationAmount = 0.0
    @State private var opacityAmount = 1.0
    
    @State private var countries = ["Estonia", "France", "Germany", "Italy", "Russia", "US", "Nigeria", "Ireland", "Poland", "Spain", "UK"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
        
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.3, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.15, green: 0.45, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .flagImage()
                        }
                        .rotation3DEffect(
                            .degrees(number == correctAnswer ? rotationAmount : 0),
                            axis: (x:0, y: 1, z: 0)
                        )
                        .opacity(number == correctAnswer ? 1 : opacityAmount)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingCurrentScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score).")
        }
        .alert(scoreTitle, isPresented: $showingFinalScore) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(score)/8.")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Right"
            score += 1
            
            rotationAmount = 0
            withAnimation {
                rotationAmount = 360
            }
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])."
            score -= 1
            
            opacityAmount = 1
            withAnimation {
                opacityAmount = 0.25
            }
        }
        
        questionCount += 1
        
        if questionCount == 8 {
            showingFinalScore = true
        } else {
            showingCurrentScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<2)
        
        opacityAmount = 1
    }
    
    func restartGame() {
        questionCount = 0
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
