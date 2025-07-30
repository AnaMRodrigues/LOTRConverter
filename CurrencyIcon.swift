//
//  CurrencyIcon.swift
//  Aula_1
//
//  Created by Ana Clara Moreira Rodrigues on 18/12/24.
//

import SwiftUI

struct CurrencyIcon: View {
    let currencyImage: ImageResource
    let currencyName: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            //currency image
            Image(currencyImage)
                .resizable()
                .scaledToFit()
            
            //currency name
            Text(currencyName)
                .padding(3)
                .font(.caption)
            //stretches to the border of the parent
                .frame(maxWidth: .infinity)
                .background(.brown.opacity(0.75))
        }
        .padding(3)
        .frame(width: 100, height: 100)
        .background(.brown)
        .cornerRadius(25)
    }
}

#Preview {
    ForEach(Currency.allCases) { currency in
        CurrencyIcon(currencyImage: currency.image, currencyName: currency.name)
    }
}
