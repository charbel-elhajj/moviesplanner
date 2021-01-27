//
//  Constants.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 13/01/2021.
//

import Foundation

struct Constants {
    struct StoryBoard {
        
        static let homeViewController = "HomeVC"
        static let loginViewController = "LoginVC"
    }
    
    struct API{
        static let key = "k_xomnl3mq"
        //static let key = "k_nfih2oyk"
        static let moviesSearchAPI = "https://imdb-api.com/en/API/SearchMovie/%@/%@"// key/searchkeyword
        static let moviesDetailAPI = "https://imdb-api.com/en/API/Title/%@/%@/Posters,Trailer,Ratings,"// key/id
    }
    
}
