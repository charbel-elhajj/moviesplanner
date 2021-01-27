//
//  MovieDetails.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 16/01/2021.
//

import Foundation

// MARK: - MovieDetails
class MovieDetails: Codable {
    let id, fullTitle: String
    let year: String
    let image: String
    let plot: String
    let trailer: Trailer
    let errorMessage: String
    let imDbRating: String
    
    init(id:String, fullTitle:String,year:String, image:String, plot:String,trailer:Trailer,errorMessage:String,imDbRating:String) {
        self.id = id
        self.fullTitle = fullTitle
        self.year = year
        self.image = image
        self.plot = plot
        self.trailer = trailer
        self.errorMessage = errorMessage
        self.imDbRating = imDbRating
    }


    
}


// MARK: - Trailer
class Trailer: Codable {
    let imDbId, title, fullTitle, type: String
    let year, videoId, videoTitle, videoDescription: String
    let thumbnailUrl: String
    let uploadDate: String
    let link, linkEmbed: String
    let errorMessage: String

   
    init(imDbId: String, title: String, fullTitle: String, type: String, year: String, videoId: String, videoTitle: String, videoDescription: String, thumbnailUrl: String, uploadDate: String, link: String, linkEmbed: String, errorMessage: String) {
        self.imDbId = imDbId
        self.title = title
        self.fullTitle = fullTitle
        self.type = type
        self.year = year
        self.videoId = videoId
        self.videoTitle = videoTitle
        self.videoDescription = videoDescription
        self.thumbnailUrl = thumbnailUrl
        self.uploadDate = uploadDate
        self.link = link
        self.linkEmbed = linkEmbed
        self.errorMessage = errorMessage
    }
}




