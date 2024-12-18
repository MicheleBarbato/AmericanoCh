import SwiftUI
import UIKit

struct ContentView: View {
    // State variable for the counter
    @State private var counter = 0
    @State private var NavigatingToSettings = false
    
    // State variables for button and number animation
    @State private var shakeAmount: CGFloat = 0
    @State private var isShaking = false
    
    // Timer for continuous increment/decrement
    @State private var timer: Timer? = nil
    @State private var isIncrementing = false
    @State private var isDecrementing = false
    @State private var delayTimer: Timer? = nil // Timer for delay before starting scrolling
    
    // Function for shake animation
    func shakeButtonAndNumber() {
        if isShaking { return }
        
        isShaking = true
        withAnimation(.linear(duration: 0.1).repeatCount(3, autoreverses: true)) {
            shakeAmount = 10 // Move to the right
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            shakeAmount = 0
            isShaking = false
        }
    }
    
    // Function to generate haptic feedback (vibration)
    func generateHapticFeedback() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
    }
    
    // Function to increment the counter
    func increment() {
        counter += 1
    }
    
    // Function to decrement the counter
    func decrement() {
        if counter > 0 {
            counter -= 1
        } else {
            shakeButtonAndNumber() // Shake when the counter is 0
        }
    }
    
    // Function to start the timer for increment after delay
    func startDelayedIncrement() {
        delayTimer?.invalidate() // Invalidate any previous timers
        
        delayTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            self.isIncrementing = true
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.increment()
                self.generateHapticFeedback()
            }
        }
    }
    
    // Function to start the timer for decrement after delay
    func startDelayedDecrement() {
        delayTimer?.invalidate() // Invalidate any previous timers
        
        delayTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.isDecrementing = true
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.decrement()
                self.generateHapticFeedback()
            }
        }
    }
    
    // Function to stop the timer
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        delayTimer?.invalidate()
        delayTimer = nil
        isIncrementing = false
        isDecrementing = false
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // First part: 30% of the screen (white)
                    Color.white
                        .frame(height: UIScreen.main.bounds.height * 0.3)
                    
                    // Second part: 70% of the screen (black)
                    Color(red: 28/255, green: 28/255, blue: 28/255)
                        .frame(height: UIScreen.main.bounds.height * 0.7)
                }
                .edgesIgnoringSafeArea(.all)
                
                // Animated background
                AnimatedTextView()
                    .accessibilityHidden(true)

                ZStack {
                    VStack {
                        HStack {
                            // Minus button with Long Press
                            Button(action: {
                                decrement()
                                generateHapticFeedback() // Vibration immediately on click
                            }) {
                               Text("⌄")
                                    .frame(width: 100, height: 300)
                                    .font(.custom("basis33", size: 160))
                                    .background(Color(red: 28/255, green: 28/255, blue: 28/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                   // .border(Color.white, width: 1)
                            }
                            .offset(y: 80)
                            .offset(x: 0)
                            .offset(x: shakeAmount)
                            .onLongPressGesture(
                                minimumDuration: 0.1,
                                maximumDistance: 100,
                                pressing: { isPressing in
                                    if isPressing {
                                        startDelayedDecrement() // Start decrementing with delay
                                    } else {
                                        stopTimer() // Stop the timer when no longer pressed
                                    }
                                },
                                perform: {}
                            )
                            .accessibilityLabel("Decrement")
                            
                            // Use GeometryReader to prevent the number from affecting the button position
                            GeometryReader { geometry in
                                Text("\(counter)")
                                    .font(.custom("Droid 1997", size: 100))
                                    .foregroundStyle(.white)
                                    .offset(x: shakeAmount)
                                    .offset(y: 7)
                                    .animation(.bouncy(duration: 0.5), value: counter)
                                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center) // Keep the position constant
                            }
                            .frame(width: 150, height: 150) // Set fixed width and height to avoid movement
                           // .border(Color.white, width: 1)
                            
                            // Plus button with Long Press
                            Button(action: {
                                increment()
                                generateHapticFeedback() // Vibration immediately on click
                            }) {
                               Text("⌃")
                                    .frame(width: 100, height: 200)
                                    .font(.custom("basis3", size: 160))
                                    .offset(y: -16)
                                    .background(Color(red: 28/255, green: 28/255, blue: 28/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                   // .border(Color.white, width: 1)
                            }
                            .offset(y: -40)
                            .offset(x: 0)
                            .offset(x: shakeAmount)
                            .onLongPressGesture(
                                minimumDuration: 0.1,
                                maximumDistance: 100,
                                pressing: { isPressing in
                                    if isPressing {
                                        startDelayedIncrement() // Start incrementing with delay
                                    } else {
                                        stopTimer() // Stop the timer when no longer pressed
                                    }
                                },
                                perform: {}
                            )
                            .accessibilityLabel("Increment")
                        }
                        .padding(.top, 350)
                        
                        // Reset button
                        Button(action: {
                            if counter > 0 {
                                counter = 0
                                generateHapticFeedback() // Vibration when resetting
                            } else {
                                shakeButtonAndNumber()  // Shake when the counter is already 0
                            }
                        }) {
                            Text("RESET")
                                .font(.custom("Droid 1997", size: 60))
                                .background(Color(red: 28/255, green: 28/255, blue: 28/255))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .offset(x: shakeAmount)
                        .accessibilityLabel("reset")
                    }
                }
                .sensoryFeedback(.warning, trigger: isShaking)
            }
        }
    }
}

#Preview {
    ContentView()
}

