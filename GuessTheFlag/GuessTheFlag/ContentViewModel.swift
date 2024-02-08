//
//  ContentViewModel.swift
//  GuessTheFlag
//
//  Created by Batuhan Akdemir on 6.02.2024.
//

import Combine
import Foundation
import SwiftUI

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
    
    @Published var time = 30
    let timeAmount = 30
    
    var cancellables = Set<AnyCancellable>()
 
    init() {
        setupTimer()
    }
    
    
    func flagTapped(_ number: Int) {
         
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 2
            selectedIndex = number
            isOpacity = true
            time += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                self.askQuestion()
            }
            
        } else {
            showingScore = true
            scoreTitle = "Wrong !! That's flag of  \(countries[number])"
            time -= 3
        }
        
        answerCount += 1
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
       time = timeAmount
       setupTimer()
    }
    
    private func setupTimer()  {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else {return}
                self.time -= 1
                if time <= 0 {
                    showingScore = true
                    for item in self.cancellables { item.cancel() }
                }
            }
            .store(in: &cancellables)
    }
        
}
