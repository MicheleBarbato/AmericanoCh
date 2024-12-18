import SwiftUI

struct AnimatedTextView: View {
    @State private var moveGradient = false
    @State private var offsetX: CGFloat = 0
    
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
      
        VStack {
            Spacer()
            // Top part with scrolling image animation
            
            GeometryReader { geometry in
                
                
                ZStack {
                    
                    HStack(spacing: 0)
                    {
                        
                        Image("Sfondo") // First image
                            .resizable()
                            .scaledToFit() // Usa questo per evitare distorsioni
                            .frame(width: screenWidth) // Fix the width to screenWidth
                            .offset(x: offsetX) // Apply the offset
                        
                        Image("Sfondo") // Second image
                            .resizable()
                            .scaledToFit() // Usa questo per evitare distorsioni
                            .frame(width: screenWidth) // Fix the width to screenWidth
                            .offset(x: offsetX) // Apply the offset
                        
                        Image("Sfondo") // Third image
                            .resizable()
                            .scaledToFit() // Usa questo per evitare distorsioni
                            .frame(width: screenWidth) // Fix the width to screenWidth
                            .offset(x: offsetX) // Apply the offset
                        
                        
                    }
                    StickView()
                }
            }
            
            .onAppear {
                // Animate the offset for continuous scrolling
                withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                    offsetX = -screenWidth  // Scroll the entire width to the right
                }
            }
            
            // Bottom part with black background
            VStack {
                Spacer()
            }
            .frame(height: screenHeight / 2) // Bottom section
            .background(Color.black) // Black background for the bottom half
        }
        .edgesIgnoringSafeArea(.all) // Ensures the background covers the entire screen
    }
}

struct AnimatedTextViewTests_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTextView()
        
    }
}

