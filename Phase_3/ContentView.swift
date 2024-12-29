
//
//  ContentView.swift
//  phase1
//
//  Created by manya mehta on 23/10/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseCore
struct ContentView: View {
    @State var isAnimating = false
    @StateObject private var locationManager = LocationDataManager()
    
    var animation : Animation{
        .interpolatingSpring(Spring(stiffness: 0.5, damping: 0.5))
        .repeatForever()
        .delay(isAnimating ? .random(in: 0...1) : 0)
        .speed(isAnimating ? .random(in: 0.1...1) : 0)
    }
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    Image("coffeee")
                    // .imageScale(.small)
                        .foregroundStyle(.tint)
                }
               // .animation(animation)
                VStack{
                    Text("")
                    Text("COFFEE")
                        .bold()
                    // .italic()
                        .fontDesign(.serif)
                        .font(.custom("italics", size: 55))
                    // .background(.white)
                    // .font(.largeTitle)
                    Text("")
                    Text("HUB")
                        .bold()
                        .font(.custom("COFFEE", size: 50))
                        .fontDesign(.serif)
                    //.background(.brown)
                    Text("")
                    NavigationLink("Get Started ->", destination:choose())
                        .padding()
                       // .fontDesign(.noteworthy)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .background(.brown)
                        .cornerRadius(48)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 5, y: 5)
                        .font(.system(size: 20))
                    
                }
                .animation(animation)
            }
            .padding()
            
        }
        .onAppear {
                    startLocationUpdates()
                   // viewModel.search()
                }
        .onReceive(locationManager.$locationManager, perform: { manager in
            print(manager.location)
        })
    }
    private func startLocationUpdates() {
            locationManager.locationManager.startUpdatingLocation()
        }
}

#Preview {
    ContentView()
}




