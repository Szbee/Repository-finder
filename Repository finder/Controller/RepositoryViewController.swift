//
//  RepositoryViewController.swift
//  Repository finder
//
//  Created by Hartmann Szabolcs on 2021. 07. 10..
//

import UIKit

class RepositoryViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var ownerProfileTextView: UITextView!
    @IBOutlet weak var repositoryLinkTextView: UITextView!
    @IBOutlet weak var repositoryDescriptionTextView: UITextView!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    
    var indexPath : Int?
    var repoName : String?
    var repoDescription : String?
    var stars : Int?
    var update : String?
    
    var ownerName : String?
    var ownerAvatar : String?
    var ownerProfile : String?
    var repoLink : String?
    var forkNumber : Int?
    var createdAt : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = repoName{
            repositoryName.text = name
        }
        if let description = repoDescription{
            repositoryDescriptionTextView.text = description
        }
        if let score = stars{
            starsLabel.text = String(score)
        }
        if let lastUpdate = update{
            lastUpdateLabel.text = lastUpdate
        }
        if let oName = ownerName{
            ownerNameLabel.text = oName
        }
        if let avatar = ownerAvatar{
            let avatarURL = URL(string: avatar)!
            downloadImage(from: avatarURL)
        }
        if let oProflie = ownerProfile{
            ownerProfileTextView.text = oProflie
        }
        if let link = repoLink{
            repositoryLinkTextView.text = link
        }
        if let forks = forkNumber{
            forksLabel.text = String(forks)
        }
        if let created = createdAt{
            createdAtLabel.text = created
        }
        
        if let index = indexPath{
            print(index)
        }
        // Do any additional setup after loading the view.
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.avatarImageView.image = UIImage(data: data)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
