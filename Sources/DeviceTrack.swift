//
//  DeviceTrack.swift
//  
//
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("")
            .padding()
    }
    
    func trackCurrentDevice()  {
        let manager = FileManager.default
        let advertisingId: String? = "00000000-0000-0000-0000-000000000000"
        let device = UIDevice.current
        
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let deviceInfo : [String : Any] = ["os_version": device.systemVersion,
                                           "device_display_height": getWindowHeight(),
                                           "device_display_width": getWindowWidth(),
                                           "advertising_tracking_enabled":true,
                                           "advertising_id": advertisingId
        ]
        let dictonary: [String: Any] = ["init":deviceInfo]
        
        do {
            let urlFolder = url.appendingPathComponent("device_info")
            let jsonData = try? JSONSerialization.data(withJSONObject: dictonary, options: .init(rawValue: 0))
            try jsonData?.write(to: urlFolder, options: [.atomicWrite])
        } catch {
            print("error in jsonData")
        }
        
    }
    
    func getWindowHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    func getWindowWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


