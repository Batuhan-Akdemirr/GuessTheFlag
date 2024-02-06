//
//  ContentViewModel.swift
//  GuessTheFlag
//
//  Created by Batuhan Akdemir on 6.02.2024.
//

import Foundation

class ContentViewModel : ObservableObject {
    
    @Published var countries = ["Estonia", "France" , "Germany" , "Ireland" , "Italy" , "Nigeria" , "Poland", "Spain" , "UK" , "Ukraine" , "US", "Turkiye", "Netherlands", "Switzerland" , "Russia", "Sweden", "Portugal", "Norway", "India", "Albenia", "Japan" , "China", "Canada", "Argentina", "Australia" , "South Korea" , "Brasil", "South Africa", "Morocco" , "Chile", "Tanzania","Azerbaijan","Georgia","Iran","Ghana","Thailand","Peru","New Zealand","Mexico","Egypt","Finland","Saudi Arabia","Columbia","Vietnam","Scotland"].shuffled()
    
    @Published  var correctAnswer = Int.random(in: 0...2)
    @Published  var showingScore = false
    @Published  var scoreTitle = ""
    @Published  var score = 0
    @Published  var answerCount = 0
    @Published  var selectedIndex : Int?
    @Published  var animationAmount = 1.0
    @Published  var isOpacity  = false
    
    let maxQuestion = 15
    
    
    func flagTapped(_ number: Int) {
         
         if answerCount != maxQuestion {
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
