import UIKit

extension UIViewController {
    
  func presentAlertError(message: String) {
    let alertError = UIAlertController(title: "", message: message, preferredStyle: .alert)
    let buttonAction = UIAlertAction(title: "OK", style: .destructive)
    alertError.addAction(buttonAction)
    self.present(alertError, animated: true, completion: nil)
  }
    
  func presentAlert(message: String) {
        let alertError = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let buttonAction = UIAlertAction(title: "OK", style: .default)
        alertError.addAction(buttonAction)
        self.present(alertError, animated: true, completion: nil)
    }
    
    func goToLoginViewController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginView: LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "login") as? LoginViewController ?? LoginViewController()
        self.present(loginView, animated: true, completion: nil)
    }
    
}
