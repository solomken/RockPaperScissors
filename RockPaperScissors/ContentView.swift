//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anastasiia Solomka on 27.04.2023.
//

import SwiftUI


struct ContentView: View {

    static let moves = ["✊", "✌️", "✋"]
    @State private var moveChoice = moves[Int.random(in: 0..<moves.count)]
    
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var turnCounter = 1
    @State private var showingResults = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                Spacer()
                
                Group {
                    Text("Move: \(moveChoice)")
                    Text("You should: \(shouldWin ? "👍" : "👎")")
                }
                
                
                Spacer()
                Spacer()
                Spacer()
                
                HStack {
                    ForEach(0..<3) { number in
                        Button("\(ContentView.moves[number])") {
                            moveSelected(shouldWin: shouldWin, appChoice: moveChoice, userChoice: ContentView.moves[number])
                        }
                        .padding()
                        .frame(minWidth: 100)
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                    }
                }
                Spacer()
                
                Text("Score: \(score)")
                
                Spacer()
            }
        }
        .font(.title)
        
        .alert("Good job!", isPresented: $showingResults) {
            Button("Start new game", action: newGame)
        } message: {
            Text("Your final score: \(score)")
        }
    }
    
    func newTurn(){
        moveChoice = ContentView.moves[Int.random(in: 0..<ContentView.moves.count)]
        shouldWin = Bool.random()
    }
    
    func moveSelected(shouldWin: Bool, appChoice: String, userChoice: String) {
        turnCounter += 1
        
        if shouldWin &&
            ((appChoice == "✊" && userChoice == "✋") ||
            (appChoice == "✋" && userChoice == "✌️") ||
            (appChoice == "✌️" && userChoice == "✊"))
        {
            score += 1
        } else if shouldWin == false &&
            ((appChoice == "✊" && userChoice == "✌️") ||
            (appChoice == "✋" && userChoice == "✊") ||
            (appChoice == "✌️" && userChoice == "✋"))
        {
            score += 1
        }
        
        if turnCounter == 8 {
            showingResults = true
        }
        
        newTurn()
    }
    
    func newGame(){
        score = 0
        turnCounter = 1
        moveChoice = ContentView.moves[Int.random(in: 0..<ContentView.moves.count)]
        shouldWin = Bool.random()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
