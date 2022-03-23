//
//  GameVibrationMotor.swift
//  ArcadeGameTemplate
//
//  Created by Tiago Pereira for the Developer Academy on 23/03/22.
//

import CoreHaptics

class GameVibrationMotor {
    
    let hapticEngine: CHHapticEngine
    
    init?() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        
        guard hapticCapability.supportsHaptics else {
            return nil
        }
        
        do { hapticEngine = try CHHapticEngine() } catch let error {
            print("Haptic engine creation error: \(error)")
            return nil
        }
        
        do {
            try hapticEngine.start()
        } catch let error {
            print("Haptic failed to start: \(error)")
        }
        
        hapticEngine.isAutoShutdownEnabled = true
    }
    
    func playCollision() async {
        do {
            let pattern = try collisionPattern()
            try await hapticEngine.start()
            let player = try hapticEngine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
            
//            hapticEngine.notifyWhenPlayersFinished { _ in
//                return .stopEngine
//            }
        } catch let error {
            print("Failed to play slice: \(error)")
        }
    }
    
}

extension GameVibrationMotor {
    
    private func slicePattern() throws -> CHHapticPattern {
        let slice = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.35),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.25)
            ],
            relativeTime: 0,
            duration: 0.25)
        
        let snip = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ],
            relativeTime: 0.08)
        
        return try CHHapticPattern(events: [slice, snip], parameters: [])
    }
    
    private func collisionPattern() throws -> CHHapticPattern {
        let collision = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ],
            relativeTime: 0,
            duration: 0.3)
        
        return try CHHapticPattern(events: [collision], parameters: [])
    }
}
