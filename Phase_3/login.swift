

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var showingProgressView = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var isLoggedIn = false // State to handle navigation

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .frame(width: 700, height: 900)
                .ignoresSafeArea()

            VStack {
                Text("Login")
                    .bold()
                    .font(.title)
                    .foregroundColor(.black)

                TextField("Enter your email address", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                    .padding()

                SecureField("Enter your password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                    .padding()

                if showingProgressView {
                    ProgressView()
                } else {
                    Button(action: onLogin) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }

                // Hidden NavigationLink for navigation to HomePage
                NavigationLink(
                    destination: HomePage().navigationBarBackButtonHidden(true),
                    isActive: $isLoggedIn
                ) {
                    EmptyView()
                }
            }
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }

    private func onLogin() {
        guard !email.isEmpty, !password.isEmpty else {
            showAlert(title: "Error", message: "Both email and password are required.")
            return
        }

        showingProgressView = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            showingProgressView = false
            if let error = error {
                showAlert(title: "Login Failed", message: error.localizedDescription)
                return
            }

            // Navigate to HomePage
            isLoggedIn = true
        }
    }

    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showingAlert = true
    }
}






