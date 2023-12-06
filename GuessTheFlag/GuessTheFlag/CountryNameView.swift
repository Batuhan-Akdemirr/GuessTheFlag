//
//  CountryNameView.swift
//  GuessTheFlag
//
//  Created by Batuhan Akdemir on 6.12.2023.
//

import SwiftUI

struct CountryNameView: View {
    
    let countryName: String
    var body: some View {
        VStack {
            Text("Tap the flag of")
                .foregroundStyle(.secondary)
                .font(.subheadline.weight(.heavy) )
            
            Text(countryName)
                .font(.largeTitle.weight(.semibold))
        }
    }
}


