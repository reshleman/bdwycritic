# BdwyCritic

[BdwyCritic] is a review aggregator for Broadway shows (*à la* [Metacritic]), developed by [Robert Eshleman] as a capstone project for the [Metis] Ruby on Rails bootcamp.

Check it out at http://www.bdwycritic.com.

## Description

BdwyCritic provides a forum for theatergoers to view and post reviews about Broadway shows. Users can also view a list of reviews published by critics about each show.

As an aggregator, BdwyCritic provides information about the popularity of shows based on both user-provided ratings and textual analyses of published critic reviews.

## External Services

This application uses two external services that require API credentials:

* [New York Times Event Listings API] - for importing information (name, description, closing date, venue) for current Broadway shows.
* [AlchemyLanguage API] - for performing textual analysis (including title and author extraction and sentiment analysis) of published critic reviews.

BdwyCritic expects these credentials to be stored in ENV variables. For the development and test environments, you can set these variables in a `.env` file in the project root.

A `.env.sample` file is provided for guidance:

```
NYT_EVENTS_API_KEY=foo_bar_baz
ALCHEMY_API_KEY=foo_bar_baz
```

## Rake Task

BdwyCritic provides one rake task for importing and updating events (shows) via the [New York Times Event Listings API]:

```
rake events:import
```

This task imports the event name, description, closing date, and venue for any new events. In addition, it updates locally any events that have changed in the remote data source.

## Development Resources

There's a [Trello Board] full of user stories, if you're interested in that kind of thing.

[BdwyCritic]: https://github.com/reshleman/bdwycritic
[Metacritic]: http://www.metacritic.com/
[Robert Eshleman]: https://github.com/reshleman
[Metis]: http://www.thisismetis.com
[http://www.bdwycritic.com/]: http://www.bdwycritic.com/
[Trello Board]: https://trello.com/b/ma8uIYeS
[New York Times Event Listings API]: http://developer.nytimes.com/docs/events_api
[AlchemyLanguage API]: http://www.alchemyapi.com/products/alchemylanguage/
