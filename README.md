# GrapedMoviez

A gem with a lightweight grape/sequel ruby app that provides small API that emulates a dummy cinema reservations site

## Requirements

Requires Ruby 2.5.6
Requires Postgres >= 9.5
Requires an env var with the DATABASE_URL address, i.e. on `/etc/profile`, add this line: 
```
export DATABASE_URL='postgres://postgres@localhost:5433/graped_moviez_dev'
```
save the file and run `sudo source /etc/profile`

## Installation

Clone this repo and go to the parent directory

And then execute:

    $ bundle

Then, once the dependencies are installed, run the migrations locally by running


    $ sequel -m lib/db/migrations postgres://host/dev_database

or

    $ bundle exec rake db:migrate

Then, once the migrations are in place, run the db:seed if you want to populate the DB

    $ bundle exec rake db:seed


## Usage

Run the app under the parent directore as follows:
`/graped_moviez (ruby-2.5.6) [master] $ rackup`

This API has the following endpoints:

```
                     Renders a list of movies.  v1     GET /api/v1/movies(.json)
                              Creates a movie.  v1    POST /api/v1/movies(.json)
                                Creates a day.  v1    POST /api/v1/days(.json)
Creates a Function from a given movie and date  v1    POST /api/v1/functions(.json)
        Renders a list of movies by functions.  v1     GET /api/v1/functions(.json)
 Renders a list of reservations by time range.  v1     GET /api/v1/reservations(.json)
                        Creates a reservation.  v1    POST /api/v1/reservations(.json)

```

### Heroku

Access the app in heroku

https://graped-moviez-cinema.herokuapp.com/api/movies

or the endpoints

```
GET https://graped-moviez-cinema.herokuapp.com/api/movies
POST https://graped-moviez-cinema.herokuapp.com/api/days
POST https://graped-moviez-cinema.herokuapp.com/api/functions
GET https://graped-moviez-cinema.herokuapp.com/api/reservations
POST https://graped-moviez-cinema.herokuapp.com/api/reservations
```
### Using the endpoints
GET movies

Renders a list of movies.  v1     GET /api/movies(.json)

http://localhost:9292/api/movies

returns

```
{
    "movie": [
        {
            "id": 1,
            "name": "Alien",
            "description": "Lorem ipsum dolor sit amet.",
            "image_url": "https://images.gowatchit.com/posters/original/p9384_p_v7_as.jpg"
        },
        {
            "id": 2,
            "name": "Star Wars, The Last Jedi",
            "description": "Lorem ipsum dolor sit amet.",
            "image_url": "https://i.pinimg.com/originals/f3/c3/8e/f3c38ee96eb5b212330a4f2d967b5699.jpg"
        },
        {
            "id": 3,
            "name": "Paw Patrol Mighty Pups",
            "description": "Lorem ipsum dolor sit amet.",
            "image_url": "https://img.elcomercio.pe/files/ec_article_multimedia_gallery/uploads/2019/05/23/5ce6dd0d910df.jpeg"
        },
        {
            "id": 13,
            "name": "Terminator II",
            "description": "Lorem ipsum dolor sit amet.",
            "image_url": "Lorem ipsum dolor sit amet."
        }
    ]
}

```
POST movies

Creates a movie.  v1    POST /api/movies(.json)

request

```
{
  "movie": {
	"name": "Terminator II",
	"description": "Lorem ipsum dolor sit amet.",
	"image_url": "https://somepath.com/terminator_II.jpeg"
  }
}
```
returns

```
{
    "movie": {
        "id": 14,
        "name": "Terminator I",
        "description": "Lorem ipsum dolor sit amet.",
        "image_url": "https://somepath.com/terminator_I.jpeg"
    }
}
```

POST days

Creates a day for functions.  v1    POST /api/days(.json)

request

```
{
  "day": {
	"day": "2019-09-29"
  }
}
```
returns

```
{
    "day": {
        "id": 8,
        "day": "2019-09-29"
    }
}
```


GET functions
http://localhost:9292/api/functions?day=2019-09-22
Returns a list of functions for given day.  
v1    GET /api/days(.json)

returns

```
{
    "functions": [
        {
            "id": 1,
            "day": {
                "id": 1,
                "day": "2019-09-22"
            },
            "movie": {
                "id": 1,
                "name": "Alien",
                "description": "Lorem ipsum dolor sit amet.",
                "image_url": "https://images.gowatchit.com/posters/original/p9384_p_v7_as.jpg"
            }
        }
    ]
}
```

POST reservations

request

```
{
  "reservation": {
	"movie": "Alien",
	"day": "2019-09-22",
	"seats": 2,
	"user_email": "gastus@hotmail.com"
  }
}
```
response

```
{
    "reservation": {
        "id": 32,
        "seats": 2,
        "user_email": "gastus@hotmail.com",
        "day": {
            "id": 1,
            "day": "2019-09-22"
        },
        "movie": {
            "id": 1,
            "name": "Alien",
            "description": "Lorem ipsum dolor sit amet.",
            "image_url": "https://images.gowatchit.com/posters/original/p9384_p_v7_as.jpg"
        }
    }
}
```

GET reservations

Renders a list of reservations by time range.  v1     GET /api/reservations(.json)

http://localhost:9292/api/reservations?start_date=2019-09-21&end_date=2019-09-24

returns

```
{
    "reservations": [
        {
            "id": 11,
            "day": {
                "id": 1,
                "day": "2019-09-22"
            },
            "movie": {
                "id": 1,
                "name": "Alien",
                "description": "Lorem ipsum dolor sit amet.",
                "image_url": "https://images.gowatchit.com/posters/original/p9384_p_v7_as.jpg"
            },
            "seats": 2,
            "user_email": "some_user1@myemail.com"
        },
        {
            "id": 18,
            "day": {
                "id": 1,
                "day": "2019-09-22"
            },
            "movie": {
                "id": 1,
                "name": "Alien",
                "description": "Lorem ipsum dolor sit amet.",
                "image_url": "https://images.gowatchit.com/posters/original/p9384_p_v7_as.jpg"
            },
            "seats": 2,
            "user_email": "some_user8@myemail.com"
        },
        {
            "id": 32,
            "day": {
                "id": 1,
                "day": "2019-09-22"
            },
            "movie": {
                "id": 1,
                "name": "Alien",
                "description": "Lorem ipsum dolor sit amet.",
                "image_url": "https://images.gowatchit.com/posters/original/p9384_p_v7_as.jpg"
            },
            "seats": 2,
            "user_email": "gastus@hotmail.com"
        },
        {
            "id": 12,
            "day": {
                "id": 2,
                "day": "2019-09-23"
            },
            "movie": {
                "id": 2,
                "name": "Star Wars, The Last Jedi",
                "description": "Lorem ipsum dolor sit amet.",
                "image_url": "https://i.pinimg.com/originals/f3/c3/8e/f3c38ee96eb5b212330a4f2d967b5699.jpg"
            },
            "seats": 2,
            "user_email": "some_user2@myemail.com"
        },
        {
            "id": 19,
            "day": {
                "id": 2,
                "day": "2019-09-23"
            },
            "movie": {
                "id": 2,
                "name": "Star Wars, The Last Jedi",
                "description": "Lorem ipsum dolor sit amet.",
                "image_url": "https://i.pinimg.com/originals/f3/c3/8e/f3c38ee96eb5b212330a4f2d967b5699.jpg"
            },
            "seats": 1,
            "user_email": "some_user9@myemail.com"
        },
        {
            "id": 13,
            "day": {
                "id": 3,
                "day": "2019-09-24"
            },
            "movie": {
                "id": 3,
                "name": "Paw Patrol Mighty Pups",
                "description": "Lorem ipsum dolor sit amet.",
                "image_url": "https://img.elcomercio.pe/files/ec_article_multimedia_gallery/uploads/2019/05/23/5ce6dd0d910df.jpeg"
            },
            "seats": 1,
            "user_email": "some_user3@myemail.com"
        },
        {
            "id": 20,
            "day": {
                "id": 3,
                "day": "2019-09-24"
            },
            "movie": {
                "id": 3,
                "name": "Paw Patrol Mighty Pups",
                "description": "Lorem ipsum dolor sit amet.",
                "image_url": "https://img.elcomercio.pe/files/ec_article_multimedia_gallery/uploads/2019/05/23/5ce6dd0d910df.jpeg"
            },
            "seats": 2,
            "user_email": "some_user10@myemail.com"
        }
    ]
}
```
