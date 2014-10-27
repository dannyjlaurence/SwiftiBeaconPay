//
//  iBeaconDelegate.swift
//  TaylorSwift
//
//  Created by Laurence, Daniel J. on 10/24/14.
//  Copyright (c) 2014 Laurence, Daniel J. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class iBeaconDelegate: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    let UUID = NSUUID(UUIDString:"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
    var region:CLBeaconRegion = CLBeaconRegion()
    
    override init(){
        super.init()
        
        // set delegate, not the angle brackets
        self.locationManager.delegate = self;
        
        //Need to actually request authorization 
        // To read more, go here
        // http://nevan.net/2014/09/core-location-manager-changes-in-ios-8/
        //
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        //This string is the UUID we will listen for explicity
        self.region = CLBeaconRegion(proximityUUID: UUID, identifier: "com.test.testregion")
        
        // launch app when display is turned on and inside region
        region.notifyEntryStateOnDisplay = true;

        var test = CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion)
        if (test)
        {
            self.locationManager.startMonitoringForRegion(region)
            
            // get status update right away for UI
            self.locationManager.requestStateForRegion(region)
        }
        else
        {
            NSLog("This device does not support monitoring beacon regions");
        }

    }
    
    //Sends a notice that you are inside the beacon
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!){
        NSLog("Inside");
        self.locationManager.startRangingBeaconsInRegion(self.region)
    }
    
    //Sends a notice that you are outside the beacon
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!){
        NSLog("Outside");
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        NSLog(locations.debugDescription);
    }
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!){
        NSLog(region.debugDescription)
    }
    
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
        println("BM didDetermineState \(state)");
        
        switch state {
        case .Inside:
            println("BeaconManager:didDetermineState CLRegionState.Inside");
        case .Outside:
            println("BeaconManager:didDetermineState CLRegionState.Outside");
        case .Unknown:
            println("BeaconManager:didDetermineState CLRegionState.Unknown");
        default:
            println("BeaconManager:didDetermineState default");
        }
    }
    
}