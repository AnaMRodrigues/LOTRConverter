//
//  Currency.swift
//  Aula_1
//
//  Created by Ana Clara Moreira Rodrigues on 19/12/24.
//
import SwiftUI

// CaseIterable turn the enum into a collection/array
enum Currency: Double, CaseIterable, Identifiable {
    
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    //or var id: Double { rawValue }
    var id: Currency { self }
    
    
    var image: ImageResource {
        switch self {
        case .copperPenny:
                .copperpenny
        case .silverPenny:
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPenny:
                .goldpenny
        case .goldPiece:
                .goldpiece
        }
    }
    
    var name: String {
        switch self {
        case .copperPenny:
            "Copper Penny"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        }
    }
    
    //two names for the same value. One is for when it`s called and the other is the label that will be used in the function
    func convert(_ amountString: String, to currency: Currency) -> String {
        guard let doubleAmount = Double(amountString) else {
            return ""
        }
        
        let convertedAmount = (doubleAmount / self.rawValue) * currency.rawValue
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        //print(formatter.string(from: NSNumber(value: convertedAmount)) ?? "")
        return formatter.string(from: NSNumber(value: convertedAmount)) ?? ""
        
        //defining how many decimal numbers will show
        //return String(format: "%.2f", convertedAmount)
    }
}
