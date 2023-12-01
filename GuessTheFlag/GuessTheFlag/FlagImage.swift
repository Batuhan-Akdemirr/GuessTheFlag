//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Batuhan Akdemir on 1.12.2023.
//

import SwiftUI

struct FlagImage : View {
    
    var countryName : String
    var body: some View {
        Image(countryName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}



/*#Preview {
    FlagImage()
} */
