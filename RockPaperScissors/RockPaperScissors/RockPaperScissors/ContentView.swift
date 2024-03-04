//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Trevor Kimble on 2/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var userChoice = ""
    @State private var computerChoice = ""
    @State private var message = ""
    @State private var pwins = 0
    @State private var cwins = 0
    @State private var ties = 0
    @State private var numSimulations = 1
    
    private var choices = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        ZStack
        {
            LinearGradient(colors: [.blue, .green], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack(spacing: 50)
            {

                VStack
                {
                    Text("Player Wins: \(pwins)")
                    Text("Computer Wins: \(cwins)")
                    Text("Ties: \(ties)")
                }
      
                VStack {
                    Text("You  |  Computer")
                    Text("\(userChoice) vs \(computerChoice)")
                    Text(message)
                }

                VStack {
                    
                    Button("Rock")
                    {
                        calculateRound(userMove: 0)
                    }
                    .foregroundColor(.black)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    
                    
                    Button("Paper")
                    {
                        calculateRound(userMove: 1)
                    }
                    .foregroundColor(.black)
                    .padding()
                    .border(Color.black)
                    
                    
                    Button("Scissors")
                    {
                        calculateRound(userMove: 2)
                    }
                    .foregroundColor(.black)
                    .padding()
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                }
          
                VStack{
                    Text("Run x simulations")
                    Picker("test", selection: $numSimulations){
                        Text("1").tag(1)
                        Text("10").tag(10)
                        Text("100").tag(100)
                        Text("1000").tag(1000)
                        Text("10,000").tag(10000)
                        Text("100,000").tag(100000)
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
        
    func calculateRound(userMove: Int)
    {
        DispatchQueue.global().async
        {
            for _ in 0..<numSimulations
            {
                DispatchQueue.main.async {
                    let computerMove = Int.random(in: 0..<3)
                    computerChoice = choices[computerMove]
                    userChoice = choices[userMove]
                    if userMove == computerMove
                    {
                        ties += 1
                        message = "Nobody wins Nobody loses its a tie"
                    }
                    else if (userMove > computerMove && !(userMove == 2 && computerMove == 0)) || (userMove == 0 && computerMove == 2)
                    {
                        pwins += 1
                        message = "Wow you won"
                    }
                    else
                    {
                        cwins += 1
                        message = "HAHA you lost"
                    }
                }
                if(numSimulations <= 100)
                {
                    Thread.sleep(forTimeInterval:  0.1)
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
