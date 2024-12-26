//
//  EditView.swift
//  favplaces
//
//  Created by Goodness Ade on 2024-12-26.
//
//
//import SwiftUI
//
//struct EditView: View {
//    @Environment(\.dismiss) var dismiss
//    var location: Location
//
//    @State private var name: String
//    @State private var description: String
//    var onSave: (Location) -> Void
//
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section {
//                    TextField("Place Name", text: $name)
//                    TextField("Description", text: $description)
//                }
//            }
//            .navigationTitle("Favorite Place Details")
//            .toolbar {
//                Button("Save") {
//                    var newLocation = location
////                    newLocation.id = UUID()
//                    newLocation.name = name
//                    newLocation.description = description
//
//                    onSave(newLocation)
//                    dismiss()
//                }
//            }
//        }
//    }
//
//    init(location: Location, onSave: @escaping (Location) -> Void) {
//        self.location = location
//        self.onSave = onSave
//
//        _name = State(initialValue: location.name)
//        _description = State(initialValue: location.description)
//    }
//}
//
//#Preview {
//    EditView(location: .example) { _ in }
//}

//
//  EditView.swift
//  favplaces
//
//  Created by sammy hutchinson on 2024-12-26.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location

    @State private var name: String
    @State private var description: String
    var onSave: (Location) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Favorite Place Details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }

    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

#Preview {
    EditView(location: .example) { _ in }
}
