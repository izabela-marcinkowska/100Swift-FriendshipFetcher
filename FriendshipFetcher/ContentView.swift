//
//  ContentView.swift
//  FriendshipFetcher
//
//  Created by Izabela Marcinkowska on 2024-10-23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \User.name) private var users: [User]
    func loadData() async{
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                DispatchQueue.main.async {
                    for user in decodedResponse {
                        self.modelContext.insert(user)
                    }
                    try? self.modelContext.save()
                }
            } else {
                print("Failed to decode JSON")
            }
        } catch {
            print("Error fetching data")
        }
    }
    
    var body: some View {
        NavigationStack{
            List (users){ user in
                NavigationLink(value: user) {
                    VStack (alignment: .leading){
                        Text(user.name)
                        Text(user.isActive ? "Active" : "Inactive")
                            .foregroundStyle(user.isActive ? .green : .gray)
                        
                    }
                }
            }
            .navigationTitle("Friendship Fetcher")
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
        }
        .task {
            if users.isEmpty {
                
                await loadData()
            } else {
                print("Already loaded data")
            }
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [User.self, Friend.self])
}
