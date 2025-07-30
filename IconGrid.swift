//
//  IconGrid.swift
//  Aula_1
//
//  Created by Ana Clara Moreira Rodrigues on 18/12/24.
//

import SwiftUI

struct IconGrid: View {
    @Binding var selectedCurrency: Currency

    var body: some View {
        //Lazy... only loads what is on screen
        //Not lazy... loads everything at once
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            // _ in don't save the value of the loop
            // loop in saves the value to use in the middle of the loop
            ForEach(Currency.allCases) { currency in
                //if the names are the same, to reference to the proprierty created outside the body, just type self.(name of the proprierty)
                if selectedCurrency == currency {
                    CurrencyIcon(currencyImage: currency.image,
                                 currencyName: currency.name)
                    .shadow(color: .black, radius: 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(lineWidth: 3)
                            .opacity(0.5)
                    }
                } else {
                    CurrencyIcon(currencyImage: currency.image,
                                 currencyName: currency.name)
                    //on tap gesture is only in the not selected currency 'cause there`s no reason to tap a already selected currency
                    .onTapGesture {
                        //when tapped, the role screen refreshes to show the new selected currency
                        self.selectedCurrency = currency
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedCurrency: Currency = .silverPiece
    IconGrid(selectedCurrency: $selectedCurrency)
}
