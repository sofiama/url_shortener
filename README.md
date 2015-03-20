# shrtnswt

http://shrtnswt.herokuapp.com/

Rails app that creates the shortest possible url

## The setup

1. install the following if missing:
  * install homebrew - run the following:
    * `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
    * `brew update`
  * install ruby and rails -run the following:
    * `brew install rbenv ruby-build`
    * `gem install rails`
    * `rbenv rehash`
  * install pg - run the following:
    * `brew install postgresql`
    * `launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist`

2. fork/clone this repo

3. cd to url_shortener

4. run the following commands:
  * `bundle install`
  * `rake db:create`
  * `rake db:migrate`

5. edit host_name
  * open url.rb
  * change line 41 with your host_name with a trailing slash
    * `host_name = "YOUR_HOST_NAME/"` (ex: `host_name = 'http://localhost:3000/'`)
  * save the changes
 
6. run `rails s`

## Challenges and how they were overcame

1. Creating the algorithm for the shortest possible url.
  * Started out with just using Base64.url_encode64 to encode the original url's id
  * Since the task was to create the shortest possible url, the algorithm was changed (*see below under design decision*)
2. Redirecting depending on the params
  * created a begin rescue method
3. Writing tests
  * read documentations and used binding.pry

## Design Decisions
1. Encode and decode algorithms (aka the short url scheme)
  * Given that the task was to create the smallest possible url, then urls will start with one character, until all characters have been used then two chracters will start being used and so on.
  * Chose to have a character set of using letters a-z, A-Z, and digits 0-9, since those are easily read.
  * Decided to remove vowels and number 0 from the character set in the event that the short url was possibly offensive or can cause confusion (the number 0 and the letter O).
2. Form validation of url to inform user why the short url was not created. Messages are as follows:
  * cannot be empty
  * must be valid url (ie. type http or https)
3. Placements of routes (RESTful)
  * root path is new - because the first thing a user would do is enter a new url to create a short url)
  * new page's submit button will create the short url - because on submit should update the url's short attribute
  * clicking on the link on the show page will open the original url in a new tab - to prevent user from leaving the site
  * entering the show page on the browser will render the original url - to share short links via e-mails etc.
  * index shows the top 100 urls
4. Layout
  * simple and clean designed with bootstrap
  * created a user story
    * if user submits a url, then the shortened url is seen
    * to see the top 100, it was placed in a nav
    * created the most recent url in nav in case, a user just submitted a url, then navigated to the top 100, and forgot what the shortned url was
  
## Future improvements
* On the top 100 page
  * make the hit count respond to js 
    * so that the counter increases up, without refreshing the page
  * have a sort button 
* Possibly create a counter model, so all urls has_one counter
  * so that it can render json
* Add animation using js
