# BATTLESHIFT
Built your own API to consume with BATTLESHIFT. This project takes the classic tabletop game and converts to a game that can be played in Postman with POST requests.

## Getting Started
```
clone down repo
bundle
rake db:create
rake db:migrate
```

### Prerequisites

This project was built with Ruby 2.4.1 & Rails 5.1.5
Interesting Gem we used for the first time: 
```
gem 'sendgrid-ruby'
```

## Getting Started
How to play: 
Open Postman from your Applications
Invite a friend to play by registering here: https://command-battleshift.herokuapp.com/
Make sure that you have both of your emails handy - you can find your friend's API code with the app
Put your API key in the header param under X-API-KEY
Put your friend's email in the body param under opponents_email
Your first endpoint is https://command-battleshift.herokuapp.com/api/v1/games to start
Here is a comprehensive list of how the game can be played with all endpoints:
https://github.com/turingschool-examples/battleshift_spec_harness/blob/master/spec/game_play_spec.rb

## Running the tests
use RSpec to run the full test suite 
full spec harness here:
https://github.com/turingschool-examples/battleshift_spec_harness

## Authors
Evil Genius: 
* **Josh Mejia** - (https://github.com/jmejia)

Code Mavens and Pivoting Goddesses:
* **Ellen Cornelius** - (https://github.com/corneliusellen)
* **Katy Welyczko** - (https://github.com/katyjane8)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the Turing School of Software & Design

