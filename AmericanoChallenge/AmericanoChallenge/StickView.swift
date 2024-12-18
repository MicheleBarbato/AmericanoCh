//
//  StickView.swift
//  AmericanoChallenge
//
//  Created by Michele Barbato on 12/12/24.
//

import SwiftUI

struct StickView: View {
    var body: some View {
       
        ZStack{
          
            animationSequence().offset(x:6, y: 196)
        }
    
    }
}

//create array for images

var images : [UIImage]! = [
    UIImage(named: "image-1")!,
    UIImage(named: "image-2")!,
    UIImage(named: "image-3")!,
    UIImage(named: "image-4")!,
    UIImage(named: "image-5")!,
    UIImage(named: "image-6")!,
    UIImage(named: "image-7")!,
    UIImage(named: "image-8")!,
    UIImage(named: "image-9")!,
    UIImage(named: "image-10")!,
    UIImage(named: "image-11")!,
    UIImage(named: "image-12")!,
    UIImage(named: "image-13")!,
    UIImage(named: "image-14")!,
    UIImage(named: "image-15")!

]

let animatedImages = UIImage.animatedImage(with: images!, duration: 1.2)?.withHorizontallyFlippedOrientation()


struct animationSequence : UIViewRepresentable{
    
    
    func makeUIView(context: Context) -> UIView {
        
        let seqAnimview = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        let seqImage = UIImageView(frame: CGRect(x: 140, y: 100, width: 100, height: 100))
        seqImage.clipsToBounds = true
        seqImage.layer.cornerRadius = 20
        seqImage.autoresizesSubviews = true
        seqImage.contentMode = UIView.ContentMode.scaleAspectFit
        seqImage.image = animatedImages
        seqAnimview.addSubview(seqImage)
        return seqAnimview
        
        
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<animationSequence>) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StickView()
    }
}











