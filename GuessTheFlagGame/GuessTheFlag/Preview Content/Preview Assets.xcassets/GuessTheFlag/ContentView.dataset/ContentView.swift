//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Trevor Kimble on 2/21/24.
//

import SwiftUI



struct ContentView: View {
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    var correctAnswer = Int.random(in: 0...2)

    var body: some View 
    {
        VStack(spacing: 30){
            
            VStack {
                Text("Tap the flag of")
                Text(countries[correctAnswer])
            }
            
            ForEach(0..<3) { number in
                Button {
                    
                } label: {
                    Image(countries[number])
                }
                
            }
        }
    }
}




#Preview {
ContentView()
}
