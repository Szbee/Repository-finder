//
//  HomeViewController.swift
//  Repository finder
//
//  Created by Hartmann Szabolcs on 2021. 07. 07..
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    var repositoryManager = RepositoryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: Functions
    func showAlert(errorMessage : String){
        let alert = UIAlertController(title: "Hiba", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    
    //MARK: Buttons
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let searchText = searchTextField.text {
            if searchText == "" {
                showAlert(errorMessage: "A kulcsszó nem lehet üres")
            } else {
               
                let vc = SearchTableViewController()
                vc.searchText = searchText.lowercased()

                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
