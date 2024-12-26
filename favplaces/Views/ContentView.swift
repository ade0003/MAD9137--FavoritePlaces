
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var viewModel = LocationViewModel()
    // this is the main view of the app

    var body: some View {
        NavigationStack {
            ZStack {
                if locationManager.locationStatus == .denied || locationManager.locationStatus == .restricted {
                    Text("Location access is denied. Please enable it in settings.")
                } else {
                    // this displays the map with locations

                    MapView(
                        region: .constant(locationManager.region ?? .automatic),
                        locations: viewModel.locations,
                        onLocationTap: { location in
                            viewModel.selectedPlace = location
                        },
                        onMapTap: { coordinate in
                            viewModel.addLocation(at: coordinate)
                        }
                    )

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                locationManager.requestLocation()
                            } label: {
                                Image(systemName: "location.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.blue)
                                    .background(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Favorite Places")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Welcome to")
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset Pins") {
                        viewModel.clearSavedLocations()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
            }
            // this shows the edit sheet when a place is selected

            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) { updatedLocation in
                    viewModel.updateLocation(location: updatedLocation)
                }
            }
            // this requests location when view appears

            .onAppear {
                locationManager.requestLocation()
            }
        }
    }
}
