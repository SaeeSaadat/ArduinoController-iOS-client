//
//  SSParseArduinoManager.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/18/21.
//

import Foundation
import Parse

class SSParseArduinoManager {
    
    public static func registerArduino(model: SSArduinoModel, success: (() -> Void)?, fail: ((Error) -> Void)? ) {
        let arduino = PFObject(className: "Arduino")
        arduino["name"] = model.name
        arduino["description"] = model.description
        arduino["model"] = model.model
        arduino["serialNumber"] = model.serialNumber
        if let fs = model.functions {
            for f in fs {
                let object = PFObject(className: "ArduinoFunction")
                object["signal"] = f.signalCode
                object["name"] = f.name
                arduino.addObjects(from: [object], forKey: "functions")
            }
        }
        
        PFUser.current()
        
        arduino.acl = PFACL(user: PFUser.current()!)
        
        arduino.saveEventually()
        
        arduino.saveInBackground { succeed, error in
            if let error = error {
                fail?(error)
            } else if succeed {
                success?()
            } else {
                SSNavigationController.shared.showBottomPopUpAlert(withTitle: "Weird situation while saving new arduino", alertState: .failure)
            }
        }
    }
    
    public static func getArduinos(success: (([SSArduinoModel]) -> Void)?, fail: ((Error) -> Void)?) {
        let query = PFQuery(className: "Arduino")
        query.findObjectsInBackground { objects, error in
            
            if let error = error {
                fail?(error)
            } else if let objects = objects{
                let arduinos = objects.compactMap({ object in
                    return SSArduinoModel(obj: object)
                })
                success?(arduinos)
                
            }
            
        }
    }
    
    public static func loadArduino(arduino: SSArduinoModel, success: ((SSArduinoModel) -> Void)?, fail: ((Error?) -> Void)?) {
        let query = PFQuery(className: "Arduino")
        guard let id = arduino.uniqueId else {
            fail?(nil)
            return
        }
        query.getObjectInBackground(withId: id) { object, error in
            
            if let error = error {
                fail?(error)
            } else if let object = object {
                
                var arduino = SSArduinoModel(obj: object)
                
                if let functions = object["functions"] as? [PFObject] {
                    let dispatchGroup = DispatchGroup()
                    var funcs: [SSArduinoFunction] = []
                    functions.forEach({
                        dispatchGroup.enter()
                        $0.fetchInBackground { obj, error in
                            if let error = error {
                                fail?(error)
                            } else {
                                if let name = obj?["name"] as? String, let signal = obj?["signal"] as? String {
                                    funcs.append(SSArduinoFunction(name: name, signalCode: signal))
                                }
                                dispatchGroup.leave()
                            }
                        }
                    })
                    dispatchGroup.notify(queue: .main) {
                        arduino.functions = funcs
                        success?(arduino)
                    }
                }
            }
                
            
        }
    }
    
}
