//
//  LaunchScreenView.swift
//  RecipeApp
//
//  Created by Yogesh on 1/21/25.
//
import SwiftUI

struct LaunchScreenView: View {
    @State private var isAnimating = false
    @State private var animationCompleted = false
    
    var body: some View {
        if animationCompleted {
            RecipesView()
        } else {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.2), Color.purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Animated App Logo
                    Image("ShowMe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .foregroundColor(.blue)
                        .cornerRadius(15)
                        .scaleEffect(isAnimating ? 1.0 : 0.1)
                        .rotation3DEffect(
                            Angle(degrees: isAnimating ? 360 : 0),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 10)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1.5)) {
                                isAnimating = true
                            }
                        }
                    
                    Text("Welcome to Recipe App")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.brown)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeIn(duration: 1.5), value: isAnimating)
                }
            }
            .onAppear {
                // Delay for animation, then switch to the main app view
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        animationCompleted = true
                    }
                }
            }
        }
    }
}
