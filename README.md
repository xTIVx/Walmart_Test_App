# Walmart_Test_App

The Movie DB
The assignment is to build a mobile app to help people discover the most popular movies. The app will
consist of a homepage displaying them and tapping on a movie should display additional details.
Scroll through the list of the current most popular movies. Each movie in the list should display, if
available: thumbnail, title, popularity score and release year. List should not be limited to show only
the first 20 movies as returned by the API.
The movie details page should display all of the fields mentioned above and if available: overview,
runtime and a link to the movie homepage.
The genre's name should be present on both screens (Home and Details screen).

API
The API can be found here: https://www.themoviedb.org/documentation/api It will be necessary to register
for a free API key. Please contact us if you have any difficulty obtaining an API key.

Instructions
The application must be developed using the latest version of Swift and Xcode.
You are free to use any third-party libraries you wish and any dependency manager you wish.
You are free to design the UI as you see fit, but it should work in both portrait and landscape mode.
Our team actively researches and experiments with new and existing architectures. For this app
decide on an appropriate architecture (E.g. MVC, MVVM, VIPER etc.) and implement it throughout the
app.
Please use git and show us your process for managing code (e.g. frequency of pushing code up,
what you include in commit messages, branching etc.).
This assessment and design choices will form part of the next stages of your interview. We are
looking for a level of code quality that you would be comfortable shipping in production. Use this as
an opportunity to demonstrate your ability, thought processes and best practices.


Work Description:
- Used design patterns: MVVM, Singleton and Delegate
  - MVVM used because it allows me to easily scale my application, 
      due to the differentiation of functionality into different modules, 
      makes it easy to read and understand the behavior of the code.
  - Singleton used in APIHandler file because API using during runtime and can be used in multiple places.
  - Delegate used to set updated Move to DetailViewController's UI elements.
- Used CollectionView to show movie list
- Using EndPoints for different types of requests
- Created universal url builder using EndPoints
- APIHandler and ViewModels covered with UnitTests
- No third-party libraries, only native code


Screenshots:

[![Simulator-Screen-Shot-i-Phone-11-Pro-Max-2021-07-16-at-10-35-50.png](https://i.postimg.cc/50bwb71L/Simulator-Screen-Shot-i-Phone-11-Pro-Max-2021-07-16-at-10-35-50.png)](https://postimg.cc/kVYVyy2g)
[![Simulator-Screen-Shot-i-Phone-11-Pro-Max-2021-07-16-at-10-16-32.png](https://i.postimg.cc/QtQ0qKNk/Simulator-Screen-Shot-i-Phone-11-Pro-Max-2021-07-16-at-10-16-32.png)](https://postimg.cc/MMG76TQv)

