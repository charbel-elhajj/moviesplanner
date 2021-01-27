//
//  FavouritesViewController.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 20/01/2021.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = Variables.currentUser?.favouriteMovies?.count{
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as! FavouriteTableViewCell
        let row = indexPath.row
        cell.title.text = Variables.currentUser!.favouriteMovies![row].title
        cell.wallpaper.load(urlString: Variables.currentUser!.favouriteMovies![row].image)
        
        if row%2 == 0 {
            cell.backgroundColor = UIColor(red: 247/255, green: 223/255, blue: 247/255, alpha: 1.0)
        }
        else{
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    @IBAction func searchButtonPushed(_ sender: Any) {
        tabBarController?.selectedIndex = 1
            navigationController?.popToRootViewController(animated: true)
    }
    
    func updateTable(){
        moviesTableView.isHidden = true
        if let user = Variables.currentUser{
            if user.favouriteMovies!.count > 0{
                noMoviesLabel.isHidden = true
                searchButton.isHidden = true
                moviesTableView.isHidden = false
                moviesTableView.reloadData()
                moviesTableView.rowHeight=275

            }
            else{
                noMoviesLabel.isHidden = false
                searchButton.isHidden = false
                moviesTableView.isHidden = true
            }
        }
        else{
            noMoviesLabel.isHidden = false
            searchButton.isHidden = false
            moviesTableView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Variables.favouritesController=self
        moviesTableView.isHidden = false
        noMoviesLabel.isHidden = true
        searchButton.isHidden = true
        if let user = Variables.currentUser{
            if user.favouriteMovies!.count > 0{
                noMoviesLabel.isHidden = true
                searchButton.isHidden = true
                moviesTableView.isHidden = false
                moviesTableView.rowHeight=275
            }
            else{
                noMoviesLabel.isHidden = false
                searchButton.isHidden = false
                moviesTableView.isHidden = true
            }
        }
        else{
            noMoviesLabel.isHidden = false
            searchButton.isHidden = false
            moviesTableView.isHidden = true
            moviesTableView.isHidden = true
        }
        moviesTableView.dataSource=self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var noMoviesLabel: UILabel!
    @IBOutlet weak var moviesTableView: UITableView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailsViewController{
            let row = moviesTableView.indexPathForSelectedRow!.row
            vc.id = Variables.currentUser!.favouriteMovies![row].id
            vc.movie = Variables.currentUser!.favouriteMovies![row]
        }
    }

}
