//
//  OnboardingView.swift
//  OnboardingScreen
//
//  Created by Talha Gergin on 28.12.2024.
//

import SwiftUI

struct OnboardingView: View {
    //MARK: - PROPERTY
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var textTittle: String = "Share."
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack (spacing: 20){
               //MARK: HEADER
                
                Spacer()
                VStack(spacing: 0){
                    Text(textTittle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                        .transition(.opacity)
                        .id(textTittle)
                    
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }//: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                //MARK: CENTER
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)//we gave negative value becuse it should be go opposite way.
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y:0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged{gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        textTittle = "Give"
                                    }
                                }
                                .onEnded{_ in
                                    imageOffset = .zero
                                    textTittle = "Share."
                                }
                        ) //: GESTURE
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }//:CENTER
                Spacer()
                //MARK: - FOOTER
                ZStack{
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    //2. call-to-action(staic)
                    Text("Get Started")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .offset(x: 20)
                    //3. CAPSULE (DYNAMIC WIDTH)
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    //4. Circle(Draggable)
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundStyle(.white)
                        .frame(width: 80,height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{_ in
                                    withAnimation(Animation.easeOut(duration: 0.5)){
                                        if buttonOffset > buttonWidth / 2 {
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        }else{
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        ) //: GESTURE
                        
                        Spacer()
                    }//: HSTACK
                }//:FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0: 40)
                .animation(.easeOut(duration: 0.5), value: isAnimating)
            }//: VSTACK
        }//: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
    }
}
//MARK: - PREVIEW
#Preview {
    OnboardingView()
}
