//
//  View+Extensions.swift
//
//
//  Created by Jill Chang on 2024/6/26.
//

import SwiftUI

public extension View {
    func cardify(isSelected: Bool) -> some View {
        modifier(Cardify(isSelected: isSelected))
    }
}
