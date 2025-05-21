//
//  GridView.swift
//  BTCA
//
//  Created by call151 on 2025-04-24.
//

import SwiftUI

struct GridView: View {
    @Environment(BTCAViewModel.self) var viewModel

    @Binding var path: [Screen]
    
//    @State private var selectedDisplayStyle: CellStyle = CellStyle.loadFromUserDefaults()
    @State private var draggingItem: Cellule?
    @State var items: [Cellule]
    @State var cellStyle: CellStyle
    
    var body: some View {
        GeometryReader { geometry in
            let itemSize = max(150, geometry.size.width / 4 - 10) // Adjusts dynamically
            let isLandscape = geometry.size.width > geometry.size.height
            
            VStack {
//                if !isLandscape {
//                    Text("     ")       // to go lower than Dynamic island
//                }

                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: itemSize), spacing: 1)], spacing: 1) {
                        ForEach(items) { item in
                            cellView(for: item)
                                .frame(maxWidth: 300)
                                .frame(height: 100)
                                .background(item.color)
                                .foregroundColor(.black)
                                .cornerRadius(4)
                                .onDrag {
//                                    viewModel.displayCanUpdate = false   // after testing -> it is not needed but maybe shuld stay there
                                    draggingItem = item
                                    let dragData = "\(item.id)|\(item.position)"
                                    return NSItemProvider(object: dragData as NSString)
                                }
                                .onDrop(
                                    of: [.text],
                                    delegate: DropViewDelegate(
                                        item: item,
                                        items: $items,
                                        draggingItem: $draggingItem, viewModel: viewModel
                                    )
                                )
                        }
                    }
                }
                
                Picker("", selection: $cellStyle) {
                    ForEach(CellStyle.allCases) { style in
                        Text(style.name).tag(style)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: cellStyle) {
                    cellStyle.saveToUserDefaults()
                }
                .onChange(of: viewModel.isSetupValidated) {
                    if viewModel.isSetupValidated == false {
                        path.removeAll()
                    }
                }
            }
            .ignoresSafeArea(edges: isLandscape ? .leading.union(.trailing) : [])
//            .ignoresSafeArea(.container, edges: .top)
        }
        .onAppear() {
            viewModel.isAllowedToNavigateAutomatically = false
        }
    }
    
    @ViewBuilder
    private func cellView(for item: Cellule) -> some View {
        switch cellStyle {
        case .basic:
            CellStyleBasicView(item: item)
        case .compact:
            CellStyleCompactView(item: item)
        case .detailed:
            CellStyleDetailedView(item: item)
        }
    }
}






#Preview {
    @Previewable @State var cellStyle: CellStyle = .basic
    @Previewable @State var cellules = [Cellule]()
    @Previewable @State var viewModel = BTCAViewModel()
//    @Previewable @State var path: [Screen] = [Screen.gridView]
    @Previewable @State var path: [Screen] = [Screen]()
  
    GridView(path: $path, items: viewModel.demoData.sorted(by: { $0.position < $1.position }), cellStyle: cellStyle)
        .environment(viewModel)
}
