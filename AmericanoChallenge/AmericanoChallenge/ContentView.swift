import SwiftUI
import UIKit

struct ContentView: View {
    // Variabile di stato per il contatore
    @State private var counter = 0
    @State private var NavigatingToSettings = false
    
    // Variabili di stato per l'animazione dei pulsanti e del numero
    @State private var shakeAmount: CGFloat = 0
    @State private var isShaking = false
    
    // Timer per incremento/decremento continuo
    @State private var timer: Timer? = nil
    @State private var isIncrementing = false
    @State private var isDecrementing = false
    @State private var delayTimer: Timer? = nil // Timer per il ritardo prima che inizi a scorrere
    
    // Funzione per l'animazione di vibrazione
    func shakeButtonAndNumber() {
        if isShaking { return }
        
        isShaking = true
        withAnimation(.linear(duration: 0.1).repeatCount(3, autoreverses: true)) {
            shakeAmount = 10 // Movimento a destra
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            shakeAmount = 0
            isShaking = false
        }
    }
    
    // Funzione per generare vibrazione (feedback tattile)
    func generateHapticFeedback() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.prepare()
        impactFeedback.impactOccurred()
    }
    
    // Funzione per incrementare
    func increment() {
        counter += 1
    }
    
    // Funzione per decrementare
    func decrement() {
        if counter > 0 {
            counter -= 1
        } else {
            shakeButtonAndNumber() // Vibrazione quando il contatore è 0
        }
    }
    
    // Funzione per iniziare il timer per l'incremento dopo il ritardo
    func startDelayedIncrement() {
        delayTimer?.invalidate() // Invalida eventuali timer precedenti
        
        delayTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            self.isIncrementing = true
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.increment()
                self.generateHapticFeedback()
            }
        }
    }
    
    // Funzione per iniziare il timer per il decremento dopo il ritardo
    func startDelayedDecrement() {
        delayTimer?.invalidate() // Invalida eventuali timer precedenti
        
        delayTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.isDecrementing = true
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.decrement()
                self.generateHapticFeedback()
            }
        }
    }
    
    // Funzione per fermare il timer
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
                    // Prima parte: 30% dello schermo (bianco)
                    Color.white
                        .frame(height: UIScreen.main.bounds.height * 0.3)
                    
                    // Seconda parte: 70% dello schermo (nero)
                    Color(red: 28/255, green: 28/255, blue: 28/255)
                        .frame(height: UIScreen.main.bounds.height * 0.7)
                }
                .edgesIgnoringSafeArea(.all)
                
                // Sfondo animato
                AnimatedTextView()
                    .accessibilityHidden(true)

                ZStack {
                    VStack {
                        HStack {
                            // Tasto meno con Long Press
                            Button(action: {
                                decrement()
                                generateHapticFeedback() // Vibrazione subito al clic
                            }) {
                               Text("⌄")
                                    .frame(width: 130, height: 300)
                                    .font(.custom("basis33", size: 160))
                                    .background(Color(red: 28/255, green: 28/255, blue: 28/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .offset(y: 80)
                            .offset(x:-40)
                            .offset(x: shakeAmount)
                            .onLongPressGesture(
                                minimumDuration: 0.1,
                                maximumDistance: 100,
                                pressing: { isPressing in
                                    if isPressing {
                                        startDelayedDecrement() // Avvia il decremento con ritardo
                                    } else {
                                        stopTimer() // Ferma il timer quando non si preme più
                                    }
                                },
                                perform: {}
                            )
                            .accessibilityLabel("Decrement")
                            
                            Text("\(counter)")
                                .font(.custom("Droid 1997", size: 100))
                                .foregroundStyle(.white)
                                .offset(x: shakeAmount)
                                .offset(y: 7)
                                .animation(.bouncy(duration: 0.5), value: counter)

                            // Tasto più con Long Press
                            Button(action: {
                                increment()
                                generateHapticFeedback() // Vibrazione subito al clic
                            }) {
                               Text("⌃")
                                    .frame(width: 130, height: 200)
                                    .font(.custom("basis3", size: 160))
                                    .offset(y:-16)
                                    .background(Color(red: 28/255, green: 28/255, blue: 28/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .offset(y: -40)
                            .offset(x: 40)
                            .offset(x: shakeAmount)
                            .onLongPressGesture(
                                minimumDuration: 0.1,
                                maximumDistance: 100,
                                pressing: { isPressing in
                                    if isPressing {
                                        startDelayedIncrement() // Avvia l'incremento con ritardo
                                    } else {
                                        stopTimer() // Ferma il timer quando non si preme più
                                    }
                                },
                                perform: {}
                            )
                            .accessibilityLabel("Increment")
                        }
                        .padding(.top, 350)
                        
                        // Tasto Reset
                        Button(action: {
                            if counter > 0 {
                                counter = 0
                                generateHapticFeedback() // Vibrazione quando resettiamo
                            } else {
                                shakeButtonAndNumber()  // Vibrazione quando il contatore è già 0
                            }
                        }) {
                            Text("RESET")
                                .font(.custom("Droid 1997", size:60))
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

