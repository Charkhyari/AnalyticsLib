public struct Analytics {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    public func getDeviceInfo() {
        TrackDevice().trackCurrentDevice()
    }
    
    public func checkAppActive() {
        TrackDevice().viewDidLoad()
    }
    
    public func checkAppInactive() {
        TrackDevice().viewWillDisappear(true)
    }
}
