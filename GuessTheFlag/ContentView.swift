//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yannick Severo on 06/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingResult = false
    @State private var scoreTitle = ""
    @State private var userTotalScore = 0
    @State private var userGamesPlayed = 0
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            userGamesPlayed += 1
            userTotalScore += 1
            scoreTitle = "Correct"
        } else {
            userGamesPlayed += 1
            scoreTitle = "Wrong"
        }
        showingResult = userGamesPlayed > 9
        showingScore = userGamesPlayed < 10
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            if(!showingResult) {
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.white)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.white)
                    }
                    
                    ForEach(0..<3) { number in
                        Button { flagTapped(number) }
                        label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text("Your score is \(userTotalScore)/\(userGamesPlayed) ")
                }
            } else {
                Text("Your result is \(userTotalScore)/\(userGamesPlayed)")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.title)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
