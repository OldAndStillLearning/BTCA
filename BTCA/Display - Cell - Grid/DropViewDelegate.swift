//
//  DropViewDelegate.swift
//  BTCA
//
//  Created by call151 on 2025-03-27.
//

import Foundation
import SwiftUI

struct DropViewDelegate: DropDelegate {
    let item: Cellule           // TODO, if struct not let but var
    @Binding var items: [Cellule]
    @Binding var draggingItem: Cellule?
    let viewModel: BTCAViewModel
    
    func dropEntered(info: DropInfo) {
//        viewModel.displayCanUpdate = false            // after testing -> it is not needed but maybe shuld stay there

        guard let draggingItem = draggingItem,
              draggingItem != item,
              let fromIndex = items.firstIndex(of: draggingItem),
              let toIndex = items.firstIndex(of: item) else { return }
        
        withAnimation {
            items.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
        }
    }
    
//    func dropEntered2(info: DropInfo) {
//        viewModel.displayCanUpdate = false
//        print ("dropEntered")
//        guard let draggedItemProvider = info.itemProviders(for: [.text]).first else { return }
//        
//        draggedItemProvider.loadObject(ofClass: NSString.self) { object, _ in
//            DispatchQueue.main.async {
//                guard let draggedData = object as? String,
//                      let draggedIDString = draggedData.split(separator: "|").first,
//                      let draggedID = Int(draggedIDString),
//                      let fromIndex = items.firstIndex(where: { $0.id == draggedID }),
//                      let toIndex = items.firstIndex(where: { $0.id == item.id }),
//                      fromIndex != toIndex else { return }
//                
//                withAnimation {
//                    let movedItem = items.remove(at: fromIndex)
//                    items.insert(movedItem, at: toIndex)
//                    
//                    // 🔁 Update positions
//                    for (index, updatedItem) in items.enumerated() {
//                        updatedItem.position = index
//                    }
//                    
//                    // ✅ Re-sort the array based on new positions
//                    items.sort(by: { $0.position < $1.position })
//                    
//
//                }
//            }
//        }
//    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        

        
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
//        print("Before re-organisation ")
//        imprime(items: items)
//        
        for (index, updatedItem) in items.enumerated() {
            updatedItem.position = index
        }
        
        for item in items {
            let btcaVar = RideDataModel.typeFromID(item.id)
            viewModel.displayPreference.position[btcaVar] = item.position
        }

//        print("\n\nAFTER re-organisation ")
//        imprime(items: items)

        viewModel.displayPreference.save()
//        viewModel.displayCanUpdate = true // after testing -> it is not needed but maybe shuld stay there
        DispatchQueue.main.async {
            draggingItem = nil
        }
        return true
    }
    
    
    func imprime(items: [Cellule]) {
        for item in items {
            let btcaVar = RideDataModel.typeFromID(item.id)
            if  let position2 = viewModel.displayPreference.position[btcaVar] {
                print("id: \(item.id)\tPosition \(item.position)\tPrefPosition \(position2)\tbtcaVar \(btcaVar)\tTitle: \(item.title) ")
            } else { print("BUUGGG ")}
        }
    }
    
}

