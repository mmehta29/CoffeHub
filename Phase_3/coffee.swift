
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CoffeeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var user = User()
    @State private var showingProgressView = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .frame(width: 700, height: 900)
                .ignoresSafeArea()

            VStack {
                Text("Sign Up")
                    .bold()
                    .font(.title)
                    .foregroundColor(.black)

                TextField("Enter your full name", text: $user.name)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                    .padding()

                TextField("Enter your email address", text: $user.email)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                    .padding()

                TextField("Enter a username", text: $user.username)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                    .padding()

                SecureField("Enter your password", text: $user.password)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 300)
                    .padding()

                if showingProgressView {
                    ProgressView()
                } else {
                    Button(action: onPressSave) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }

    private func onPressSave() {
        guard !user.name.isEmpty, !user.email.isEmpty, !user.password.isEmpty, !user.username.isEmpty else {
            showAlert(title: "Error", message: "All fields are required.")
            return
        }

        showingProgressView = true
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            showingProgressView = false
            if let error = error {
                showAlert(title: "Signup Failed", message: error.localizedDescription)
                return
            }

            guard let uid = authResult?.user.uid else { return }
            let db = Firestore.firestore()
            db.collection("users").document(uid).setData(user.toDict()) { error in
                if let error = error {
                    showAlert(title: "Database Error", message: error.localizedDescription)
                } else {
                    showAlert(title: "Success", message: "Account created successfully!")
                    dismiss()
                }
            }
        }
    }

    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showingAlert = true
    }
}

