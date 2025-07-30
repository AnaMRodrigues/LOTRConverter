//
//  SelectCurrency.swift
//  Aula_1
//
//  Created by Ana Clara Moreira Rodrigues on 18/12/24.
//

import SwiftUI

struct SelectCurrency: View {
    @Environment(\.dismiss) var dismiss
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency

    var body: some View {
        ZStack {
            //parchment background image
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)

            VStack {
                //text
                Text("Select the currency you're starting with:")
                    .fontWeight(.bold)

                //currency icons
                IconGrid(selectedCurrency: $topCurrency)

                //text
                Text("Select the currency you would like to convert to:")
                    .fontWeight(.bold)
                    .padding(.top)

                //currency icons
                IconGrid(selectedCurrency: $bottomCurrency)

                //done button
                Button("Done") {
                    //Dismiss function
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
            
            //corrects the color of the text in the dark mode
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    @Previewable @State var topCurrency: Currency = .silverPenny
    @Previewable @State var bottomCurrency: Currency = .goldPenny
    SelectCurrency(topCurrency: $topCurrency, bottomCurrency: $bottomCurrency)
}
