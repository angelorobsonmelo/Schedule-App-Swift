import UIKit
import GrowingTextView

class SaveScheduleViewController: BaseViewController, SaveScheduleViewContract, UITextViewDelegate {
   
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var titleLabelError: UILabel!
    @IBOutlet weak var shortDescriptionField: GrowingTextView!
    @IBOutlet weak var shortDescriptionErrorLabel: UILabel!
    @IBOutlet weak var detailField: GrowingTextView!
    @IBOutlet weak var detailErrorLabel: UILabel!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    var user: User?

    lazy var presenter: SaveSchedulePresenterContract = {
        return SaveSchedulePresenter(view: self,
                                     context: context,
                                     getUserSession: InjectionUseCase.provideGetUserSession(),
                                     saveSchedule: InjectionUseCase.provideSaveSchedule())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getUserSession()
        shortDescriptionField.placeholder = "Short Description"
        detailField.placeholder = "Detail"
        shortDescriptionField.delegate = self
        detailField.delegate = self
        disableButton()
        titleField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 1 {
            if textView.text?.first == " " {
                textView.text = ""
                return
            }
        }
        guard
            let title = titleField.text, !title.isEmpty,
            let shorDescription = shortDescriptionField.text, !shorDescription.isEmpty,
            let detail = detailField.text, !detail.isEmpty
            else {
                disableButton()
                return
        }
       enableButton()
    }
    
     @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let title = titleField.text, !title.isEmpty,
            let shorDescription = shortDescriptionField.text, !shorDescription.isEmpty,
            let detail = detailField.text, !detail.isEmpty
            else {
                disableButton()
                return
        }
        enableButton()
    }
    
    func showUserSession(user: User) {
        self.user = User(context: context)
        self.user = user
        authorField.text = self.user?.name
        authorField.isUserInteractionEnabled = false
    }
    
    @IBAction func create(_ sender: UIButton) {
        presenter.save(title: titleField.text!, shortDescription: shortDescriptionField.text, detail: detailField.text, author: user!)
    }
    
    func didSaveSuccess() {
        clearFields()
        disableButton()
        showAlertMessageSuccess()
    }
    
    fileprivate func disableButton() {
      createButton?.isUserInteractionEnabled = false
      createButton?.alpha = 0.5
    }
    
    fileprivate func enableButton() {
        createButton?.isUserInteractionEnabled = true
        createButton?.alpha = 1.0
    }
    
    fileprivate func showAlertMessageSuccess() {
        let alert = UIAlertController(title: "", message: "Salvo com sucesso!", preferredStyle: .alert)
        let buttonOkAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        })
        
        alert.addAction(buttonOkAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func clearFields() {
        titleField.text = ""
        shortDescriptionField.text = ""
        detailField.text = ""
    }
    
    func didRegisterError(message: String) {
        self.presentAlertError(message: message)
    }
    
}

extension SaveScheduleViewController: GrowingTextViewDelegate {
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
