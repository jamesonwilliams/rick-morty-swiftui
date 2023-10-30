//
//  ErrorUI.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/25/23.
//

import SwiftUI

struct ErrorUI: View {
    let message: String
    
    var body: some View {
        Text(message)
            .padding()
    }
}

#Preview {
    ErrorUI(message: "Failed to load!")
}
