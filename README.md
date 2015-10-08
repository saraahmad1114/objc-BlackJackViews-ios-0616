

# BlackJack Views

## Objectives

1. Connect existing data models to a view controller in order to display them.
2. Use `UILabel`s to present information about the current state of your program to your user.
3. Use `UIButton`s to incorporate user interaction into your logical structure.
4. Employ the `hidden` and `enabled` view properties.

## Introduction

In this lab, you're going to take code from the previous `OOP-Cards-Model` and `objc-blackjack` labs to create a visual interface for your data models. You'll use a series of `UILabel`s to show your user the state of the blackjack game, and use a few `UIButton`s to control the actions available.

Most of the tests for this lab (in `FISBlackjackViewControllerSpec.m`) actually taps around in the simulator and looks at the various views. It's primarily limited to looking at the content of the labels and being able to press the three buttons that you see, essentially mimicking how your end user might utilize interface presented to them. It will be largely up to you to structure your code in a such a way that accomplishes the expected outputs. 

The testing suite is also not thorough due to the difficulty presented by the randomness of the cards that are drawn, so it's possible to pass the tests yet still have unusual behavior for a blackjack game. Don't rely solely on the testing suite to tell you when something's wrong!

## Instructions 

Open the `objc-BlackjackViews.xcworkspace` file and navigate to the `Main.storyboard` file. You'll see a view controller already laid out for you with the necessary labels and buttons for playing Blackjack! However, they're not connected to a class file.

![](https://curriculum-content.s3.amazonaws.com/ios/objc-blackjack-views/blackjack_storyboard.png)

1. Create a new view controller subclass called `FISBlackjackViewController`. Connect the 23 `UILabel`s as outlets in the header file, making their property names consistent with their names in the storyboard file. (*You may ignore the labels which read `House` and `Player`*).

2. Connect the three `UIButton`s first as outlets (properties), then as `IBAction`s (methods). Add the word "Tapped" to the names of the `IBAction` methods to disambiguate them from the property getters.

3. Copy in your `FISCard`, `FISCardDeck`, `FISBlackjackPlayer`, and `FISBlackjackGame` class files that you wrote when solving the `objc-Blackjack` lab (the debug console version).

4. Add a `FISBlackjackGame` property to the view controller's header file named `game` and one method named `playerMayHit` that returns a `BOOL`. This should be enough to allow the tests to compile.

**Note:** *Because of the randomization inherent to playing blackjack, some of the tests on* `FISBlackjackViewController` *may pass or fail intermittently due to various case being dealt or drawn.*

### Envision the Problem

Before writing any code, put yourself (as the developer) in the mental position of the Blackjack dealer. What steps do you need to take to run a game of Blackjack? You already have several things going for you: you have a deck that can shuffle itself; your opponent (the "player") knows the rules of Blackjack; and your "house rules" dictate when you should hit or stay so you can let the current state of your own hand make that decision for you. With those in mind, the process of running a game of Blackjack, might follow these steps:

1. When the player asks you to deal, give two cards each to yourself and to the player. Then evaluate your own hand and ask the player the state of their own hand. If a winner is already apparent, the game should end.

2. If the game continues, you would then ask the player to hit or to stay. If they choose to hit, they should receive one card. If the player has not bust, then you as the "house" should take your turn.

3. If the player decides to stay, then you as the "house" should finish taking the cards that you must take until your hand's score requires you to stay. Then evaluate the winner of the round.

4. Continue asking the player to hit or stay until they either bust or stay. Evaluate the winner when the round has ended and declare the winner. Record the result in a tally of wins and losses.

### Write A Single-Use Implementation

Don't tackle the whole problem at once. Start at the beginning and work in small units, running your scheme frequently. 

1. In the view controller's `viewDidLoad` method, set up the `game` property so that you have working instance of `FISBlackjackGame`. Use the `hidden` property on the UIViews to hide the labels that shouldn't be shown when the application loads (such as `winner` label, the "cards" that have not been dealt yet, and the "stayed", "busted", and "blackjack" status labels).

![](https://curriculum-content.s3.amazonaws.com/ios/objc-blackjack-views/blackjack_initial_view.png)  
— *A possible setting upon startup.*

2. Implement the `dealTapped` method to deal a new game. This method should update any views that it may have affected, particularly the score labels and the first two card views for the house and the player.

3. This `dealTapped` method should enable the `hit` and `stay` buttons if your user is permitted to hit (i.e. neither of you has won yet). Write the implementation for the `playerMayHit` method to determine whether the user is entitled to hit (i.e. the player has not busted, stayed, nor holds a blackjack hand). Use the boolean return of this method to determine whether your user has the option to hit or stay.
**Note:** *There are tests to verify the* `playerMayHit` *method's implementation.*

4. Write the implementation for the `hitTapped` method. This should:
  * add a card to the player's hand,
  * evaluate if the player can have another turn,
	  * if so, it should offer a turn to the house,
	  * if not, it should disable the `hit` and `stay` buttons and send the round into a "conclusion" method.
  * update the views with new information.

5. Write the implementation for the `stayTapped` method. This should:
  * flip the player's `stayed` boolean to `YES`,
  * update the views, and
  * offer a turn to the house (make sure to update the views again after the house's turn).

6. Because the player's choice to `hit` or `stay` might be revoked before the end of the round in some cases, you should write a method that concludes the round. If the player has busted, the house has won. However, if the player has stayed or holds a blackjack hand, the house should continue to play until it either busts or can no longer hit because of its "house rules." Once the house can no longer player, determine the winner and display it using the "winner" label. Increment the wins and losses labels appropriately.

At this point, you should have a generally-functional single-round game. It should show new cards as they're dealt and update the score appropriately.
    
**Hint:** *You can set a label's* `text` *property to a matching* `cardlabel` *in that player's* `cardsInHand` *array. You can then unhide the card views which have altered labels.*

**Hint:** *Property objects (such as views) can be stored in collections just like local object variables can. Those collections may or may not be held as properties themselves.*

![](https://curriculum-content.s3.amazonaws.com/ios/objc-blackjack-views/blackjack_busted.png)

### Reset the Game

To allow your user to play a second round of blackjack without restarting the application, you should detect when the round has ended and reenable the `deal` button while displaying the winner. Whenever the `deal` button is pressed, it should reset the views for a fresh round. 

**Hint:** *You will need to be sure to reset the underlying data held in the* `FISBlackjackGame` *instance before altering the views. Does the* `dealNewRound` *method reset the deck and the cards held by the player and the house?*

**Hint:** *If you're already preparing the views for the first game, is there code that you can reuse to prepare for the second game?*

**Hint:** *Don't let cards from previous rounds still show up after the reset; you'll confuse (and frustrate) the user!*

![](https://curriculum-content.s3.amazonaws.com/ios/objc-blackjack-views/blackjack_blackjack.png)
— *Play multiple games without reloading.*

## Advanced

Save your current progress in a commit, especially if you have not done so since cloning the lab.

### Reduce, Reuse, Refactor

Look through your code. Is it easy to follow? Is there duplicated code that can be moved into a private method? Are your method implementations long and cryptic? 

Refactor your code to reduce duplications and improve readability. Test often to identify when a change may have broken something. *Don't be afraid to experiment! Remember that if you make a mess of your code shortly after a commit, you can reset your git as a safety net.*

### Empathize With The User

Now that you've written the application from the perspective of the system, flip your perspective to that of the user. Play a few rounds of the game to get a sense of the user experience. Is there anything lacking from your presentation? Are labels appearing at times when they shouldn't?

Here's something to look for:

In casino blackjack, while the player's cards are dealt face up, the house's card are dealt with one face *down* (and the rest face up) in order to obfuscate the house's actual hand and score. When a player must decide to hit or stay, they do not know the house's exact score (but will get told if the house stays or if the house busts). It's not *really* blackjack if you're always showing your user the house's cards and score!

So, adapt your code to only show the label of the house's first card at the *end* of the round. Use a unicode character of your choice (perhaps ❂ ) as the symbol for the "back" of this one card. Show the card's value when the winner declared. Similarly, you should hide the house's score until the *end* of the round, and **not** tell the user when the house holds a blackjack.

![](https://curriculum-content.s3.amazonaws.com/ios/objc-blackjack-views/blackjack_facedown.png)  
— *Obfuscating the house's hand and score.*

### Customize the Color Scheme

This lab was presented with flat design, but you can easily change many of the font and background colors right in Interface Builder. Play around with these basic settings to customize your blackjack game. You can resize and reorganize the buttons and labels to a certain degree, but make sure the layout remains legible and tactile to the user!

### Download An Alumni's Blackjack App

In the iOS App Store, search for "Flatiron Blackjack" and download the app published by Flatiron School, Inc. This is an app written by Flatiron iOS alumni inspired by the idea of this exercise (it is obviously more fully implemented than it is here).