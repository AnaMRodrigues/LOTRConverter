//
//  ContentView.swift
//  Aula_1
//
//  Created by Ana Clara Moreira Rodrigues on 14/12/24.
//

import SwiftUI
import TipKit

struct ContentView: View {
    //let doesn`t allow to change the value
    //if it will change, set to "@State var"
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    //looks diferent but are the same thing
    @State var leftCurrency = Currency.silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    let currencyTip = CurrencyTip()

    var body: some View {
        ZStack {
            //Background Image (.name) or ("name")
            //.name is the best option. If it is spelled wrong, the code doesn`t compile.
            //if "name" is spelled wrong, the image doesn`t show, but you do not know where the problem is.
            Image(.background)
                //To fit in the screen
                .resizable()
                //Remove white spaces
                //Safe areas are the spaces for Home bar (bottom) and the Time, Wifi, Battery (top)
                //.edgesIgnoringSafeArea(.all) or .ignoresSafeArea
                .edgesIgnoringSafeArea(.all)

            VStack {
                //Prancing pony image
                Image(.prancingpony)
                    .resizable()
                    //Fitting the image maintaining the original width and height ratio
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.bottom, 15.0)

                //Title
                Text("Currency Exchange")
                    .font(.largeTitle)
                    //To change the text color - .foregroundColor(Color.white) or .foregroundStyle(.white)
                    .foregroundStyle(.white)
                    .padding(.bottom, 15.0)

                //Conversion Section
                HStack {
                    //Left conversion section
                    VStack(alignment: .center) {
                        HStack {
                            //Curency Image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33.0)
                                .padding(.bottom, 6.0)

                            //Currency Text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)

                        }
                        .padding(.bottom, -5.0)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .popoverTip(currencyTip, arrowEdge: . bottom)

                        //Amount field
                        //Use $ to reference to a variable
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .keyboardType(.decimalPad)
                            .scrollDismissesKeyboard(.immediately)

                        //.padding(7.0)
                        //.background(Color.white)
                        //.cornerRadius(10.0)
                        //.font(.headline)
                    }

                    // Equal Sign
                    //To use SF Symbols, use systemName inside the Image parentesis
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)

                    //Right Conversion section
                    VStack {
                        HStack {
                            //Currency Text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)

                            //Currency Image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33.0)
                                .padding(.bottom, 6.0)
                        }
                        .padding(.bottom, -5.0)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }

                        //Amount field
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            //alignment in the right side of the text field
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                            .keyboardType(.decimalPad)

                        //.padding(7.0)
                        //.cornerRadius(10.0)
                        //.multilineTextAlignment(.trailing)
                        //.font(.headline)
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .cornerRadius(30.0)

                //Space between the views, without pushing them of the screen and the safe area
                Spacer()

                HStack {
                    Spacer()

                    //Info button
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                        //  .onTapGesture {
                        //
                        //  }
                    }
                    .padding(.trailing, 25.0)
                    .padding(.bottom, 10.0)
                }
            }
        }
        .task {
            try? Tips.configure()
        }
        .onChange(of: leftAmount) {
            if leftTyping {
                //first argument name isn`t neeeded because it`s a _
                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
            }
        }
        .onChange(of: rightAmount) {
            if rightTyping {
                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
            }
        }
        .onChange(of: leftCurrency){
            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
        }
        .onChange(of: rightCurrency){
            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
        }
        //modal screen that don't covers the whole screen
        .sheet(isPresented: $showExchangeInfo) {
            ExchangeInfo()
        }
        .sheet(isPresented: $showSelectCurrency) { SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    ContentView()
}

// extentension to hide the keyboard
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
