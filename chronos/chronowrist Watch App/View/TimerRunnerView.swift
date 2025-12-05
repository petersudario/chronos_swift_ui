//
//  TimerRunnerView.swift
//  chronos
//
//  Created by Pepo on 05/12/25.
//

import SwiftUI

struct TimerRunnerView: View {
    @StateObject private var viewModel: TimerRunnerViewModel
    @Environment(\.dismiss) var dismiss
    
    init(preset: Preset) {
        _viewModel = StateObject(wrappedValue: TimerRunnerViewModel(preset: preset))
    }
    
    var body: some View {
        VStack {
            switch viewModel.runnerState {
            case .preparing:
                prepareView
            case .running:
                runningView
            case .finished:
                finishedView
            }
        }
        .onAppear {
            viewModel.startEngine()
        }
        .onDisappear {
            viewModel.stopEngine()
        }
        .navigationBarBackButtonHidden(true)
    }
        
    var prepareView: some View {
        VStack {
            Spacer()
            
            Text("Get Ready")
                .font(.headline)
                .foregroundStyle(.secondary)
                .accessibilityAddTraits(.isHeader)
            
            Text(viewModel.timeRemaining > 0 ? "\(Int(viewModel.timeRemaining))" : "Start!")
                .font(.system(size: 60, weight: .bold, design: .rounded))
                .contentTransition(.numericText())
                .foregroundStyle(.green)
                .accessibilityLabel(viewModel.timeRemaining > 0 ? "\(Int(viewModel.timeRemaining)) seconds" : "Start")
                .accessibilityAddTraits(.updatesFrequently)
            
            Spacer()
            
            Button(action: {
                viewModel.stopEngine()
                dismiss()
            }) {
                Text("Cancel")
                    .foregroundColor(.red)
            }
            .padding(.bottom, 20)
            .accessibilityLabel("Cancel countdown")
            .accessibilityHint("Goes back to the preset list")
        }
    }
    
    var runningView: some View {
        VStack(spacing: 5) {
            Spacer()
            
            VStack {
                if let step = viewModel.currentStep {
                    Text(step.type.rawValue.capitalized)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(step.type == .work ? .green : .orange)
                        .opacity(viewModel.isPaused ? 0.6 : 1.0)
                    
                    Text(viewModel.formattedTime())
                        .font(.system(size: 50, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.white)
                        .opacity(viewModel.isPaused ? 0.6 : 1.0)
                    
                    Text("Step \(viewModel.currentStepIndex + 1) of \(viewModel.preset.steps.count)")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.updatesFrequently)
            .accessibilityLabel(voiceOverStatusString())
                      
            HStack(spacing: 30) {
                Button(action: {
                    viewModel.stopEngine()
                    dismiss()
                }) {
                    ZStack {
                        Circle()
                            .fill(.red.opacity(0.2))
                            .frame(width: 40, height: 40)

                        Image(systemName: "xmark")
                            .font(.body)
                            .foregroundStyle(.red)
                    }
                }
                .buttonStyle(.plain)
                .accessibilityLabel("End Workout")
                
                Button(action: {
                    withAnimation {
                        viewModel.togglePause()
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: viewModel.isPaused ? "play.fill" : "pause.fill")
                            .font(.body)
                            .foregroundStyle(.black)
                    }
                }
                .buttonStyle(.plain)
                .accessibilityLabel(viewModel.isPaused ? "Resume Timer" : "Pause Timer")
            }
            .padding(.bottom, 20)
        }
    }
    
    var finishedView: some View {
        VStack(spacing: 20) {
            Image(systemName: "flag.checkered")
                .font(.largeTitle)
                .foregroundStyle(.yellow)
                .accessibilityHidden(true)
            
            Text("Workout Complete!")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            HStack(spacing: 15) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.bordered)
                .tint(.red)
                .accessibilityLabel("Close")
                
                Button(action: {
                    viewModel.restart()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                }
                .buttonStyle(.bordered)
                .tint(.green)
                .accessibilityLabel("Restart Workout")
            }
        }
    }
    
    private func voiceOverStatusString() -> String {
        guard let step = viewModel.currentStep else { return "" }
        return "\(step.type.rawValue), \(viewModel.formattedTime()) remaining, Step \(viewModel.currentStepIndex + 1) of \(viewModel.preset.steps.count)"
    }
}
