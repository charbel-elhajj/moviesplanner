//
//  SearchViewController.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 15/01/2021.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        let row = indexPath.row
        cell.title.text = movies[row].title
        cell.wallpaper.load(urlString: movies[row].image)
        
        if row%2 == 0 {
            cell.backgroundColor = UIColor(red: 247/255, green: 223/255, blue: 247/255, alpha: 1.0)
        }
        else{
            cell.backgroundColor = UIColor.white
        }
        
        return cell
        
    }
    
    @IBOutlet weak var movisSearchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        let trimmed = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let str = trimmed?.replacingOccurrences(of: " ", with: "%20"){
            let str :String = String(format: Constants.API.moviesSearchAPI, Constants.API.key, str)
            var request : URLRequest = URLRequest(url: URL(string: str)!)
            request.httpMethod = "GET"

            NSURLConnection.sendAsynchronousRequest(request,queue: OperationQueue(),
            completionHandler:{ (response:URLResponse!, data: Data!, error: Error!) -> Void in
                    if let result = try? JSONDecoder().decode(Movies.self, from: data){
                        self.movies = result.results
                        DispatchQueue.main.async {
                            self.moviesTableView.reloadData()
                        }
                    }
            })
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        movisSearchBar.delegate = self
        let str :String = String(format: Constants.API.moviesSearchAPI, Constants.API.key, "Star%20Wars")
        var request : URLRequest = URLRequest(url: URL(string: str)!)
        request.httpMethod = "GET"

        NSURLConnection.sendAsynchronousRequest(request,queue: OperationQueue(),
        completionHandler:{ (response:URLResponse!, data: Data!, error: Error!) -> Void in
                if let result = try? JSONDecoder().decode(Movies.self, from: data){
                    self.movies = result.results
                    DispatchQueue.main.async {
                        self.moviesTableView.reloadData()
                    }
                }
        })
        
        moviesTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    var movies: [Movie] = []
    
    @IBOutlet weak var moviesTableView: UITableView!
    
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
            vc.id = movies[row].id
            vc.movie = movies[row]
        }
    }

}
