public struct Analytics {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    public func getDeviceInfo() {
        TrackDevice().trackCurrentDevice()
    }
}
