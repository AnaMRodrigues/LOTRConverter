//
//  ExchangeRate.swift
//  Aula_1
//
//  Created by Ana Clara Moreira Rodrigues on 18/12/24.
//

import SwiftUI

struct ExchangeRate: View {
    //proprierties
    let leftImage: ImageResource
    let text: String
    let rightImage: ImageResource
    
    var body: some View {
        HStack {
            //left image
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            //exchange text
            Text(text)
            
            //Right image
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpiece, text: "1 Gold Piece = 4 Gold Pennies", rightImage: .goldpenny)
    
    ExchangeRate(leftImage: .goldpenny, text: "1 Gold Penny = 4 Silver Pieces", rightImage: .silverpiece)
    
    ExchangeRate(leftImage: .silverpiece, text: "1 Silver Piece = 4 Silver Pennies", rightImage: .silverpenny)
    
    ExchangeRate(leftImage: .silverpenny, text: "1 Silver Penny = 100 Copper Pennies", rightImage: .copperpenny)
}
