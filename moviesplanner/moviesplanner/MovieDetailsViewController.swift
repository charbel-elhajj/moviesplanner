//
//  MovieDetailsViewController.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 16/01/2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var isFound = false
    @IBAction func addToFavouritesButtonPushed(_ sender: Any) {
        
        if isFound{
            var index = 0
            for i in 0..<Variables.currentUser!.favouriteMovies!.count{
                if Variables.currentUser!.favouriteMovies![i].id == self.id{
                    index = i;
                }
            }
            Variables.currentUser!.favouriteMovies!.remove(at:index)
            Variables.currentUser!.updateFavouriteMovies()
            Variables.favouritesController?.updateTable()
            navigationController?.popToRootViewController(animated: true)
            
        }
        else{
            Variables.currentUser!.favouriteMovies!.append(self.movie!)
            Variables.currentUser!.updateFavouriteMovies()
            tabBarController?.selectedIndex = 0
            navigationController?.popViewController(animated: true)
            
            Variables.favouritesController?.updateTable()
            
            navigationController?.popToRootViewController(animated: true)
            
        }
        
        
        
       
    }
    @IBOutlet weak var addFavouriteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO
        // Do any additional setup after loading the view.
//        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
//            rect = rect.union(view.frame)
//        }
//        scrollView.contentSize = contentRect.size
//
        
        if let id = self.id{
            let str :String = String(format: Constants.API.moviesDetailAPI, Constants.API.key, id)
            var request : URLRequest = URLRequest(url: URL(string: str)!)
            request.httpMethod = "GET"

            NSURLConnection.sendAsynchronousRequest(request,queue: OperationQueue(),
            completionHandler:{ (response:URLResponse!, data: Data!, error: Error!) -> Void in
                    if let result = try? JSONDecoder().decode(MovieDetails.self, from: data){
                        self.movieDetails = result
                        self.image.load(urlString: self.movieDetails!.image)
                        DispatchQueue.main.async {
                            self.movieTitle.text = self.movieDetails!.fullTitle
                            var description = "Year: \(self.movieDetails!.year)\n"
                            description += "Rating: \(self.movieDetails!.imDbRating)\n"
                            description += "Plot: \(self.movieDetails!.plot)\n"
                            self.movieDescription.text = description
                        }
                        
                        
                    }
                    else{
                        print(error)
                    }
            })
            if let found = Variables.currentUser!.favouriteMovies?.contains(where:{(m) in m.id == self.id}) {
                isFound = found
            }
            else{
                isFound = false
            }
            if isFound{
                addFavouriteButton.backgroundColor = UIColor.red
                addFavouriteButton.setTitle("Delete from favourite", for: .normal)
                addFavouriteButton.setImage(UIImage(named: "icons8-delete-bin-50"), for: .normal)
            }
        }
        
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBAction func clickTrailer(_ sender: Any) {
        if let str = movieDetails?.trailer.link{
            if let url = URL(string: str) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    var movieDetails :MovieDetails?
    var id :String?
    var movie:Movie?
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
