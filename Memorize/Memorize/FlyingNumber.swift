//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Jill Chang on 2024/6/5.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 2)
}
