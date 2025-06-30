import Foundation
import FirebaseAuth

class AuthenticationService {
    func signInWithGoogle(user: UserData, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            guard let self = self else { return }
            guard error == nil else{
                print(error!.localizedDescription)
                completion(.failure(error!))
                return
            }
            
            result?.user.sendEmailVerification()
            completion(.success(true))
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
