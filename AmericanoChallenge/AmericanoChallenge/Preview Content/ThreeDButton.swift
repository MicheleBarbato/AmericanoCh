//
//  ThreeDButton.swift
//  AmericanoChallenge
//
//  Created by Michele Barbato on 11/12/24.
//
import SwiftUI

struct ThreeD: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            let offset:  CGFloat = 5
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(Color(red: 28/255, green: 28/255, blue: 28/255))
                .offset(y: offset)
            RoundedRectangle(cornerRadius: 6)
                .foregroundColor(Color(red: 28/255, green: 28/255, blue: 28/255))
                .offset(y: configuration.isPressed ? offset : 0)
            configuration.label
                .offset(y: configuration.isPressed ? offset : 0)
        }
    }
}
struct ThreeDButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("+"){
        }
        .foregroundColor(.white)
        .frame(width: 100, height: 100)
        .buttonStyle(ThreeD())
    }
}
