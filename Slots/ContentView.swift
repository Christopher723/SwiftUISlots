//
//  ContentView.swift
//  Slots
//
//  Created by Christopher Woods on 10/6/23.
//

import SwiftUI

struct ContentView: View {
    var cards = ["apple", "lemon","diamond", "seven", "bar"]
    
    @State var cardSelect = [0, 0, 0,
                             0, 0, 0,
                             0, 0, 0]
    @State var isSpinning = false
    
    @State var credits = 100
    @State var showAlert = false
    
    init() {
            // Initialize the cardSelect array with random values
            _cardSelect = State(initialValue: (0..<9).map { _ in Int.random(in: 0..<cards.count) })
        }
 
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
                .ignoresSafeArea()
            
            Rectangle()
                .foregroundColor(.teal)
                .ignoresSafeArea()
                .frame(width: 350,height: 1000)
                .rotationEffect(Angle(degrees: 220))
            
            
            VStack{
                Spacer()
                HStack{
                    Text("IPhone Slots")
                        .font(.system(size:60))
                        .foregroundColor(.white)
                }.padding()
                
                HStack{
                    Text("Credits: " + String(credits))
                        .font(.system(size:40))
                        .foregroundColor(.white)
                }
                
                Spacer().frame(height:40)
                HStack{
                    CardView(imageName: cards[cardSelect[0]])
                    CardView(imageName: cards[cardSelect[1]])
                    CardView(imageName: cards[cardSelect[2]])
                        
                }
                HStack{
                    CardView(imageName: cards[cardSelect[3]])
                    CardView(imageName: cards[cardSelect[4]])
                    CardView(imageName: cards[cardSelect[5]])
                        
                }
                HStack{
                    CardView(imageName: cards[cardSelect[6]])
                    CardView(imageName: cards[cardSelect[7]])
                    CardView(imageName: cards[cardSelect[8]])
                        
                }
                Spacer().frame(height:40)
                SpinButton(isSpinning: $isSpinning, cardSelect: $cardSelect, credits: $credits, showAlert: $showAlert)
                Spacer()
                
                
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("NO MONEY")
                    .font(.system(size: 20)),
                message: Text("You ran out of money? Want to buy more credits?"),
                dismissButton: .default(Text("YEA"), action: {
                            credits+=100
                        }))

            
        }
        
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 85, height: 85)
            .padding()
            .background(Color.white.opacity(0.5))
            .cornerRadius(20)
    }
}

