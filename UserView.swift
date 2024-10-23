//
//  UserView.swift
//  FriendshipFetcher
//
//  Created by Izabela Marcinkowska on 2024-10-23.
//

import SwiftUI

struct UserView: View {
    let user: User
    var body: some View {
        Text("Hello, \(user.name)!")
    }
}

// Provide a sample User for the preview
extension User {
    static let sampleUser = User(
        id: UUID(uuidString: "50a48fa3-2c0f-4397-ac50-64da464f9954")!,
        isActive: false,
        name: "Alford Rodriguez",
        age: 21,
        company: "Imkan",
        email: "alfordrodriguez@imkan.com",
        address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
        about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt.",
        registered: "2015-11-10T01:47:18-00:00",
        tags: ["cillum", "consequat", "deserunt", "nostrud", "eiusmod", "minim", "tempor"],
        friends: [
            Friend(id: UUID(uuidString: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0")!, name: "Hawkins Patel"),
            Friend(id: UUID(uuidString: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6")!, name: "Jewel Sexton"),
            Friend(id: UUID(uuidString: "be5918a3-8dc2-4f77-947c-7d02f69a58fe")!, name: "Berger Robertson"),
            // Add more friends as needed
        ]
    )
}

#Preview {
    UserView(user: User.sampleUser)
}
