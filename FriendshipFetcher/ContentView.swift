//
//  ContentView.swift
//  FriendshipFetcher
//
//  Created by Izabela Marcinkowska on 2024-10-23.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [User]()
    func loadData() async{
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                results = decodedResponse
            }
        } catch {
            print("Error fetching data")
        }
    }
    
    var body: some View {
        NavigationStack{
            List (results){ user in
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
            if results.isEmpty {
                
                await loadData()
            } else {
                print("Already loaded data")
            }
        }
        
    }
}

#Preview {
    ContentView()
}
