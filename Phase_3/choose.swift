

//
//  choose.swift
//  phase1
//
//  Created by manya mehta on 07/11/23.
//

import SwiftUI
import FirebaseCore
struct choose: View {
    var body: some View {
        ZStack{
            Image("coffee7")
                .resizable()
                .scaledToFill()
                .frame(width: 630, height: 250)
                
            VStack{
                    VStack{
                        Text("Welcome !")
                            .bold()
                            .fontDesign(.serif)
                            .font(.custom("italics", size: 60))
                        Text("Let's find you the best coffee")
                            .bold()
                            .fontDesign(.serif)
                            .font(.custom("italics", size: 22))
                      Text("")
                            .padding()
                        HStack{
                            ZStack{
                                Image("coffee9")
                                    .resizable()
                                    .frame(width:200, height:200)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                
                            }
                            Text("")
                        }
                        Text("")
                            .padding()
                        NavigationLink(" Sign up ", destination:CoffeeView())

                                        .font(.title)
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 30)
                                                .fill(Color.brown)
                                        )
                                        .shadow(radius: 5)
                        
                        Text("")
                            .padding()
                        NavigationLink(" Log in  ", destination: LoginView())
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.brown)
                            )
                            .shadow(radius: 5)
                        Spacer()
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    choose()
}










