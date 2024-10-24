//
//  UserView.swift
//  FriendshipFetcher
//
//  Created by Izabela Marcinkowska on 2024-10-23.
//

import SwiftUI

struct UserView: View {
    @Environment(\.modelContext) private var modelContext
    let user: User
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Header Section
                VStack(alignment: .leading, spacing: 10) {
                    Text(user.isActive ? "🟢 Active" : "🔴 Inactive")
                        .font(.headline)
                        .foregroundColor(user.isActive ? .green : .red)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .cornerRadius(10)
                
                // Personal Information Section
                GroupBox(label: Label("Personal Information", systemImage: "person.fill")) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Age:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(user.age)")
                        }
                        Divider()
                        HStack {
                            Text("Company:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(user.company)
                        }
                        Divider()
                        HStack {
                            Text("Email:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(user.email)
                        }
                        Divider()
                        VStack (alignment: .leading){
                            Text("Address:")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            Text(user.address)
                        }
                    }
                    .padding()
                }
                
                // About Section
                GroupBox(label: Label("About", systemImage: "info.circle.fill")) {
                    Text(user.about)
                        .padding()
                }
                
                if !user.tags.isEmpty {
                    GroupBox(label: Label("Tags", systemImage: "tag.fill")) {
                        LazyVGrid(columns: columns) {
                            ForEach (user.tags, id: \.self) { tag in
                                Text(tag)
                            }
                        }
                    }
                }
                
                if !user.friends.isEmpty {
                    GroupBox(label: Label("Friends", systemImage: "person.2.fill")) {
                        VStack(spacing: 5) {
                            ForEach(user.friends) { friend in
                                Text(friend.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        
                    }
                }
            }
            .padding()
        }
        .navigationTitle(user.name)
    }
}
// Provide a sample User for the preview
// Inside your extension User
extension User {
    static let sampleUser: User = {
        // Parse the date string into a Date object
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        let registeredDate = isoFormatter.date(from: "2015-11-10T01:47:18-00:00") ?? Date()

        // Create sample friends
        let sampleFriends = [
            Friend(id: UUID(uuidString: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0")!, name: "Hawkins Patel"),
            Friend(id: UUID(uuidString: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6")!, name: "Jewel Sexton"),
            Friend(id: UUID(uuidString: "be5918a3-8dc2-4f77-947c-7d02f69a58fe")!, name: "Berger Robertson")
        ]

        // Create the sample user
        let user = User()
        user.id = UUID(uuidString: "50a48fa3-2c0f-4397-ac50-64da464f9954")!
        user.isActive = false
        user.name = "Alford Rodriguez"
        user.age = 21
        user.company = "Imkan"
        user.email = "alfordrodriguez@imkan.com"
        user.address = "907 Nelson Street, Cotopaxi, South Dakota, 5913"
        user.about = "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt."
        user.registered = registeredDate
        user.tags = ["cillum", "consequat", "deserunt", "nostrud", "eiusmod", "minim", "tempor"]
        user.friends = sampleFriends

        return user
    }()
}


#Preview {
    UserView(user: User.sampleUser)
        .modelContainer(for: [User.self, Friend.self])
}
