//
//  SSMainListViewModel.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/13/21.
//

import Foundation

class SSMainListViewModel {
    
    var arduinos: [ArduinoModel]?
    
    func getModels(page: Int? = 0, successfulCallBack: (([ArduinoModel]) -> Void)?, failedCallBack: FailedCallBack? = nil) {
        //TODO: Server call
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            let arduino1 = ArduinoModel(name: "Asghar", description: "Hello my name is Asghar and i LOVE lasagna", model: "AEX1023", uniqueId: "12981902841")
            let arduino2 = ArduinoModel(name: "Gholam", description: "Hello my name is Gholam and i LOVE lasagna", model: "AEX10233", uniqueId: "12981902842")
            let arduino3 = ArduinoModel(name: "Parviz", description: "Hello my name is Parviz and i LOVE lasagna", model: "AEX102333", uniqueId: "12981902843")
            let arduino4 = ArduinoModel(name: "Jamshid", description: "Hello my name is Jamshid and i LOVE lasagna", model: "AEX1023333", uniqueId: "12981902844")
            let arduino5 = ArduinoModel(name: "Faramarz", description: "Hello my name is Faramarz and i LOVE lasagna", model: "AEX10233333", uniqueId: "12981902845")
            let arduino6 = ArduinoModel(name: "Jamaal", description: "Hello my name is Jamaal and i LOVE lasagna", model: "AEX102333333", uniqueId: "12981902846")
            let arduino7 = ArduinoModel(name: "Kamaal", description: "Hello my name is Kamaal and i LOVE lasagna", model: "AEX10233333333", uniqueId: "12981902847")
         
            self.arduinos = [arduino1, arduino2, arduino3, arduino4, arduino5, arduino6, arduino7]
            
            successfulCallBack?(self.arduinos!)
        })
        
        
    }
    
    func addNewModel() {
        
    }
    
    func removeModel() {
        
    }
    
    func getFullModel() {
        
    }
}
