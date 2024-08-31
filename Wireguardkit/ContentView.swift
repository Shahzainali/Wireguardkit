//
//  ContentView.swift
//  supavpn
//
//  Created by Shahzain Ali on 27/08/2024.
//

import SwiftUI

struct ContentView: View {
    var app: WireguardkitApp

    var body: some View {
        VStack {
            Button(action: {
                app.turnOnTunnel { isSuccess in
                    print("Tunnel turned on: \(isSuccess)")
                }
                        }) {
                            Text("Turn On Tunnel")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }

                        // Button to call turnOffTunnel
                        Button(action: {
                            app.turnOffTunnel()
                        }) {
                            Text("Turn Off Tunnel")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
        }
        .padding()
    }
}

#Preview {
    ContentView(app: WireguardkitApp())
}
