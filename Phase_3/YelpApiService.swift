//
//  YelpApiService.swift
//  phase1
//
//  Created by manya mehta on 21/11/23.
//

import Foundation
import CoreLocation
import Combine

let apiKey = APIKeys.apiKey

struct YelpApiService{
    //search term , location and category
    //output to update list
    var search : (String, CLLocation, String?) -> AnyPublisher<[Business], Never>
}

extension YelpApiService{
    
    static let live = YelpApiService { term, location, cat in
        //url component for yelp endpoint
        var urlComponents = URLComponents(string: "https://api.yelp.com")!
        print("API Key loaded successfully: \(apiKey)")
        urlComponents.path = "/v3/businesses/search"
        urlComponents.queryItems = [
            .init(name: "term", value: term),
            .init(name: "longitude", value: String(location.coordinate.longitude)),
            .init(name: "latitude", value: String(location.coordinate.latitude)),
            .init(name: "categories", value: cat ?? "restraunts"),
        ]
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        //URL request and return coffee places
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .print("manya")
            .breakpointOnError()
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .map(\.businesses)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
//MARK: -SearchResult
struct SearchResult : Codable {
    let businesses : [Business]
}

// MARK: - Welcome
struct Business : Codable {
    let rating: Double?
    let price, phone, id: String?
    let categories: [Category]?
    let reviewCount: Double?
    let name: String?
    let url: String?
    let coordinates: Coordinates?
    let imageURL: String?
    let businessLocation: BusinessLocation?
    let distance: Double?
    let transactions: [String]?
    enum CodingKeys: String, CodingKey {
        case rating, price, phone, id
        //case isClosed = "is_close"
        case categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageURL = "image_url"
        case businessLocation = "location"
        case distance, transactions
    }
}
//struct Business: Codable {
//    let rating: Int?
//    let price, phone, id: String?
//    let categories: [Category]?
//    let reviewCount: Int?
//    let name: String?
//    let url: String?
//    let coordinates: Coordinates?
//    let imageURL: String?
//    let businessLocation: BusinessLocation?
//    let distance: Double?
//    let transactions: [String]?
//
//    enum CodingKeys: String, CodingKey {
//        case rating, price, phone, id, alias
//        case isClosed = "is_close"
//        case categories
//        case reviewCount = "review_count"
//        case name, url, coordinates
//        case imageURL = "image_url"
//        case businessLocation = "location"
//        case distance, transactions
//    }
//}

// MARK: - Category
struct Category: Codable {
    let alias, title: String?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double?
}

// MARK: - Location
struct BusinessLocation: Codable {
    let city, country, address2, address3: String?
    let state, address1, zipCode: String?
    
    enum CodingKeys: String, CodingKey {
        case city, country, address2, address3, state, address1
        case zipCode = "zip_code"
    }
    
}

