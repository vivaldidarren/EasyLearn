//
//  ContentView.swift
//  EasyLearn
//
//  Created by Vivaldi Darren Christophilus on 27/07/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
//    @State var shouldShowOnboarding: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    ZStack{
                        Color("mainColor")
                        VStack {
                            ZStack{
                                Rectangle()
                                    .frame(width: 353, height: 39)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                
                            }
                            .frame(width: 353, height: 39)
                            .padding(.bottom, 10)

                            
                            Text("Hello")
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("What are you going to learn today?")
                                .font(.system(size: 16))
                                .fontWeight(.light)
                                .foregroundColor(.white)
                        }
                        .frame(width: 353, height: 39)
                        
                    }
                    
                    ZStack {
                        Color("white")
                        VStack {
                            Text("Your current learnings")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                    }
                }
                
            }
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
            OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
        })
    }
}

// Onboarding
struct OnboardingView: View {
    
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        PageView(
            title: "Welcome to EasyLearn!",
            message: "An app that helps you to keep track of your learnings and stay on the target.",
            imageName: "onboardingImage",
            showDismissButton: true,
            shouldShowOnboarding: $shouldShowOnboarding
        )
    }
}

struct PageView: View {
    
    let title: String
    let message: String
    let imageName: String
    let showDismissButton: Bool
    
    @Binding var shouldShowOnboarding: Bool

    
    var body: some View {
        ZStack {
            Color("mainColor")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 390)
                    .padding()
                
                Spacer()
                
                ZStack {
                    Color.white
                    VStack {
                        Text(title)
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.bottom, 6)
                        
                        Text(message)
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(width: 298)
                            .padding(.bottom, 27)
                        
                        if showDismissButton {
                            Button(action: {
                                shouldShowOnboarding.toggle()
                            }, label: {
                                Text("Let's get started!")
                                    .bold()
                                    .foregroundColor(Color.white)
                                    .frame(width: 353, height: 54)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                            })
                        }
                    }
                }
                .cornerRadius(15, corners: [.topLeft,.topRight])
                .frame(width: 390, height: 268)
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
