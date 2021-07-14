//
//  SearchTableViewController.swift
//  Repository finder
//
//  Created by Hartmann Szabolcs on 2021. 07. 07..
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    
    var repositoryManager = RepositoryManager()
    var searchText : String?
    var selectedRepository : String?
    
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    var repoArray : [RepositoryListModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.rowHeight = 150
        
        setLoadingScreen()
        
        self.registerTableViewCells()
        
        repositoryManager.delegate = self
        
        if let search = searchText{
            repositoryManager.fetchURL(key: search)
        }
    }
    
    //MARK: Custom TableView
    private func registerTableViewCells(){
        let textFieldCell = UINib(nibName: "CustomTableViewCell",
                                      bundle: nil)
            self.tableView.register(textFieldCell,
                                    forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    //MARK: Alert
    func showAlert(errorMessage : String){
        let alert = UIAlertController(title: "Hiba", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    //MARK: Date
    func dateFormatter(date : String) -> String{
        let dateFormatter = ISO8601DateFormatter()
        let formattedDate = dateFormatter.date(from:date)!
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let newDate = df.string(from: formattedDate)
        return newDate
    }
    
    //MARK: Loading
    private func setLoadingScreen() {
        
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = self.view.bounds.midX
        let y = self.view.bounds.midY
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: 130, y: 330, width: 140, height: 30)
        
        spinner.style = .gray
        spinner.frame = CGRect(x: 130, y: 330, width: 30, height: 30)
        spinner.startAnimating()
        
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        
        tableView.addSubview(loadingView)
        
    }
    
    private func removeLoadingScreen() {
        
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
        
    }

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return repoArray.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell {

            cell.nameLabel.text = repoArray[indexPath.row].repoName
            cell.descriptionLabel.text = repoArray[indexPath.row].repoDescription
            cell.starsLabel.text = String(repoArray[indexPath.row].stars) + " Stars"
            cell.updateLabel.text = "Last update: " + dateFormatter(date: repoArray[indexPath.row].update)

            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RepositoryStoryboard") as! RepositoryViewController
        
        newViewController.repoName = repoArray[indexPath.row].repoName
        newViewController.repoDescription = repoArray[indexPath.row].repoDescription
        newViewController.stars = repoArray[indexPath.row].stars
        newViewController.update = repoArray[indexPath.row].update
        newViewController.ownerName = repoArray[indexPath.row].ownerName
        newViewController.ownerAvatar = repoArray[indexPath.row].ownerAvatar
        newViewController.ownerProfile = repoArray[indexPath.row].ownerProfile
        newViewController.repoLink = repoArray[indexPath.row].repoLink
        newViewController.forkNumber = repoArray[indexPath.row].forkNumber
        newViewController.createdAt = repoArray[indexPath.row].createdAt
       
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RepositoryViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.repoName = repoArray[indexPath.row].repoName

        }
        
        
    }
    
    
}

extension SearchTableViewController : RepositoryManagerDelegate {
    func didUpdate(_ repositoryManager: RepositoryManager, repositoryArray: [RepositoryListModel]) {
        
        DispatchQueue.main.async {
            self.removeLoadingScreen()
            for i in 0..<repositoryArray.count {

                self.repoArray.append(repositoryArray[i])
            }

            if self.repoArray.count == 0 {
                self.showAlert(errorMessage: "Nincs a keresésnek megfelelő elem")
            }
            
            self.tableView.reloadData()
        }
        
        
        
    }
    
    func didFailedWithError(error: Error) {
        print(error)
    }
    
}


