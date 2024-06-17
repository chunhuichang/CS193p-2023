//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Jill Chang on 2024/6/5.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    @State
    private var offset: CGFloat = 0
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundStyle(number < 0 ? .red : .green)
                .offset(x: 0, y: offset)
                .opacity(offset == 0 ? 1 : 0)
                .shadow(color: .black, radius: 1.5, x: 1, y: 1)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2)) {
                        offset = number < 0 ? 200 : -200
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
    }
}

#Preview {
    VStack {
        FlyingNumber(number: -1)
        FlyingNumber(number: 0)
        FlyingNumber(number: 2)
    }
}
