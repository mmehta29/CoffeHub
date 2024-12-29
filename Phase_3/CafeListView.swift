

//
//  CafeListView.swift
//  phase1
//
//  Created by manya mehta on 21/11/23.
//
import CoreLocation
import MapKit
import SwiftUI
import UIKit
import Foundation

struct myLocation: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
@available(iOS 15.0, *)
struct CafeListView : View {
    @State private static var defaultLocation = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    // state property that represents the current map region
    @State private var region = MKCoordinateRegion(
        center: defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    // state property that stores marker locations in current map region
    @State private var markers = [
        Location(name: "Tempe", coordinate: defaultLocation)
    ]
    @State var address:String
    @State var lon: String
    @State var lat: String
    
    @Environment(\.dismiss) private var dismiss
    
    @State var toDeleteView = false
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View{
        
        
        List(viewModel.businesses, id: \.id) { business in
                HStack{
                    NavigationLink(destination: DetailView(business: business)) {
                        Text(business.name ?? "no name")
                            .padding()
                            .cornerRadius(20)
                            .frame(width:150, height:100)
                            .border(.black)
                            .background(.brown)
                            .foregroundColor(.black)
                            .padding()
                        
                        if let imageURL = business.imageURL, let url = URL(string: imageURL){
                            AsyncImage(url: url, content: { returned in
                                returned
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:100, height:100)
                                    .cornerRadius(20)
                            }, placeholder: {
                                ProgressView()
                            }
                            )
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Coffee")
            .searchable(text : .constant(""))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Image(systemName: "person")
                }
            }
            .onAppear {
                viewModel.search()
            }
        }
}
@available(iOS 15.0, *)
struct File_Previews: PreviewProvider {
    static var previews: some View {
        CafeListView(address: "", lon: "", lat: "")
    }
}

