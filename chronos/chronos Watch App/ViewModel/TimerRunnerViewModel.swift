//
//  TimerRunnerViewModel.swift
//  chronos
//
//  Created by Pepo on 05/12/25.
//

import SwiftUI
import Combine

class TimerRunnerViewModel: ObservableObject {
    let preset: Preset
    
    @Published var runnerState: RunnerState = .preparing
    @Published var timeRemaining: TimeInterval = 3
    @Published var currentStepIndex: Int = 0
    @Published var isPaused: Bool = false
    
    private var timer: AnyCancellable?
    
    var currentStep: Step? {
        if currentStepIndex < preset.steps.count {
            return preset.steps[currentStepIndex]
        }
        return nil
    }
    
    init(preset: Preset) {
        self.preset = preset
    }
    
    func startEngine() {
        runnerState = .preparing
        timeRemaining = 3
        currentStepIndex = 0
        isPaused = false
        startTimerPayload()
    }
    
    private func startTimerPayload() {
        stopEngine()
        
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    func stopEngine() {
        timer?.cancel()
        timer = nil
    }
    
    func togglePause() {
        isPaused.toggle()
        
        if isPaused {
            stopEngine()
        } else {
            startTimerPayload()
        }
    }
    
    func restart() {
        stopEngine()
        startEngine()
    }
    
    private func tick() {
        // Se estiver pausado, não faz nada (embora o timer já deva estar parado pela lógica acima)
        guard !isPaused else { return }
        
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            handleTimeFinished()
        }
    }
    
    private func handleTimeFinished() {
        switch runnerState {
        case .preparing:
            runnerState = .running
            loadStep(index: 0)
            
        case .running:
            let nextIndex = currentStepIndex + 1
            if nextIndex < preset.steps.count {
                loadStep(index: nextIndex)
            } else {
                finish()
            }
            
        case .finished:
            break
        }
    }
    
    private func loadStep(index: Int) {
        currentStepIndex = index
        if let step = currentStep {
            timeRemaining = step.duration
        }
    }
    
    private func finish() {
        runnerState = .finished
        stopEngine()
    }
    
    func formattedTime() -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
