//
//  FloatingAddButton.swift
//  Quickspend
//
//  Created by urja 💙 on 2025-04-13.
//

import SwiftUI

struct FloatingAddButton: View {
    var action: () -> Void

    var body: some View {
        Button(action : action) {
            Image(systemName: "plus")
                .font(.title)
                .foregroundStyle(.white)
                .padding()
                .background(Color.green.opacity(0.70))
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding(.trailing,20)
        .padding(.bottom,30)
    }
}

#Preview {
    FloatingAddButton(action: {})
}
