## API

This document describes all API endpoints that the backend provides. The API is available at [coronajam19.app.fernandobevilacqua.com/api/](http://coronajam19.app.fernandobevilacqua.com/api/test). The table below shows a summary of all available API endpoints.


| Name                 | Method | Endpoint | URL |
|----------------------|--------|----------|-----|
| [join](#join)        | `GET` | `/join`  | [coronajam19.app.fernandobevilacqua.com/api/join](http://coronajam19.app.fernandobevilacqua.com/api/join) |
| [move](#move)        | `GET`  | `/move/{direction}/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/move/up/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/move/up/1/abc) |
| [warp](#warp)        | `GET`  | `/warp/{row}/{col}/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/warp/10/15/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/warp/10/15/1/abc) |
| [message](#message)  | `GET`  | `/message/{content}/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/message/hi/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/api/message/hi/1/abc) |
| [dispose](#dispose)  | `GET`  | `/dispose/{item_id}/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/dispose/1/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/api/dispose/1/1/abc) |
| [collect](#dispose)  | `GET`  | `/collect/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/collect/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/api/collect/1/abc) |
| [sync](#sync)        | `GET`  | `/sync/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/sync/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/sync/1/abc) |

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
        "col": -4,
        "created_at": "2020-07-11T13:19:59.000000Z",
        "updated_at": "2020-07-11T17:35:08.000000Z"
    }
}
```

### /warp
______

Move the player ship to coordinate in space.

| Method | Endpoint | URL |
|--------|----------|-----|
| `GET`  | `/warp/{row}/{col}/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/warp/10/15/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/warp/10/15/1/abc) |

Required fields in the request:

| Name      | Type   | Description        |
|-----------|--------|--------------------|
| row       | int    | Row where you want to go in space. |
| col       | int    | Column where you want to go in space. |
| user_id   | int    | User's id, as informed by `/join`.|
| token     | string | User's token, as informed by `/join`. |

Response example:

```json
{
    "ship": {
        "id": 1,
        "user_id": "1",
        "row": 10,
        "col": 15,
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

### /dispose
______

Dispose an item from the ship to outer space. If other ships are in the same quadrant of the player's ship, the item will be randomly assigned to one of them. If no ships are in the same quadrant, the item will be disposed into outer space (no owner). It will remain floating in that quadrant until some ship calls collect.

| Method | Endpoint | URL |
|--------|----------|-----|
| `GET`  | `/dispose/{item_id}/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/dispose/1/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/dispose/1/1/abc) |

Required fields in the request:

| Name      | Type   | Description        |
|-----------|--------|--------------------|
| item_id   | int    | Id of the item to be disposded. |
| user_id   | int    | User's id, as informed by `/join`.|
| token     | string | User's token, as informed by `/join`. |

Response example (disposed item was collected by neighbor ship):

```json
{
    "action": "dispose",
    "was_collected": true,
    "item": {
        "id": 1,
        "ship_id": 13,
        "seed": "26",
        "description": "collectible_plant_small",
        "row": 15,
        "col": 15,
        "created_at": "2020-07-12T11:10:44.000000Z",
        "updated_at": "2020-07-12T11:46:02.000000Z",
        "ship": {
            "id": 13,
            "user_id": 14,
            "row": 15,
            "col": 15,
            "created_at": "2020-07-11T21:21:08.000000Z",
            "updated_at": "2020-07-11T21:21:08.000000Z"
        }
    }
}
```

Response example (disposed item was not collected by neighbor ship, it's now floating in space):

```json
{
    "action": "dispose",
    "was_collected": false,
    "item": {
        "id": 1,
        "ship_id": null,
        "seed": "26",
        "description": "abc",
        "row": 15,
        "col": 15,
        "created_at": "2020-07-12T11:10:44.000000Z",
        "updated_at": "2020-07-12T11:49:02.000000Z"
    }
}
```

### /collect
______

Collect an item from the quadrant where the ship is. This method only collect items that are floating in that quadrant (no owner). If no item is floating in that quadrant, there is a chance that a new, random item will show up and be collected.


| Method | Endpoint | URL |
|--------|----------|-----|
| `GET`  | `/collect/{user_id}/{token}`  | [coronajam19.app.fernandobevilacqua.com/api/collect/1/abc](http://coronajam19.app.fernandobevilacqua.com/api/collect/1/abc) |

Required fields in the request:

| Name      | Type   | Description        |
|-----------|--------|--------------------|
| user_id   | int    | User's id, as informed by `/join`.|
| token     | string | User's token, as informed by `/join`. |

Response example (no item has been collected):

```json
{
    "action":"collect",
    "item":null
}
```

Response example (one item has been collected):

```json
{
    "action": "collect",
    "item": {
        "id": 19,
        "ship_id": 1,
        "seed": "58",
        "description": "collectible_hot_carrot",
        "row": 15,
        "col": 15,
        "created_at": "2020-07-12T11:35:06.000000Z",
        "updated_at": "2020-07-12T11:54:17.000000Z",
        "ship": {
            "id": 1,
            "user_id": 1,
            "row": 15,
            "col": 15,
            "created_at": "2020-07-11T13:19:59.000000Z",
            "updated_at": "2020-07-11T20:04:23.000000Z"
        }
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

Response example (with no messages in the inbox, no items):

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
    "messages": [],
    "items": []
}
```

Response example (with some messages and items):

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
    ],
    "items": [
        {
            "id": 17,
            "ship_id": 1,
            "seed": "59",
            "description": "collectible_alien",
            "row": 15,
            "col": 15,
            "created_at": "2020-07-12T11:34:27.000000Z",
            "updated_at": "2020-07-12T11:35:11.000000Z"
        },
        {
            "id": 18,
            "ship_id": 1,
            "seed": "856",
            "description": "collectible_plant_small",
            "row": 15,
            "col": 15,
            "created_at": "2020-07-12T11:34:49.000000Z",
            "updated_at": "2020-07-12T11:34:49.000000Z"
        }
    ]

}
```
