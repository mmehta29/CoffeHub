

//
//  HomeViewModel.swift
//  phase1
//
//  Created by manya mehta on 21/11/23.
//

import Foundation
import Combine

final class HomeViewModel : ObservableObject{
    
    @Published var businesses = [Business]()
    @Published var searchText = ""
    
    func search(){
        
        let live = YelpApiService.live
        let lat = LocationDataManager.userLocation.coordinate.latitude
        let lon = LocationDataManager.userLocation.coordinate.longitude
        print(lat, lon)
        live.search("coffee", .init(latitude: lat, longitude: lon), nil)
            .assign(to: &$businesses)
    }
}
