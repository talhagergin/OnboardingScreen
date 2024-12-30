//
//  HomeView.swift
//  OnboardingScreen
//
//  Created by Talha Gergin on 28.12.2024.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding")  var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            //MARK: - HEADER
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 32 : -35)
                    .animation(
                        Animation
                            .easeOut(duration: 4)
                            .repeatForever()
                        ,value: isAnimating
                    )
            }
            //MARK: - CENTER
            Text("The time that leads to mastery is dependent on the intensisty of our focus")
                .font(.title3)
                .fontWeight(.light)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            //MARK: - FOOTER
            Spacer()
            
            Button(action: {
                withAnimation{
                    isOnboardingViewActive = true
                }
                
            }){
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }//: BUTTON
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } //: VSTACK
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                isAnimating = true
            })
        })
    }
}

#Preview {
    HomeView()
}
