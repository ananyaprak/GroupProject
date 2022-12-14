**Name of Project:** Crossle: Sprint!\
**Team Members:** Ananya Prakash, Zachary Bricken\
**Dependencies:** Xcode 13.4.1, Swift 5.6.1, iOS 15.5, FirebaseAuth

**Special Instructions**
- Use iPhone 13 Pro Max Simulator in Portrait Mode
- Puzzle answers are listed here: https://docs.google.com/document/d/1q9Zl8nX0a1lPkDyOhJu2InKX8qoFwc27mOWnSGZjfmk/edit?usp=sharing
- Please create an account to playtest

**Required Feature Checklist**\
Some features have been omitted due to 2 of our members dropping the class (with permission from the Professor)

- [x] Login/register path with Firebase
- [x] “Settings” screen. The three behaviors we implemented are:
  - Choose game mode
  - Toggle elapsed time
  - Toggle total tries
- [x] Non-default fonts and colors used

Two major elements used out of the following: Core Data, User Profile path using camera and photo library, Multithreading, SwiftUI. We implemented:
- [x] User Profile
- [x] Multithreading

Minor elements used:
- Two additional view types such as sliders, segmented controllers, etc. The two we implemented are:
  - [x] Segmented controllers
  - [x] *waived*
- One of the following: Table View, Collection View, Tab VC, Page VC. We implemented: 
  - [x] Table View
- [x] Two of the following: Alerts, Popovers, Stack Views, Scroll Views, Haptics, User Defaults. We implemented:
  - [x] Alerts
  - [x] *waived*
- [x] One of the following per team member: *waived*

**Work Distribution Table**
| Required Feature | Description | Who/Percentage Worked On |
| --- | ----- | --- |
| Login/Register | Set up Firebase, configure login/register/lougout paths | Ananya (100%) |
| UI Design | Select and implement fonts, colors, and layout throughout app | Ananya (70%), Zachary (30%) |
| Settings | Allow users to configure data in puzzle table and change gamemode, save in coredata | Ananya (100%) |
| Instructions | Explain gameplay how-to | Zachary (100%) |
| Game Logic | Create and implement game using coding logic | Ananya (100%) |
| Images | Create logo, crosswords, and app pic | Ananya (65%), Zachary (35%) |
| Profile | Create profile page, show/save high scores and profile pic | Ananya (25%), Zachary (75%) |
| Multithreading | Show and save elapsed time per puzzle | Ananya (100%) |

https://github.com/ananyaprak/GroupProject/graphs/contributors

**Future Updates**\
If we were to continue to update this app, we would love to implement the following (all of which we have already started creating the code for):
- A second gamemode, where puzzle data is persistent across launches with core data
- More puzzle formats, where labels are moved programmatically
