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
        List(results) { user in
            Text(user.name)
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
