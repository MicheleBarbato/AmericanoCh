//
//  ContentView.swift
//  AmericanoChallenge
//
//  Created by Michele Barbato on 10/12/24.
//

import SwiftUI

struct ContentView: View {
    // Variabile di stato per il contatore
    @State private var counter = 0

    var body: some View {
        VStack {
            Text("Contatore: \(counter)")
                .font(.largeTitle)
                .padding()

            // Pulsanti per incrementare, decrementare e resettare il contatore
            HStack {
                Button(action: {
                    counter += 1
                }) {
                    Text("+")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                Button(action: {
                    counter -= 1
                }) {
                    Text("-")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                Button(action: {
                    counter = 0
                }) {
                    Text("Reset")
                        .font(.title)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
