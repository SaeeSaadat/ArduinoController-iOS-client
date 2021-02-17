//
//  SSMainListViewModel.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/13/21.
//

import Foundation

class SSMainListViewModel {
    
    var arduinos: [SSArduinoModel]?
    
    func getModels(page: Int? = 0, successfulCallBack: (([SSArduinoModel]) -> Void)?, failedCallBack: FailedCallBack? = nil) {
        //TODO: Server call
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
            var funs = [SSArduinoFunction(name: "Start", signalCode: "1234")]
            for _ in 0...50 { funs.append(funs[0]) }
            let arduino1 = SSArduinoModel(name: "Asghar", description: "Hello my name is Asghar and i LOVE lasagna", model: "AEX1023", uniqueId: "12981902841", functions: funs)
            let arduino2 = SSArduinoModel(name: "Gholam", description: "Hello my name is Gholam and i LOVE lasagna", model: "AEX10233", uniqueId: "12981902842")
            let arduino3 = SSArduinoModel(name: "Parviz", description: "Hello my name is Parviz and i LOVE lasagna", model: "AEX102333", uniqueId: "12981902843")
            let arduino4 = SSArduinoModel(name: "Jamshid", description: "Hello my name is Jamshid and i LOVE lasagna", model: "AEX1023333", uniqueId: "12981902844")
            let arduino5 = SSArduinoModel(name: "Faramarz", description: "Hello my name is Faramarz and i LOVE lasagna", model: "AEX10233333", uniqueId: "12981902845")
            let arduino6 = SSArduinoModel(name: "Jamaal", description: "Hello my name is Jamaal and i LOVE lasagna", model: "AEX102333333", uniqueId: "12981902846")
            let arduino7 = SSArduinoModel(name: "Kamaal", description: "Hello my name is Kamaal and i LOVE lasagna", model: "AEX10233333333", uniqueId: "12981902847")
         
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
