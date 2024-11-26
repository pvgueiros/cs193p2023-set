//
//  Shape+Extension.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 25/11/24.
//

import SwiftUI

extension Shape {
    
    func stripe(lineWidth: CGFloat, spacing: CGFloat) -> some View {
        ZStack {
            self
                .stroke(lineWidth: lineWidth)
            Stripes(spacing: spacing)
                .stroke(lineWidth: lineWidth)
                .clipShape(self)
        }
    }
}
