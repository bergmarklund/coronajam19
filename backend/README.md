## API

This documents describes all API endpoints that the backend provides. The API is available at [coronajam19.app.fernandobevilacqua.com/api/](http://coronajam19.app.fernandobevilacqua.com/api/). The table below shows a summary of all available API endpoints.


| Name                 | Method | Endpoint | URL |
|----------------------|--------|----------|-----|
| [join](#join)        | `POST` | `/join`  | [coronajam19.app.fernandobevilacqua.com/api/join](http://coronajam19.app.fernandobevilacqua.com/api/join) |
| [move](#move)        | `GET`  | `/move/{direction}/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/move/up/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/move/up/1/abc) |
| [message](#message)  | `GET`  | `/message/{content}/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/message/hi/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/api/message/hi/1/abc) |

### /join
______

Allow a player to join the game.

| Method | Endpoint | URL |
|--------|----------|-----|
| `GET` | `/join` | [coronajam19.app.fernandobevilacqua.com/api/join](http://coronajam19.app.fernandobevilacqua.com/api/join) |
| `GET` | `/join/{name}/{country}` | [coronajam19.app.fernandobevilacqua.com/api/join](http://coronajam19.app.fernandobevilacqua.com/api/join/Testg/BR) |

You can either acess `/join` directly (no params) or you must provide the following fields in the request:

| Name     | Type   | Description        |
|----------|--------|--------------------|
| name     | string | Name of the player |
| country  | string | Player's country, e.g. `"BR"`. |

Response example:

```json
{
    "user": {
        "name": "PlayervKaTyoC2",
        "country": "?",
        "token": "2UJKAklIrKRFycUnyeRoGt3q35JwW7VP",
        "updated_at": "2020-07-11T18:20:54.000000Z",
        "created_at": "2020-07-11T18:20:54.000000Z",
        "id": 3,
        "ship": {
            "user_id": 3,
            "row": 20,
            "col": -11,
            "updated_at": "2020-07-11T18:20:54.000000Z",
            "created_at": "2020-07-11T18:20:54.000000Z",
            "id": 2
        }
    }
}
```

The values `user.token` and `user.id` in the response must be saved in the client and sent along with all further requests.

### /move
______

Move the player ship in space.

| Method | Endpoint | URL |
|--------|----------|-----|
| `GET`  | `/move/{direction}/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/move/up/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/move/up/1/abc) |

Required fields in the request:

| Name      | Type   | Description        |
|-----------|--------|--------------------|
| direction | string | One of the following: `"up"`, `"down"`, `"left"`, `"right"`. |
| user_id   | int    | User's id, as informed by `/join`.|
| token     | string | User's token, as informed by `/join`. |

Response example:

```json
{
    "ship": {
        "id": 1,
        "user_id": "1",
        "row": 5,
        "col": "-4",
        "created_at": "2020-07-11T13:19:59.000000Z",
        "updated_at": "2020-07-11T17:35:08.000000Z"
    }
}
```


### /message
______

Broadcast a message to nearby quadrants

| Method | Endpoint | URL |
|--------|----------|-----|
| `GET`  | `/message/{content}/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/message/hej/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/message/hej/1/abc) |

Required fields in the request:

| Name      | Type   | Description        |
|-----------|--------|--------------------|
| content   | string | Message to be broadcasted (max 8 chars). |
| user_id   | int    | User's id, as informed by `/join`.|
| token     | string | User's token, as informed by `/join`. |

Response example:

```json
{
    "message": {
        "ship_id": 1,
        "content": "hey",
        "row": 10,
        "col": -4,
        "updated_at": "2020-07-11T17:58:16.000000Z",
        "created_at": "2020-07-11T17:58:16.000000Z",
        "id": 5
    }
}
```

### /sync
______

Broadcast a message to nearby quadrants

| Method | Endpoint | URL |
|--------|----------|-----|
| `GET`  | `/sync/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/sync/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/sync/1/abc) |

Required fields in the request:

| Name      | Type   | Description        |
|-----------|--------|--------------------|
| user_id   | int    | User's id, as informed by `/join`.|
| token     | string | User's token, as informed by `/join`. |

Response example (with no messages in the inbox):

```json
{
    "user": {
        "id": 1,
        "name": "foo",
        "country": "BR",
        "token": "LB1h0Pq5sgSPUIzsr0qvx8UOjkDfR61g",
        "created_at": "2020-07-11T13:19:59.000000Z",
        "updated_at": "2020-07-11T13:19:59.000000Z",
        "ship": {
            "id": 1,
            "user_id": 1,
            "row": 10,
            "col": -4,
            "created_at": "2020-07-11T13:19:59.000000Z",
            "updated_at": "2020-07-11T17:55:34.000000Z"
        }
    },
    "messages": []
}
```

Response example (with some messages):

```json
{
    "user": {
        "id": 1,
        "name": "foo",
        "country": "BR",
        "token": "LB1h0Pq5sgSPUIzsr0qvx8UOjkDfR61g",
        "created_at": "2020-07-11T13:19:59.000000Z",
        "updated_at": "2020-07-11T13:19:59.000000Z",
        "ship": {
            "id": 1,
            "user_id": 1,
            "row": 10,
            "col": -4,
            "created_at": "2020-07-11T13:19:59.000000Z",
            "updated_at": "2020-07-11T17:55:34.000000Z"
        }
    },
    "messages": [
        {
            "id": 9,
            "ship_id": 2,
            "content": "ha",
            "row": 10,
            "col": -4,
            "created_at": "2020-07-11T19:05:31.000000Z",
            "updated_at": "2020-07-11T19:05:31.000000Z",
            "ship": {
                "id": 2,
                "user_id": 2,
                "row": 10,
                "col": -4,
                "created_at": "2020-07-11T13:19:59.000000Z",
                "updated_at": "2020-07-11T17:55:34.000000Z"
            }
        },
        {
            "id": 10,
            "ship_id": 3,
            "content": "hej",
            "row": 15,
            "col": 0,
            "created_at": "2020-07-11T19:05:53.000000Z",
            "updated_at": "2020-07-11T19:05:53.000000Z",
            "ship": {
                "id": 3,
                "user_id": 3,
                "row": 15,
                "col": 0,
                "created_at": "2020-07-11T13:19:59.000000Z",
                "updated_at": "2020-07-11T17:55:34.000000Z"
            }
        }
    ]
}
```
