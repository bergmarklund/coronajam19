## API

This documents describes all API endpoints that the backend provides. The API is available at [http://coronajam19.app.fernandobevilacqua.com/api/](coronajam19.app.fernandobevilacqua.com/api/). The table below shows a summary of all available API endpoints.


| Name                 | Method | Endpoint | URL |
|----------------------|--------|----------|-----|
| [join](#join)        | `POST` | `/join`  | [http://coronajam19.app.fernandobevilacqua.com/api/join](coronajam19.app.fernandobevilacqua.com/api/join) |
| [move](#move)        | `GET`  | `/move/{direction}/{user_id}/{token}`  | [http://coronajam19.app.fernandobevilacqua.com/api/move/up/1/abc](coronajam19.app.fernandobevilacqua.com/api/move/up/1/abc) |
| [message](#message)  | `GET`  | `/message/{content}/{user_id}/{token}`  | [http://coronajam19.app.fernandobevilacqua.com/api/message/hi/1/abc](coronajam19.app.fernandobevilacqua.com/api/api/message/hi/1/abc) |

### /join
______

Allow a player to join the game.

| Method | Endpoint | URL |
|--------|----------|-----|
| `POST` | `/join`  | [http://coronajam19.app.fernandobevilacqua.com/api/join](coronajam19.app.fernandobevilacqua.com/api/join) |

Required fields in the request:

| Name     | Type   | Description        |
|----------|--------|--------------------|
| name     | string | Name of the player |
| country  | string | Player's country, e.g. `"BR"`. |

Response example:

```json
{
    "user": {
        "name": "foo",
        "country": "BR",
        "token": "LB1h0Pq5sgSPUIzsr0qvx8UOjkDfR61g",
        "updated_at": "2020-07-11T13:19:59.000000Z",
        "created_at": "2020-07-11T13:19:59.000000Z",
        "id": 1
    },
    "ship": {
        "user_id": 1,
        "row": 0,
        "col": 0,
        "updated_at": "2020-07-11T13:19:59.000000Z",
        "created_at": "2020-07-11T13:19:59.000000Z",
        "id": 1
    }
}
```

The value available in `user.token` in the response must be saved in the client and sent along with all further requests.

### /move
______

Move the player ship in space.

| Method | Endpoint | URL |
|--------|----------|-----|
| `GET`  | `/move/{direction}/{user_id}/{token}`  | [http://coronajam19.app.fernandobevilacqua.com/api/move/up/1/abc](coronajam19.app.fernandobevilacqua.com/api/move/up/1/abc) |

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
| `GET`  | `/message/{content}/{user_id}/{token}`  | [http://coronajam19.app.fernandobevilacqua.com/api/message/hej/1/abc](coronajam19.app.fernandobevilacqua.com/api/message/hej/1/abc) |

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
| `GET`  | `/sync/{user_id}/{token}`  | [http://coronajam19.app.fernandobevilacqua.com/api/sync/1/abc](coronajam19.app.fernandobevilacqua.com/api/sync/1/abc) |

Required fields in the request:

| Name      | Type   | Description        |
|-----------|--------|--------------------|
| user_id   | int    | User's id, as informed by `/join`.|
| token     | string | User's token, as informed by `/join`. |

Response example:

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
    }
}
```
