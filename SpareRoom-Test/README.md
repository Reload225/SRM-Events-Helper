# SpareRoom-Test (SRM Event Helper)

Hiya!  
This is my solution for the SpareRoom test task.

## Description

I tried to implement everything that was mentioned in the requirements:

- The main feature - displaying the list of events sorted by status - has been completed.
- I used SwiftUI, as requested in the task.
- The following states are supported:
  - Splash screen  
  - Event screen (ideal state)  
  - Event screen (error state)  
  - Event screen (offline state)
  - Event screen (loading state)  
- Light and dark mode support is added (first time doing dark mode - great experience!).

## Implementation Details

### UI / Layout

- I started with UIKit at first, but after reading the task again, I switched to SwiftUI.
- I tried to implement the glassmorphism effect, but it didn’t look right. I need more time to explore how to do it properly in SwiftUI.
- The Button doesn’t fully match the design in some states, because of the same reason.

### Architecture

- I was thinking to use MVC with separation of responsibilities and protocols (to make testing and replacing dependencies easier), but then I realized it would remind me of VIPER or Clean Swift. So I decided to choose Clean Swift, because it clearly separates layers, shows dependencies, and makes the app easier to scale. For navigation, I would prefer using the Coordinator pattern instead of the default router in Clean Swift, because it gives more flexibility and keeps navigation logic separate.
- Files are organized by logic: `Helpers`, `Components`, `Resources`, `Screens`, etc.

### Image Handling

- I made a custom `ImageLoader` for async image loading.
- I use `NSCache` to cache images - this helps avoid loading the same image again and doesn’t block the main thread.
- Manual cache clearing isn’t added, because `NSCache` manages memory by itself.
- But it’s important to know that in low-memory situations (like on devices with little RAM), `NSCache` might not free memory fast enough, especially when working with many or large images. This can cause app crashes due to memory issues.  
  Ideally, I should add my own logic to control cache size or use a forced clean-up policy when a limit is reached.

### API and Security

- The API key is obfuscated using a method from an [NSHipster article] (https://nshipster.com/secrets/). offering a simple solution.
- Everything is done using only basic code, no third-party libraries used.

### Theme Support

- The color palette is in `Assets.xcassets` and supports both light and dark mode.
- All strings are in `Localizable.strings`.

### Other

- I made a `DateFormatterFactory` to work with dates more easily.
- Splash screen is done via `LaunchScreen.storyboard` - a quick solution.  
  But there’s a bug with the `safeArea` on different devices (with notch, with Dynamic Island, and without). Maybe it’s a `LaunchScreen` limitation.  
  Ideally, a separate controller should be used for full control.

## Design Mismatches and Issues

- Glassmorphic UI didn't turn out as expected
- The Button doesn’t fully match the design.
- The UI could be cleaner in general.

## Conclusion

I think, considering the time and that I haven’t worked with SwiftUI much since the end of 2022 - the result is pretty good.  
I’m especially happy that I got experience building complex UI using SwiftUI methods.

## Feedback

I’d be really glad to discuss my solution on a call - I’m sure I’ll get useful feedback and will be able to improve my skills even more.

Thanks for the task - it was fun to do, especially from the UI point of view, even with a few challenges.
