//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Batuhan Akdemir on 25.11.2023.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var vm = ContentViewModel()
    
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
                    
                    CountryNameView(countryName: vm.countries[vm.correctAnswer])
                 
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation(.linear(duration: 0.5)) {
                                vm.flagTapped(number)
                                vm.animationAmount += 360
                            }
                           
                            
                        } label: {
                            FlagImage(countryName: vm.countries[number])
                                .rotation3DEffect(.degrees( vm.selectedIndex == number ?  vm.animationAmount : 0.0), axis: (x: 0, y: 1, z: 0))
                                .opacity(vm.selectedIndex != nil && vm.selectedIndex != number ? 0.25 : 1.0)
                                .scaleEffect(vm.selectedIndex != nil && vm.selectedIndex != number ? 0.9 : 1)
                        }
                    }
                }
                
                .frame(maxWidth: .infinity)
                .padding(.vertical , 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(vm.score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(vm.scoreTitle, isPresented: $vm.showingScore) {
            
            vm.answerCount != vm.maxQuestion ? Button("Continue", action: vm.askQuestion) : Button("Restart", action: vm.restartTheGame)
          
        } message: {
            
            vm.answerCount != vm.maxQuestion  ? Text("Your score is \(vm.score)")  :  Text("The games's over. You gave \(vm.score) correct and \(vm.maxQuestion-vm.score) incorrect answers. Your score is \(vm.score)")
        }
        
    }
}

#Preview {
    ContentView()
}
