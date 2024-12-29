


import Foundation
import Firebase
import FirebaseAuth

class AuthView: ObservableObject {
    @Published var userSession: FirebaseAuth.User?

    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("Authentication error: \(error.localizedDescription)")
            throw error
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print("Sign-out error: \(error.localizedDescription)")
        }
    }
}


