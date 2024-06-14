# Dictionary App

Welcome to the Dictionary App! This app allows users to search for English words and view their definitions with synonyms, translate and solve word quizzes.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Home - Word Search](#home---word-search)
    - [Word Details](#word-details)
    - [Favourite Words](#favourite-words)
    - [Translate Word](#translate-word)
    - [Word Quiz](#word-quiz)
- [Improvements](#improvements)

## Features
### Home Page:
Users can search for English words and view the last 5 search terms.

### Detail Page:
Displays the definitions and top 5 synonyms of the searched word.

### Translate Page:
Translate English words into Turkish and view translations.

### Quiz Page:
Take the quiz to test your knowledge of English words and their meanings.

## Screenshots

| Image 1 | Image 2 | Image 3 |
|---------|---------|---------|
![home](https://github.com/Alihizardere/denemess/assets/79551625/702d618a-df2c-4760-9580-8fdd801f189c)| ![detail-1](https://github.com/Alihizardere/denemess/assets/79551625/cc98c542-9205-499a-a92c-31c415740066)|![detail-2](https://github.com/Alihizardere/denemess/assets/79551625/ec37a6d4-cd3a-491a-b0dc-e66204eb7655)|
| Homepage | Detail I | Detail II |

| Image 4 | Image 5 | Image 6 |
|---------|---------|---------|
![translate](https://github.com/Alihizardere/denemess/assets/79551625/1dfce14e-b0f2-4e1c-8924-c875e0af2176) |![favorites-1](https://github.com/Alihizardere/denemess/assets/79551625/14979a30-ead1-4bdb-8834-97eb9089ddac)| ![favorites-2](https://github.com/Alihizardere/denemess/assets/79551625/a2e94204-3565-48b9-bda5-57e7e31ec431)|
| Translate | Favorites I | Favorites II |


| Image 7 | Image 8 | Image 9 |
|---------|---------|---------|
![quiz-1](https://github.com/Alihizardere/denemess/assets/79551625/ff7950da-148c-4d83-b8bf-3c04936e804a)| ![quiz-2](https://github.com/Alihizardere/denemess/assets/79551625/2dfa07ab-54df-489d-b00b-72f51f0523cc)| ![quiz-3](https://github.com/Alihizardere/denemess/assets/79551625/18a9f49b-11ef-4fc8-83ac-61a44b343873)|
| Quiz I | Quiz II | Quiz III |

## Tech Stack
- Xcode: Version 15.3
- Language: Swift 5.10

## Architecture
![VIPER](https://github.com/Alihizardere/denemess/assets/79551625/f747a9b3-0bb7-467a-a3c2-cafe6fea3935)

The VIPER (View, Interactor, Presenter, Entity, Router) architecture is used for these fundamental reasons:
- **Separation of Concerns:** VIPER clearly separates the app into distinct components: View, Interactor, Presenter, Entity, and Router. This makes the code more modular, testable, and maintainable.
- **Single Responsibility Principle:** Each component in VIPER has a specific role and responsibility. This ensures that each part of the application focuses on one aspect of the functionality, making the app easier to understand and manage.
- **Scalability:** VIPER’s modular structure allows new features or changes to be easily integrated. This enhances the application's scalability and streamlines the development process.

### VIPER Components:
- **View:** Displays what it is told to by the Presenter and relays user input back to the Presenter.
- **Interactor:** Contains the business logic and makes network or database calls.
- **Presenter:** Retrieves data from the Interactor and formats it for display by the View.
- **Entity:** Contains basic model objects used by the Interactor.
- **Router:** Handles navigation and passing data between screens.

Using VIPER helps in creating a clean, organized, and testable codebase, ensuring a better development experience and a more robust application.

## Getting Started
### Prerequisites
Before you begin, ensure you have the following:
- Xcode installed

### Installation
1. Clone the repository:
```bash
git clone https://github.com/Alihizardere/dictionary
```

2. Open the project in Xcode:
```bash
cd Dictionary
open Dictionary.xcodeproj
```
3. Build and run the project.

#### Usage
#### Home - Word Search
- Open the application on your simulator or device.
- Use the search bar to enter a word in English and press the "Search" button.
- Display the last 5 search terms at the bottom of the search bar. Tap on any of them and the word details will be displayed.

#### Word Details
- The details screen shows the definitions of the searched word.
- It displays the top 5 synonyms of the word according to the highest score.

#### Favourite Words
- You can view a list of your favourite words.
- Remove favourite words if you no longer want to keep them in your favourites.

#### Translate Word
- Enter an English word in the search bar.
- View the translation of the word in Turkish.

#### Word Quiz
- Test your knowledge with interactive quizzes.
- Quizzes include questions on word meanings, synonyms and translations.
- Track your progress and improve your vocabulary.

## Improvements
- Some bugs could be resolved to enhance the user experience.
