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
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: Functions
    func showAlert(errorMessage : String){
        let alert = UIAlertController(title: "Hiba", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func checkInput(_ text : String) -> Bool{
        for chr in text{
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && chr != " " && chr != "_" ) {
                return false
            }
        }
        return true
    }
    
    
    //MARK: Buttons
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let searchText = searchTextField.text {
            if searchText == "" {
                showAlert(errorMessage: "A kulcsszó nem lehet üres")
            } else if checkInput(searchText) == false{
                showAlert(errorMessage: "Csak az angol abc betűi a szóköz és a _ megengedettek")
            }else {
               
                let vc = SearchTableViewController()
                vc.searchText = searchText.lowercased().replacingOccurrences(of: " ", with: "_")

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
