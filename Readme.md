# BTCA     
### BlueTooth Cycle Analyst 
![BTCA-V  64](https://github.com/user-attachments/assets/832026c2-3c0b-453b-9e2d-913a343e3259)

An app to display Cycle Analyst Data on your iPhone. 
You need to build your own serial to UART Bluetooth emitter
it is multiplaform, mostly to be able to study graph on a Mac or iPad instead of an iPhone. 

*release* 2.001 *Plaform* iPhone, iPad, Mac *Language* SwiftUI 


## For User


#### Visual 
Blue button send you to another page.  
Green button is an action.  
I need help to make those view nice, I am bad a visual design (and coding... :-)


#### Connecting
On starting the app, it will scan for a bluetooth device that advertize UART (Universal asynchronous receiver-transmitter).   

if one is found, it will connect and you will be automatically send to the GridView
if none IS found after 15 seconds, it will stop but you can restart scan at anytime.  
When you rescan, you will have to navigate to the GridView manually. 


#### Setup 
You define your setup here, mostly value you enter in Cycle Analyst, like battery Volt and Ah, if you want to save data to file, location, type of firmware, metric or Imperial  etc.  

if you dont want data sync through cellular, you can turn cellular off the BTCA in setting. Same thing for icloud syncing off.  

  
#### GridView
in GridView, at the bottom, you have 3 differents way to display the data. You can reorder the cell. The default GridView order in solar is a little bit different than in the standard firmware

You can change the color of cell in the DisplayPreference view. You can also change the title Text at top of each cell, and the unit text at the bottom. You can also change the number of digit after the dot.  

#### Chart  
Solar:  
Select a date range and solar production will be plot on a graph with a series for each day you selected (and have data). 

Flexible:
Select a date range and a var to get the graph, you can also export the requested data in a TSV file.

#### Simulation mode  
it is just to play with the app if you dont have a bluetooth transmitter

#### Battery is full now.    
We dont have a % level of battery on eBike. By using Ah (in and out) and Volt, the app tries to calculate a value, but it need to know when the battery is full and start to 
  
  
  
## For developper 

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

the RideDataModel is where all received data from Cycle Analyst and calculated data are store. That what's is sync through iCloud. 

... more to come
