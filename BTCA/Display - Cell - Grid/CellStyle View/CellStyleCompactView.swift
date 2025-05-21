//
//  CellStyleCompactView.swift
//  BTCA
//
//  Created by call151 on 2025-04-04.
//

import SwiftUI

struct CellStyleCompactView: View {
    let item: Cellule
    var body: some View {
            VStack {
                Text(item.title)
                    .font(.system(size: 20))
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                    .padding(.top, 6)
                Text(item.valueToDisplay)
                   .font(.system(size: 90)) // Base size
                    .lineLimit(1)
                    .minimumScaleFactor(0.55)
                Text(item.unit)
                   .font(.system(size: 20)) // Base size
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                    .padding(.bottom, 6)

            }

    }
}



#Preview {
    CellStyleCompactView(item: Cellule())
}
