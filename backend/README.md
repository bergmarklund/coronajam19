## API

This documents describes all API endpoints that the backend provides. The API is available at [http://coronajam19.app.fernandobevilacqua.com/api/](coronajam19.app.fernandobevilacqua.com/api/).


### /join

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
