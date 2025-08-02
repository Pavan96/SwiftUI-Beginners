//
//  ContentView.swift
//  SwifUI-API-List
//
//  Created by Pavan More on 28/07/25.
//

import SwiftUI

//https://api.github.com/users/Pavan96

struct ContentView: View {
    
    @State private var user: GitHubUser?
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user?.avatarUrl ?? ""))  { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.gray)
                    
            }.frame(width: 120, height: 120)
            
            Text(user?.login ?? "")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "")
                .padding()
                
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
            } catch GHError.invalidResponse {
                print("Invalid response")
            } catch GHError.invalidData {
                print("Invalid data")
            } catch {
                print("Error")
            }
        }
    }
    
    func getUser() async throws -> GitHubUser {
        let endPoint = "https://api.github.com/users/Pavan96"
        
        guard let url = URL(string: endPoint) else {
            throw GHError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GitHubUser: Codable {
    let login:String
    let avatarUrl: String
    let bio: String
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
