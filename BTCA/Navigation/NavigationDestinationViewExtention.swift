//
//  NavigationDestinationViewExtention.swift
//  BTCA
//
//  Created by call151 on 2025-05-06.
//

import Foundation
import SwiftUI

extension View {
    func acceuilNavigationDestination(path: Binding<[Screen]>, viewModel: BTCAViewModel, selectedDisplayStyle: CellStyle) -> some View {
        self.navigationDestination(for: Screen.self) { screen in
            switch screen {

 
            case .chartListView:
                ChartListView(path: path)

            case .chartSolarProductionView:
                ChartSolarProductionView(path: path)
                
            case .chartFlexibleView:
                ChartFlexibleView(path: path)

            case .chartMultipleDataView:
                    ChartMultipleDataView(path: path)
                
            case .deviceListView:
                DeviceListView(path: path)

            
            case .editDisplayPreferenceView:
                EditDisplayPreferenceView(path: path)

            case .editColorView:
                EditColorView()

            case .editPositionView:
                EditPositionView()

            case .editPrecisionView:
                EditPrecisionView()

            case .editTitleView:
                EditTitleView()

            case .editUnitView:
                EditUnitView()

            case .filesPrefView:
                FilesPrefView()
//                FilesPrefView(path: path)

            case .gridView:
                GridView(
                    path: path,
                    items: viewModel.demoData.sorted(by: { $0.position < $1.position }),
                    cellStyle: selectedDisplayStyle
                )

            case .infoView:
                InfoView(path: path)
                
            case .rideDataListView:
                RideDataListView(path: path)

            case .setupEditView:
                SetupEditView(path: path)
            }
        }
    }
}
