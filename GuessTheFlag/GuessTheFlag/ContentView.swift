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
            backgroundLayer()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                timerLabel()
                Spacer()
                header()
                countryComponenents()
                Spacer()
                Spacer()
                score()
                Spacer()
            }
            .padding()
        }
        .alert(vm.scoreTitle, isPresented: $vm.showingScore) {
            vm.time <= 0 ?
            Button("Restart", action: vm.restartTheGame) :
            Button("OK", action: vm.askQuestion)

        } message: {
            if vm.time <= 0 {
                Text("The games's over. Your score is \(vm.score)")
            }
           
        }
        
    }
}

#Preview {
    ContentView()
}


extension ContentView {
    private func countryComponenents () -> some View {
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
    }
    
    private func header() -> some View {
        Text("Guess the Flag")
            .font(.largeTitle.bold())
            .foregroundStyle(.white)
    }
    
    private func score() -> some View {
        Text("Score: \(vm.score)")
            .foregroundStyle(.white)
            .font(.title.bold())
    }
    
    private func backgroundLayer() -> some View {
        RadialGradient(  stops : [
            .init(color: Color(red: 0.1 , green : 0.2 , blue : 0.45), location: 0.3),
            .init(color: Color(red: 0.76 , green : 0.15 , blue : 0.26), location: 0.3),
        ] ,center: .top, startRadius: 200, endRadius: 700)
    }
    
    private func timerLabel() -> some View {
        Text("\(vm.time)")
            .font(.largeTitle.bold())
    }
}
