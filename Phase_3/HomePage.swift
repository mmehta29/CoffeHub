

import SwiftUI
import Firebase

struct HomePage: View {
    @State private var shouldNavigateToChoose = false // State to trigger navigation
    @State var user = User()
    @StateObject var viewModel = AuthView()
    @State var name = ""

    var body: some View {
        ZStack {
            // Background Image
            Image("coffee")
                .resizable()
                .frame(width: 1200, height: 900)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Let's find the best coffee for you")
                    .fontDesign(.serif)
                    .font(.custom("serif", size: 20))
                    .foregroundColor(.white)
                    .padding()

                // NavigationLink to CafeListView
                NavigationLink(destination: CafeListView(address: "", lon: "", lat: "")) {
                    HStack {
                        Text("Start Searching")
                        Image(systemName: "heart.fill")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.brown))
                }
                .padding()

                // Logout Button with Navigation
                Button(action: onLogout) {
                    HStack {
                        Text("Logout")
                        Image(systemName: "arrow.uturn.backward")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                }

                Spacer()
                Spacer()
                Spacer()

                // Programmatic navigation to choose
                if shouldNavigateToChoose {
                    NavigationLink(destination: choose(), isActive: $shouldNavigateToChoose) {
                        EmptyView()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    private func onLogout() {
        do {
            try Auth.auth().signOut() // Sign out from Firebase
            shouldNavigateToChoose = true // Trigger navigation to choose view
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(name: "Manya")
    }
}











