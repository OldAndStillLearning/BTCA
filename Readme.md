# BTCA     
#### BlueTooth Cycle Analyst 
![BTCA-V  64](https://github.com/user-attachments/assets/832026c2-3c0b-453b-9e2d-913a343e3259)

An app to display Cycle Analyst Data on your iPhone. 
You need to build your own serial to UART Bluetooth emitter

*release* 2.001 *Plaform* iPhone, iPad, Mac *Language* SwiftUI 

### For developper 

##### Technology used (Apple Only, no third party code)
CoreData, SwiftData, Swift Charts, iCloud, SwiftUI 


### App View structure 

MainView  
 ├── SetupEditView   
 ├── RideDataListView   
 ├── DeviceListView   
 ├     ├── DeviceDetailView  
 ├
 ├── EditDisplayPreferenceView  
 ├        ├── EditTitleView       
 ├         ├── EditUnitView  
 ├        ├── EditPrecisionView  
 ├       ├── EditPositionView  
 ├        ├── EditColorView  
 ├  
 ├── ChartListView  
 ├       ├── ChartSolarProductionView  
 ├        ├── ChartFlexibleView  
 ├  
 ├── GridView   
 ├── InfoView  


### Manager

| Manager | Usage  |
|:----------|:----------|
| BluetoothDeviceManager    | To allow or denied connection to a device    |
| BluetoothManager    | Receive data through bluetooth    |
| DatabaseManager    | To insert var into context   |
| FichierManager    | FileManager other name to avoid conflit with reserved word   |
| SimulationManager    | For now just show data     |


BTCAView Model is the Central Class - most call goes through it 
MainView is the starting view 
