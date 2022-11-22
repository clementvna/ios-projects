//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Clément Villanueva on 22/09/2022.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
}

struct SubtitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
    }
}

struct ChoiceButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(.horizontal, 30)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(TitleStyle())
    }
    
    func subtitleStyle() -> some View {
        modifier(SubtitleStyle())
    }
    
    func choiceButtonStyle() -> some View {
        modifier(ChoiceButtonStyle())
    }
}

struct ContentView: View {
    let choices = ["ROCK", "PAPER", "SCISSORS"]
    
    @State private var playerScore = 0
    @State private var scorePresented = false
    
    @State private var roundCount = 0
    
    @State private var appChoice = "ROCK"
    @State private var playerChoice = "ROCK"
    @State private var playerWins = Bool.random()
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.3, blue: 0.45), location: 0.3), .init(color: Color(red: 0.15, green: 0.45, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
            VStack {
                Spacer()
                
                Text(appChoice)
                    .titleStyle()
                
                if playerWins {
                    Text("You should win.")
                        .subtitleStyle()
                } else {
                    Text("You should loose.")
                        .subtitleStyle()
                }
                
                Spacer()
                Spacer()
                
                HStack {
                    Group {
                        Button {
                            playerChoice = "ROCK"
                            check()
                            newRound()
                        } label: {
                            Image(systemName: "cloud.fill")
                        }
                        
                        Button {
                            playerChoice = "PAPER"
                            check()
                            newRound()
                        } label: {
                            Image(systemName: "doc.fill")
                        }
                        
                        Button {
                            playerChoice = "SCISSORS"
                            check()
                            newRound()
                        } label: {
                            Image(systemName: "scissors")
                        }
                    }
                    .choiceButtonStyle()
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Text("Score: \(playerScore)")
                    .subtitleStyle()
                
                Spacer()
            }
            .padding()
            .alert("Score", isPresented: $scorePresented) {
                Button("Restart") {
                    newGame()
                }
            } message: {
                Text("Your final score is \(playerScore)")
            }
            .font(.largeTitle)
        }
    }
    
    func newRound() {
        if (roundCount == 10) {
            scorePresented.toggle()
        }
        
        appChoice = choices[Int.random(in: 0...2)]
        playerWins.toggle()
    }
    
    func newGame() {
        newRound()
        roundCount = 0
        playerScore = 0
    }
    
    func check() {
        if playerWins {
            if appChoice == "ROCK" && playerChoice == "PAPER" ||
                appChoice == "PAPER" && playerChoice == "SCISSORS" ||
                appChoice == "SCISSORS" && playerChoice == "ROCK" {
                playerScore += 1
            } else {
                playerScore -= 1
            }
        } else {
            if appChoice == "ROCK" && playerChoice == "SCISSORS" ||
                appChoice == "PAPER" && playerChoice == "ROCK" ||
                appChoice == "SCISSORS" && playerChoice == "PAPER" {
                playerScore += 1
            } else {
                playerScore -= 1
            }
        }
        
        roundCount += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
