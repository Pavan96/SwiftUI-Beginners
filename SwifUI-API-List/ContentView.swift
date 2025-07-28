//
//  ContentView.swift
//  SwifUI-API-List
//
//  Created by Pavan More on 28/07/25.
//

import SwiftUI

//https://api.github.com/users/Pavan96

struct ContentView: View {
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(.gray)
                .frame(width: 120, height: 120)
            
            Text("Username")
                .bold()
                .font(.title3)
            
            Text("Here is the description for the github user for the users")
                .padding()
                
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

