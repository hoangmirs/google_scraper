[![Build Status](https://travis-ci.org/hoangmirs/google_scraper.svg?branch=develop)](https://travis-ci.org/hoangmirs/google_scraper)
## Introduction

A web application that will extract large amounts of data from the Google search results page.
By using many workers and change user-agent each request, the app can request google many times.

## Project Setup

### Docker

* Install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

* Setup and boot the Docker containers:

```
./bin/envsetup
```

* Install [Yarn](https://yarnpkg.com/lang/en/docs/install/#mac-tab)

```
brew install yarn
```

### Development
* config/application.yml
```
default: &default
  DB_HOST: ""
  DB_PORT: "5432"
  USERNAME: "postgres"
  MAILER_DEFAULT_HOST: "localhost"
  MAILER_DEFAULT_PORT: "3000"
  MAILER_SENDER: "Test <noreply@nimbl3.co>"
  GOOGLE_CLIENT_ID: ""
  GOOGLE_CLIENT_SECRET: ""

development:
  <<: *default
  DB_NAME: "google_scraper_development"
  SECRET_KEY_BASE: "#{secret_key_base}"

test:
  <<: *default
  DB_NAME: "google_scraper_test"
  TEST_RETRY: "0"
  SECRET_KEY_BASE: "#{secret_key_base}"
```

* Setup the databases:

    * Postgres:

    ```
    rake db:setup
    ```

* Run the Rails app

```
foreman start -f Procfile.dev
```

## Tests

### Docker-based tests on the CI server

Add the following build settings to run the tests in the Docker environment via Docker Compose (configuration in `docker-compose.test.yml`):

* Configure the environment variable `BRANCH_TAG` to tag Docker images per branch:

```
export BRANCH_TAG=$SEMAPHORE_BRANCH_ID
```

Each branch needs to have its own Docker image to avoid build settings disparities and leverage Docker image caching.

> BRANCH_TAG must not contain special characters (`/`) to be valid. So using $BRANCH_NAME will not work e.g. chore/setup-docker.
An alternative is to use a unique identifier such as PR_ID or BRANCH_ID on the CI server.

* Pull the latest version the Docker image for the branch:

```
docker pull $DOCKER_IMAGE:$BRANCH_TAG || true
```

On each build, the CI environment does not contain yet a cached version of the image. Therefore, it is required to pull
it first to leverage the `cache_from` settings of Docker Compose which avoids rebuilding the whole Docker image on subsequent test builds.

* Build the Docker image:

```
docker-compose -f docker-compose.test.yml build
```

Upon the first build, the whole Docker image is built from the ground up and tagged using `$BRANCH_TAG`.

* Push the latest version of the Docker image for this branch:

```
docker push $DOCKER_IMAGE:$BRANCH_TAG
```

* Setup the test database:

```
docker-compose -f docker-compose.test.yml run test rake db:test:prepare
```

### Test

* Run all tests:

```
docker-compose -f docker-compose.test.yml run test
```

* Run a specific test:

```
docker-compose -f docker-compose.test.yml run test [rspec-params]
```

### Automated Code Review Setup

* Make sure that the config file `pronto.yml` for pronto has been added as a configuration file.

* In the CI build script, add the following command:

```
if ([ $BRANCH_NAME != 'master' ] && [ $BRANCH_NAME != 'development' ]); then (echo "Running pronto"; bundle exec pronto run -f bitbucket_pr -c origin/development); else (echo "Escaping pronto"); fi
```

## API
### Login using email & password
`POST /oauth/token`

Body:
```
{
  "grant_type": "password",
  "email": "hoang@gmail.com",
  "password": "123456"
}
```
Response:
```
{
  "access_token": "5575f0c84e814013398fc0f55f755b4d3768a7041486ef92b1cb6bc5bab30afe",
  "token_type": "Bearer",
  "expires_in": 7200,
  "refresh_token": "161c6e739ff776479501ac63d10cf8819c44de062eaa616fe6d842c7c37dded7",
  "created_at": 1538649200
}
```

### Refresh token
`POST /oauth/token`

Body:
```
{
  "grant_type": "refresh_token",
  "refresh_token": "074e26ddb55228422ef306dd304586d5f739cfae643079ece337adeb26346942"
}
```
Response:
```
{
  "access_token": "f6cfd4e13f39e991264f8290ed42317b8592365bb6f6c5da52c7237bdf4e1347",
  "token_type": "Bearer",
  "expires_in": 7200,
  "refresh_token": "36d8aad4e8a3321dfa5bc9d7254ca7cbb4a9332612ac8463e5a8fc252891300c",
  "created_at": 1538649420
}
```

### Revoke token
`POST /oauth/revoke`

Headers:
```
"Authorization": "Bearer f6cfd4e13f39e991264f8290ed42317b8592365bb6f6c5da52c7237bdf4e1347"
```

### Other API
Using below header to request data

Headers:
```
"Authorization": "Bearer {{access_token}}"
```

#### Get search results

`GET /api/v1/search_results?page={{page}}`

Response:
```
[
    {
        "id": 1,
        "keyword": "du lich hoi an",
        "total_results": 20400000,
        "total_links": 11,
        "user": "hoang@gmail.com"
    },
    {
        "id": 6,
        "keyword": "du lich quang nam",
        "total_results": 27900000,
        "total_links": 10,
        "user": "hoang@gmail.com"
    }
]
```

#### Get detail search result by ID

`GET /api/v1/search_results/{{id}}`

Response:
```
{
    "id": 1,
    "keyword": "du lich hoi an",
    "total_results": 20400000,
    "total_links": 3,
    "user": "hoang.mirs@gmail.com",
    "results": [
        {
            "link_type": "non_ad",
            "title": "Du lịch Hội An: Cẩm nang từ A đến Z - iVIVU.com",
            "url": "https://www.ivivu.com/blog/2014/10/du-lich-hoi-an-cam-nang-tu-a-den-z/",
            "keyword": "du lich hoi an"
        },
        {
            "link_type": "non_ad",
            "title": "Du Lịch Hội An – Kinh nghiệm du lịch và điểm đến nổi tiếng ở Hội An",
            "url": "https://www.ivivu.com/blog/category/viet-nam/hoi-an/",
            "keyword": "du lich hoi an"
        },
        {
            "link_type": "bottom_ad",
            "title": "Xe Đà Nẵng Hội An giá rẻ 199k | Đà Nẵng to Hội An : 11USD\u200e",
            "url": "www.hoiansuntravel.com/",
            "keyword": "du lich hoi an"
        }
    ]
}
```

#### New search result

`POST /api/v1/search`

Body:
```
{
    "keywords_file": {{file_data}}
}
or
{
    "keyword": {{keyword}}
}
```

Response:
```
{
    "message": "The file is being processed"
}
or
{
    "message": {{new_search_result_id}}
}
or
{
    "message": "Invalid request"
}
```

#### Get Link queries result

`GET /api/v1/link_queries?type={{query_type}}&keyword={{keyword}}`

Params:
```
query_type: "adword_url_contains" or "specific_url"
keyword: {{keyword}}
```

Response:
```
[
    {
        "link_type": "top_ad",
        "title": "[Chuyên Đặt Hàng Trung Quốc] | Phí DV chỉ 12k giá rẻ nhất VN",
        "url": "www.shopquangchau.vn/",
        "keyword": "mua hang trung quoc"
    },
    {
        "link_type": "top_ad",
        "title": "【Mua hàng T Quốc 】 | Có bảng giá 2018, Xem ngay",
        "url": "www.shiphangquangchau24h.com/",
        "keyword": "mua hang trung quoc"
    }
]
```

## Servers:
Main web server:
- https://googles-scraper.herokuapp.com/

3 worker servers:
- https://glacial-brushlands-31474.herokuapp.com/
- https://morning-garden-58758.herokuapp.com/
- https://murmuring-beach-72301.herokuapp.com/

Config 4 servers use same Postgres DB and Redis
Can track worker servers from server_ip column of search_results table.
