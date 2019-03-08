
Couch.destroy_all
Customer.destroy_all
SupplierCouch.destroy_all
Supplier.destroy_all

########
#Customers - think about CRUD - CREATE (INSERT), READ (SELECT), UPDATE (UPDATE), DELETE (DELETE)
#########
#To be created within the app itself
###########
#Suppliers
###########
ikea = Supplier.create(name: 'Ikea')
homebase = Supplier.create(name: 'Homebase')
budgetSofas = Supplier.create(name: 'Budget Sofa Store')
barkerAndStonehouse = Supplier.create(name: 'Barker and Stonehouse')
#TODO grow supplier database as new suppliers enter the competitive market using CREATE
##########
#Couch
#########
canSleep = Couch.create(name: 'Can Sleep', functionality: 'Sleeper',length_in_ft: '6', colour: 'Green' )
oldFolder = Couch.create(name: 'The Old Folder', functionality: 'Sleeper',length_in_ft: '7', colour: 'Black' )
theThrone = Couch.create(name: 'The Throne', functionality: 'Recliner',length_in_ft: '10', colour: 'Gold' )
cloudSleeper = Couch.create(name: 'Cloud Sleeper', functionality: 'Sleeper', length_in_ft: '5', colour: 'Grey')
cloudStandard = Couch.create(name: 'Cloud Standard', functionality: 'Standard', length_in_ft: '5', colour: 'Grey')
cloudRecliner = Couch.create(name: 'Cloud Recliner', functionality: 'Recliner', length_in_ft: '5', colour: 'Grey')
epicComfort = Couch.create(name: 'Epic Comfort', functionality: 'Standard', length_in_ft: '6', colour: 'Brown')
epicSleeper = Couch.create(name: 'Epic Sleeper', functionality: 'Sleeper', length_in_ft: '6', colour: 'Red')
epicSleeperBrown = Couch.create(name: 'Epic Sleeper', functionality: 'Sleeper', length_in_ft: '6', colour: 'Brown')
#TODO create a JOIN table for couchs of the same name with different colours.
###########
#Couch Suppliers
###########
ikeaCanSleep = SupplierCouch.create(supplier_id: ikea.id, couch_id: canSleep.id, quantity: '3', price: '600')
ikeaTheThrone = SupplierCouch.create(supplier_id: ikea.id, couch_id: theThrone.id, quantity: '1', price: '1200')
homebaseEpicComfort = SupplierCouch.create(supplier_id: homebase.id, couch_id: epicComfort.id, quantity: '2', price: '600')
homeBaseEpicSleeper = SupplierCouch.create(supplier_id: homebase.id, couch_id: epicSleeper.id, quantity: '2', price: '700')
budgetSofasEpicBrown = SupplierCouch.create(supplier_id: budgetSofas.id, couch_id: epicSleeperBrown.id, quantity: '3', price: '300')
barkerAndStonehouseOldFolder = SupplierCouch.create(supplier_id: barkerAndStonehouse.id, couch_id: oldFolder.id, quantity: '5', price: '700')
barkerAndStoneHouseTheThrone = SupplierCouch.create(supplier_id: barkerAndStonehouse.id, couch_id: theThrone.id, quantity: '5', price: '1000')	
barkerAndStonehouseCloudSleeper = SupplierCouch.create(supplier_id: barkerAndStonehouse.id, couch_id: cloudSleeper.id, quantity: '5', price: '600')	
barkerAndStonehouseCloudStandard = SupplierCouch.create(supplier_id: barkerAndStonehouse.id, couch_id: cloudStandard.id, quantity: '5', price: '300')	
barkerAndStonehouseCloudRecliner = SupplierCouch.create(supplier_id: barkerAndStonehouse.id, couch_id: cloudRecliner.id, quantity: '5', price: '500')	

##TODO Increase for new vendors and stock increases








