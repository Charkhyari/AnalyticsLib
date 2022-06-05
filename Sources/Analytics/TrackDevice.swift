//
//  TrackDevice.swift
//  
//
//

import UIKit

enum State {
    case background
    case foreground
}

public class TrackDevice: UIViewController {
    var second = 0
    var dictonaryActive : [String : Any] = [:]
    var dictonaryBackground : [String : Any] = [:]
    var state: State = .background
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:  UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.openAndCloseActivity), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openAndCloseActivity), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func openAndCloseActivity(_ notification: Notification)  {
        if notification.name == UIApplication.didBecomeActiveNotification{
            Timer.scheduledTimer(timeInterval: 5.0,target: self, selector: #selector(getDuration), userInfo: nil, repeats:true)
            self.state = .background
        }else{
            Timer.scheduledTimer(timeInterval: 5.0,target: self, selector: #selector(getDuration), userInfo: nil, repeats:true)
            self.state = .foreground
        }
    }
    
    @objc func getDuration() {
        second = second + 1
        let age = second / 5
        let duration = second % 5
        switch state {
        case .background:
            dictonaryBackground = ["result": "Pause",
                                   "duration": duration,
            ]
        case .foreground:
            dictonaryActive = ["duration": duration,
                               "event_age": age
            ]
        }
    }
    
    func trackCurrentDevice()  {
        let manager = FileManager.default
        let deviceInfo = UIDevice.current
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let dictonary : [String : Any] = ["os_version": deviceInfo.systemVersion,
                                          "device_display_height": getWindowHeight(),
                                          "device_display_width": getWindowWidth(),
                                          "advertising_tracking_enabled":true,
                                          "advertising_id": UUID().uuidString
        ]
        let dic: [String: Any] = ["init":dictonary,"match":self.dictonaryBackground,"session":self.dictonaryActive]
        
        do {
            let urlFolder = url.appendingPathComponent("\(UUID().uuidString)"+"\(Date())")
            let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: .init(rawValue: 0))
            print(url)
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
