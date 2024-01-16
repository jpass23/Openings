# Openings (Release soon!)
An app for studying chess openings and learning them by name. This is a **WORK IN PROGRESS** and still needs a bit of work before I would consider version 1 to be complete. Releasing it on the app store soon after some testing.

## Description

There are two main sections of this app:
- The *Learn* section
- The *Practice* section

In the Learn section, the user chooses an opening from a dropdown (there are currently only 3). They also choose what side they want to be viewing the board from (black or white). Then they can use arrows to go forward and backward through the moves and see the changes. This serves as an encyclopedia.

The Practice section is where the user can go to play out the moves and check to see if they have mastered the opening. It will look very similar to the Learn section with choosing a color and an opening, but the board will be interactive.

## Screenshots:
<div align=left>

<img src="https://github.com/jpass23/Openings/blob/main/Screenshots/Main%20Page.png" width="250"/>

<img src="https://github.com/jpass23/Openings/blob/main/Screenshots/Board%20Page.png" width="250"/>

<img src="https://github.com/jpass23/Openings/blob/main/Screenshots/Settings%20Page.png" width="250"/>

</div>


## Design Structure

This app uses basic MVVM structure. However, all of my models are stored in a file named `structs.swift` and an admitedly poorly named `model.swift` contains a `Model` class for the app's central state. This is instantiated once then injected into the environment at the root. Any view that needs to edit the state need only get the Model out of the environment with the `@EnvironmentObject` property wrapper and make changes. Since it is a class (reference type), these changes will be reflected throughout the app.

## Future Plans

1. Add more openings. There are currently only 5 in the app but there are over 1000 that have been named
    - Pull the list of openings out into an external database so that these don't clog up the swift file
2. Animate the moves. Currently the pieces just disappear from their current square and appear at the new square. I would like to use something like the GeometryReader to animate the path inbetween.
3. Finish fleshing out the Practice section. Add sounds and make the computer play the opposing moves.
4. Add a 'mastery' property to openings that can be reached with 3 successful practices of that opening.
5. Finish the 'contact me'
6. Add more customizable settings.

