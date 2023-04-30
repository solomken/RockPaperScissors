//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anastasiia Solomka on 27.04.2023.
//

//link to task: https://www.hackingwithswift.com/guide/ios-swiftui/2/3/challenge

import SwiftUI


struct ContentView: View {
    static let moves = ["✊", "✋", "✌️"]
    
    @State private var computerChoice = moves[Int.random(in: 0..<moves.count)]
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var questionCount = 1
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
                    Text("Computer has played...")
                    Text("\(computerChoice)")
                        .font(.system(size: 100))
                    
                    if shouldWin {
                        Text("Which one wins?")
                            .foregroundColor(.green)
                    } else {
                        Text("Which one loses?")
                            .foregroundColor(.red)
                    }
                }
                
                Spacer()
                
                HStack {
                    ForEach(0..<3) { number in
                        Button("\(ContentView.moves[number])") {
                            play(shouldWin: shouldWin, appChoice: computerChoice, userChoice: ContentView.moves[number])
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
        let newMove = ContentView.moves[Int.random(in: 0..<ContentView.moves.count)]
        let newShouldWin = Bool.random()
        
        if computerChoice == newMove && shouldWin == newShouldWin {
            newTurn()
        } else {
            computerChoice = newMove
            shouldWin = newShouldWin
        }
    }
    
    func play(shouldWin: Bool, appChoice: String, userChoice: String) {
        questionCount += 1
        
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
        
        if questionCount == 8 {
            showingResults = true
        }
        
        newTurn()
    }
    
   /*
    Courses version:
    @State private var computerChoice = Int.random(in: 0..<3)
    
    func play2(choice: Int){
        let winningMoves = [1, 2, 0] //rock can be beaten by paper which has index 2 in moves array. paper loses to scissors which is index 2 and scissors loses to rock - index 0
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
    }
    */
    
    func newGame(){
        score = 0
        questionCount = 1
        computerChoice = ContentView.moves[Int.random(in: 0..<ContentView.moves.count)]
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
