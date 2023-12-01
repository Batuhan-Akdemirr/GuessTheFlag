//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Batuhan Akdemir on 25.11.2023.
//

import SwiftUI


struct ContentView: View {
    
   @State private  var countries = ["Estonia", "France" , "Germany" , "Ireland" , "Italy" , "Nigeria" , "Poland", "Spain" , "UK" , "Ukraine" , "US", "Turkiye", "Netherlands", "Switzerland" , "Russia", "Sweden", "Portugal", "Norway", "India", "Albenia", "Japan" , "China", "Canada", "Argentina", "Australia" , "South Korea" , "Brasil"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var answerCount = 0
    @State private var selectedIndex : Int?
    @State private var animationAmount = 1.0
    @State private var isOpacity  = false
    
    
    var body: some View {
    
        ZStack {
            RadialGradient(  stops : [
                .init(color: Color(red: 0.1 , green : 0.2 , blue : 0.45), location: 0.3),
                .init(color: Color(red: 0.76 , green : 0.15 , blue : 0.26), location: 0.3),
            ] ,center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing:15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy) )
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation(.linear(duration: 0.5)) {
                                flagTapped(number)
                                    animationAmount += 360
                            }
                           
                            
                        } label: {
                            FlagImage(countryName: countries[number])
                                .rotation3DEffect(.degrees( selectedIndex == number ?  animationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
                                 .opacity(selectedIndex != nil && selectedIndex != number ? 0.25 : 1.0)
                                 .scaleEffect(selectedIndex != nil && selectedIndex != number ? 0.9 : 1)
                        }
                    }
                }
                
                .frame(maxWidth: .infinity)
                .padding(.vertical , 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            
            answerCount != 15 ? Button("Continue", action: askQuestion) : Button("Restart", action: restartTheGame)
          
        } message: {
            
            answerCount != 15  ? Text("Your score is \(score)")  :  Text("The games's over. You gave \(score) correct and \(15-score) incorrect answers. Your score is \(score)")
        }
        
    }
    
    func flagTapped(_ number: Int) {
         
         if answerCount != 15 {
             if number == correctAnswer {
                 scoreTitle = "Correct"
                 score += 1
                 selectedIndex = number
                 isOpacity = true
                 
             } else {
                 scoreTitle = "Wrong !! That's flag of  \(countries[number])"
             }
             
             answerCount += 1
             showingScore = true
         }
     }

    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedIndex = nil
        animationAmount = 1.0
    }
    
   func restartTheGame()  {
       score = 0
       answerCount = 0
       countries.shuffle()
       correctAnswer = Int.random(in: 0...2)
       isOpacity = false
       selectedIndex = nil
    }
}

/*#Preview {
    ContentView()
}*/
