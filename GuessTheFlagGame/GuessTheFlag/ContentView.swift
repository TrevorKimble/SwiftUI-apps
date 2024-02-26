//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Trevor Kimble on 2/21/24.
//

import SwiftUI



struct ContentView: View {
    @State private var showingScore = false
    
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var message = ""

    var body: some View 
    {
        
        ZStack{
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
        
            VStack(spacing: 15){
                VStack{
                    Text("Guess the flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                }
                VStack {
                    Text("Tap the flag of").foregroundStyle(.white).font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer]).foregroundStyle(.white).font(.largeTitle.weight(.semibold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .clipShape(.rect(cornerRadius: 20))
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                    
                }
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
            }
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action:  askQuestion)
        } message: {
                Text("You chose the flag of \(message)")
        }
    }
    
    func flagTapped(_ number: Int)
    {
        message = countries[number]
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        }
        else
        {
            score -= 1
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        var correctAnswer = Int.random(in: 0...2)
    }
}




#Preview {
ContentView()
}
