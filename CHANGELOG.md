## 0.2.0 (Pro Upgrade Phase 1)
* **Responsive System**: 
    * Standardized `Breakpoints` constants (Tablet: 600, Desktop: 1200).
    * Updated `ResponsiveBuilder` for breakpoint-aware layouts.
    * Added `ContextExtensions` helpers: `isTablet`, `isDesktop`, `isLandscape`.
* **Advanced UI**:
    * Added `EasyTheme` controller for runtime theme switching (Light/Dark/System).
    * Added `GlassCard` gradient support.
    * Added `AppRadius`, `AppSpacing`, `AppDurations` design tokens.
* **Utilities**:
    * Added `EasyDebounce` and `EasyThrottle` for event handling.
    * added `setStateSafe` extension.
* **Breaking Changes**:
    * Renamed/Refactored `BreakPoints` to `Breakpoints` with static constants.

## 0.1.6

* **Major Example Overhaul**: Added `UtilitiesDemoScreen` and `UIDemoScreen` to showcase every feature (Encryption, Storage, SkeletonLoaders, etc.).
* **API Standardization**: 
    * Standardized `AppStorage` with `read`/`write` aliases.
    * Standardized `EncryptionUtil` with `encrypt`/`decrypt` static aliases.
    * Added `SkeletonLoader` for shimmering loading states.
    * Standardized `EasyLoader` with `show`/`hide` methods.
    * Added `EasyDialog` for simplified adaptive dialog calls.
* **Documentation**: Overhauled `README.md` with categorized API guides and detailed code snippets.

## 0.1.5

* Added `EasyApi`: A high-level static networking wrapper with integrated caching and retries.
* Added `RetryInterceptor` for resilient HTTP requests.
* Added a Networking Demo to the example dashboard.

## 0.1.4

* Overhauled the `example` project with a premium dashboard showcasing all major features (Responsive sizing, GlassCard, DateSelectors, Adaptive widgets, etc.).
* Fixed minor bugs in the example navigation.

## 0.1.3

* Added `HorizontalDateSelector` widget (scrolling date picker).
* Improved `AdaptiveButton` with documented parameters.

## 0.1.2

* Fixed deprecated `Color.withOpacity` (replaced with `Color.withValues`).
* Shortened package description and fixed repository URLs in `pubspec.yaml` for better Score.
* Added `AdaptiveBadge` widget.
* Added documentation comments to public API members (`AdaptiveButton`, `AdaptiveBadge`, etc.).
* Added a comprehensive example showcasing all major features.
* Updated dependencies to latest stable versions.

## 0.1.1

* Added `TimeLogCalendar` widget for a modern, expandable calendar UI.
* Added `google_fonts` dependency.

## 0.1.0

* Added `ContextExtensions` for easier navigation, theme, and media query access.
* Added `StringExtensions` for validation and formatting.
* Added `DateTimeExtensions` for relative time (time ago).
* Added `AppStorage` utility for easy local storage management.
* Added `GenericApiService` base class for streamlined API development.
* Added `GlassCard` widget for modern glassmorphism effects.
* Refined `EncryptionUtil` with better documentation and string encryption support.
* Updated exports and versioning for public release.

## 0.0.1

* Initial release with core responsive utilities and basic widgets.
