//
//  spinButton.swift
//  Slots
//
//  Created by Christopher Woods on 10/6/23.
//

import SwiftUI

struct SpinButton: View {
    @Binding var isSpinning: Bool
    @Binding var cardSelect: [Int]
    @Binding var credits: Int
    @Binding var showAlert: Bool
    
    var weights = [2, 2, 1, 1, 3]
    
    func selectWeightedRandomIndex() -> Int {
        // Calculate the total weight
        let totalWeight = weights.reduce(0, +)
        
        // Generate a random number within the total weight
        let randomValue = Int.random(in: 0..<totalWeight)
        
        // Find the symbol index based on the random value and weights
        var cumulativeWeight = 0
        for (index, weight) in weights.enumerated() {
            cumulativeWeight += weight
            if randomValue < cumulativeWeight {
                return index
            }
        }
        
        return 0
}
        
        
        
        
        var body: some View {
            
            Button(action: {
                if credits > 0{
                    credits -= 5
                    if !isSpinning {
                        isSpinning = true
                        
                        // Run the spinning animation multiple times
                        let numberOfSpins = 12 // You can change this to the desired number
                        var spinCount = 0
                        
                        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                            // Update each card's symbol individually
                            for i in 0..<self.cardSelect.count {
                                let newCardSelect = selectWeightedRandomIndex()
                                self.cardSelect[i] = newCardSelect
                            }
                            
                            spinCount += 1
                            
                            if spinCount >= numberOfSpins {
                                // Stop spinning animation after specified spins
                                timer.invalidate()
                                isSpinning = false
                                //Winning lines Logic
                                
                                if cardSelect[0] == cardSelect[1] && cardSelect[1] == cardSelect[2]{
                                    let winningSymbol = cardSelect[0]
                                    credits += 10 * ((4 - weights[winningSymbol]) * (4 - weights[winningSymbol])) }
                                if cardSelect[3] == cardSelect[4] && cardSelect[4] == cardSelect[5]{
                                    let winningSymbol = cardSelect[3]
                                    credits += 10 * ((4 - weights[winningSymbol]) * (4 - weights[winningSymbol])) }
                                if cardSelect[6] == cardSelect[7] && cardSelect[7] == cardSelect[8]{
                                    let winningSymbol = cardSelect[6]
                                    credits += 10 * ((4 - weights[winningSymbol]) * (4 - weights[winningSymbol])) }
                            }
                        }
                        
                    }
                }
                else{
                    showAlert.toggle()
                    
                }
            }) {
                Text("Spin")
                    .font(.system(size: 30))
                    .frame(width: 200)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(20)
            }
            .disabled(isSpinning)
        }
    }

