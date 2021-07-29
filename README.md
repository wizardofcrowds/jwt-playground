# APIs for Noodle Lovers

With these web APIs, consumers can search venues that serve noodles.

## APIs

### Open API schema

The schema is available at

`HOST/doc/schema.yaml`

### Authentication

Currently not required.

### Freshness of Data

This service is backed by Foursquare Venue Search API. In order to avoid overwhelming the Foursquare API, we cache the response for 24 hours. This means that with the same query paramenters, you would get the same results up to 24 hours.

### Rate Limiting

We may introduce rate limiting after authentication is implemented.

### Noodles API

`GET /v1/noodle_venues`

Required parameters:

- `near` (required): Specify the location of your interest. e.g. New York, NY
- `sort` (optional): distance or relevance. By default, the results are sorted by relevance
- `keyword` (optional): Keyword, such as the restaurant's name, e.g. "Totto ramen"


### Tokens API

`POST /v1/tokens`

If successful, it returns a JWT token that could be used for further authentications.

Required information in the post data:

- `client_identifier` (required)
- `client_secret` (required)


## Setup

This requires the following environment variables `FOURSQUARE_CLIENT_ID` and `FOURSQUARE_CLIENT_SECRET`

## TODOs

- Add JWT based authentication for noodle venues API
- Rate limiting
- Heroku deployment