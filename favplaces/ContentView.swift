//////
//////  ContentView.swift
//////  favplaces
//////
//////  Created by Goodness Ade on 2024-12-26.
//////
////import Foundation
////import MapKit
////import SwiftUI
////
////struct ContentView: View {
////    @StateObject private var locationManager = LocationManager()
////    @State private var viewmodel = ViewModel()
////
////    var body: some View {
////        NavigationStack {
////            ZStack {
////                Group {
////                    if locationManager.locationStatus == .denied || locationManager.locationStatus == .restricted {
////                        Text("Location access is denied. Please enable it in settings.")
////                    } else if let region = locationManager.region {
////                        MapReader { proxy in
////                            Map(position: .constant(region)) {
////                                UserAnnotation()
////                                ForEach(viewmodel.locations) { location in
////                                    Annotation(location.name, coordinate: location.coordinate) {
////                                        Image(systemName: "star.circle")
////                                            .resizable()
////                                            .foregroundStyle(.blue)
////                                            .frame(width: 44, height: 44)
////                                            .background(.white)
////                                            .clipShape(.circle)
////                                            .onLongPressGesture(minimumDuration: 0.2) {
////                                                viewmodel.selectedPlace = location
////                                            }
////                                    }
////                                }
////                            }
////                            .onTapGesture { position in
////                                if let coordinate = proxy.convert(position, from: .local) {
////                                    viewmodel.addLocation(at: coordinate)
////                                }
////                            }
////                        }
////                    } else {
////                        ProgressView()
////                    }
////                }
////
////                VStack {
////                    Spacer()
////                    HStack {
////                        Spacer()
////                        Button(action: {
////                            locationManager.requestLocation()
////                        }) {
////                            Image(systemName: "location.circle.fill")
////                                .resizable()
////                                .frame(width: 50, height: 50)
////                                .foregroundColor(.blue)
////                                .background(.white)
////                                .clipShape(Circle())
////                                .shadow(radius: 4)
////                        }
////                        .padding()
////                    }
////                }
////            }
////            .navigationTitle("Favorite Places")
////            .toolbar {
////                Button("Reset Pins", role: .destructive) {
////                    viewmodel.clearSavedLocations()
////                }
////            }
////            .sheet(item: $viewmodel.selectedPlace) { place in
////                EditView(location: place) {
////                    viewmodel.updateLocation(location: $0)
////                }
////            }
////            .onAppear {
////                locationManager.requestLocation()
////            }
////        }
////    }
////}
////
////#Preview {
////    ContentView()
////}
////
////  ContentView-ViewModel.swift
////  favplaces
////
////  Created by sammy hutchinson on 2024-12-26.
////
//
import Foundation
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var viewmodel = ViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                // Map content ignoring the safe area
                Group {
                    if locationManager.locationStatus == .denied || locationManager.locationStatus == .restricted {
                        Text("Location access is denied. Please enable it in settings.")
                    } else if let region = locationManager.region {
                        MapReader { proxy in
                            Map(position: .constant(region)) {
                                UserAnnotation()
                                ForEach(viewmodel.locations) { location in
                                    Annotation(location.name, coordinate: location.coordinate) {
                                        Image(systemName: "star.circle")
                                            .resizable()
                                            .foregroundStyle(.blue)
                                            .frame(width: 44, height: 44)
                                            .background(.white)
                                            .clipShape(Circle())
                                            .onLongPressGesture(minimumDuration: 0.2) {
                                                viewmodel.selectedPlace = location
                                            }
                                    }
                                }
                            }
                            .onTapGesture { position in
                                if let coordinate = proxy.convert(position, from: .local) {
                                    viewmodel.addLocation(at: coordinate)
                                }
                            }
                        }
                        .ignoresSafeArea() // Map ignores the safe area
                    } else {
                        ProgressView()
                            .ignoresSafeArea() // Consistent display
                    }
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            withAnimation(.spring(duration: 0.5)) {
                                locationManager.requestLocation()
                            }
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
            .navigationTitle("Favorite Places")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Welcome to")
                        .font(.headline) // This ensures the title is left-aligned
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset Pins") {
                        viewmodel.clearSavedLocations()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
            }
            .sheet(item: $viewmodel.selectedPlace) { place in
                EditView(location: place) {
                    viewmodel.updateLocation(location: $0)
                }
            }
            .onAppear {
                locationManager.requestLocation()
            }
        }
    }
}

#Preview {
    ContentView()
}
