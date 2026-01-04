# HKWorkoutsWatchApp

A fully functioning workout app for Apple Watch built with SwiftUI and HealthKit.

## About

This project is a follow-through implementation of the WWDC21 code-along session: **[Build a workout app for Apple Watch](https://developer.apple.com/videos/play/wwdc2021/10009/)**

The app demonstrates how to build a complete workout tracking application that integrates with Apple Watch's fitness capabilities while supporting the Always On display state.

## Features

- **Workout Selection**: Carousel-style list for selecting workout types (Run, Bike, Walk)
- **Live Metrics**: Real-time display of heart rate, active energy, distance, and elapsed time
- **Session Controls**: Pause, resume, and end workout functionality
- **Now Playing Integration**: Media controls during workouts
- **Always On Display Support**: Optimized update frequency for low-power display mode
- **Activity Rings**: Visual integration with Apple's Activity Rings
- **Workout Summary**: Post-workout summary with recorded data

## Project Structure

```
MyWorkouts Watch App/
├── MyWorkoutsApp.swift       # App entry point
├── StartView.swift           # Workout type selection
├── SessionPagingView.swift   # TabView for workout session screens
├── ControlsView.swift        # Pause/resume/end controls
├── MetricsView.swift         # Live workout metrics display
├── ElapsedTimeView.swift     # Elapsed time formatting
├── SummaryView.swift         # Post-workout summary
├── ActivityRingsView.swift   # Activity Rings integration
└── WorkoutManager.swift      # HealthKit session management
```

## Key Technologies

- **SwiftUI** - Declarative UI framework
- **HealthKit** - Health and fitness data integration
  - `HKWorkoutSession` - Prepares device sensors for data collection
  - `HKLiveWorkoutBuilder` - Automatically collects samples and events
  - `HKLiveWorkoutDataSource` - Provides live data from active workouts

## Requirements

- watchOS 8.0+
- Xcode 13.0+
- Apple Watch with health sensors

## Capabilities & Permissions

The app requires the following capabilities:
- HealthKit
- Background Modes (Workout processing)

Privacy descriptions configured:
- `NSHealthShareUsageDescription`
- `NSHealthUpdateUsageDescription`

## Resources

- [WWDC21 Session: Build a workout app for Apple Watch](https://developer.apple.com/videos/play/wwdc2021/10009/)
- [HealthKit Documentation](https://developer.apple.com/documentation/healthkit)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)

## License

This project is for educational purposes, following Apple's WWDC21 code-along session.
