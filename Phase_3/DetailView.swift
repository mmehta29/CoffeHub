

//
//  DetailView.swift
//  phase1
//
//  Created by manya mehta on 10/11/23.
//
import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
@available(iOS 15.0, *)
struct DetailView : View {
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
   
    @Environment(\.dismiss) private var dismiss
    var business: Business
    //@State var toDeleteView = false
    //@ObservedObject var viewModel = HomeViewModel()
    
    var body: some View{
        
        VStack {
            Text(business.name ?? "no name")
                .font(.title)
               // .padding()
            Text(String(format: "Rating: %.1f", business.rating ?? 0.0))
                .padding(.top, 4)
            Text("Phone number: \(business.phone ?? "0")")
                            .padding(.top, 4)
//            Text("Price: \(business.price ?? "N/A")")
//                            .padding(.top, 4)
            if let location = business.businessLocation {
                            Text("Location:")
                                .font(.headline)
                                .padding(.top, 4)

                            Text("City: \(location.city ?? "")")
                            //Text("State: \(location.state ?? "")")
                            Text("Address: \(location.address1 ?? "") \(location.address2 ?? "") \(location.address3 ?? "")")
                           // Text("ZIP Code: \(location.zipCode ?? "")")
                        }
            Map(
                coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: false,
                userTrackingMode: .none,
                annotationItems: markers
            ) { location in
                MapMarker(coordinate: location.coordinate)
            }
            .frame(height: 500)
        }
        .onAppear {
            if let latitude = business.coordinates?.latitude, let longitude = business.coordinates?.longitude {
                withAnimation {
                    region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
                    )
                    markers = [
                        Location(
                            name: business.name ?? "",
                            coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        )
                    ]
                }
            }
        }

    }
}
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample Business instance for preview
        let sampleBusiness = Business(
            rating: 4.5,
            price: "$$$",
            phone: "123-456-7890",
            id: "sampleID",
            categories: [Category(alias: "sampleAlias", title: "Sample Category")],
            reviewCount: 100,
            name: "Sample Business",
            url: "https://samplebusiness.com",
            coordinates: Coordinates(latitude: 37.7749, longitude: -122.4194),
            imageURL: "https://samplebusiness.com/image.jpg",
            businessLocation: BusinessLocation(
                city: "Sample City",
                country: "Sample Country",
                address2: "Sample Address 2",
                address3: "Sample Address 3",
                state: "Sample State",
                address1: "Sample Address 1",
                zipCode: "12345"
            ),
            distance: 2.5,
            transactions: ["delivery", "pickup"]
        )

        // Use the sampleBusiness in the DetailView preview
        DetailView(business: sampleBusiness)
    }
}














