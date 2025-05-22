//
//  CircularProgressView.swift
//  Quickspend
//
//  Created by urja 💙 on 2025-04-13.
//

import SwiftUI

struct CircularProgressView: View {
    let progress : Double
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .stroke( Color.green.opacity(0.5),lineWidth: 20)
            
            if progress <= 1 {
                Circle()
                    .trim(from: 0,to : progress)
                    .stroke( Color.green,
                             style: StrokeStyle(
                                lineWidth: 20,
                                lineCap: .round
                             ))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
            } else {
                Circle()
                          .trim(from: 0, to: 1.0)
                          .stroke(Color.green, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                          .rotationEffect(.degrees(-90))
                          .animation(.easeOut, value: progress)

                      // Red arc for amount above budget
                      Circle()
                          .trim(from: 0, to: min(progress - 1.0, 1.0))
                          .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                          .rotationEffect(.degrees(-90 + 360 * 1.0)) // Start from end of green
                          .animation(.easeOut, value: progress)
            }
        }
    }
}

#Preview {
    CircularProgressView(progress: 1.2)
}
