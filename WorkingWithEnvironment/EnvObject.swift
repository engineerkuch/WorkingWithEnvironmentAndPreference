//
//  EnvObject.swift
//  WorkingWithEnvironment
//
//  Created by Kelvin KUCH on 06.07.2023.
//

import SwiftUI

class DatabaswConnection: ObservableObject {
    var isConnected: Bool = false
    
    init(isConnected: Bool) {
        self.isConnected = isConnected
    }
}

struct MyView: View {
    @EnvironmentObject var connection: DatabaswConnection
    
    var body: some View {
        VStack {
            if connection.isConnected {
                Text("Connected!")
            } else {
                Image(systemName: "globe")
            }
        }
    }
}
struct EnvObject: View {
    var body: some View {
        NavigationView {
            MyView()
        }.environmentObject(DatabaswConnection(isConnected: true))
    }
}

struct EnvObject_Previews: PreviewProvider {
    static var previews: some View {
        EnvObject()
    }
}
