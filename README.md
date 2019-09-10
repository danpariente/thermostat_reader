# Thermostat Reader

[![CircleCI](https://img.shields.io/circleci/project/github/naughtystyle/thermostat_reader.svg)](https://circleci.com/gh/naughtystyle/thermostat_reader/tree/master)
[![Maintainability](https://api.codeclimate.com/v1/badges/a99a88d28ad37a79dbf6/maintainability)](https://codeclimate.com/github/codeclimate/codeclimate/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a99a88d28ad37a79dbf6/test_coverage)](https://codeclimate.com/github/codeclimate/codeclimate/test_coverage)

This is the API documentation for the IoT Thermostats.

API version is scoped via the URL. For example:

```
    http://thermostatreader.io/api/v1/thermostats/:thermostat_id/stats
```

`POST` endpoints accept JSON data in the body of the request. All requests require a `"thermostat-auth-token": THERMOSTAT_HOUSEHOLD_TOKEN` header. Responses follow the JSON:API specification.


`POST /api/v1/thermostats/:thermostat_id/readings`
--------------

Example request data:
```javascript
{
  "temperature" : 100.0
  "humidity" : 15.0
  "battery_charge" : 20.0
}
```
* Required: `temperature`, `humidity`, `battery_charge`
* Required headers: `"thermostat-auth-token": THERMOSTAT_HOUSEHOLD_TOKEN`

Example response:
```javascript
{
  "data": {
    "id": "58c11d69-4aee-427d-987d-a797e44530fa",
    "type": "reading",
    "attributes": {
      "tracking_number": 42,
      "temperature": 11.0,
      "humidity": 22.0,
      "battery_charge": 33.0
    },
    "relationships": {
      "thermostat": {
        "data": {
          "id": "d05f3009-7e93-4ab9-b671-b6377393c2df",
          "type": "thermostat"
        }
      }
    }
  }
}
```

Example `422` response:
```javascript
{
  "errors": {
    "title": "UnprocessableEntity",
    "detail": "Temperature can't be blank, Humidity can't be blank, Battery charge can't be blank"
  }
}
```

`GET /api/v1/thermostats/:thermostat_id/readings/:tracking_number`
----------------------

Example response:
```javascript
{
  "data": {
    "id": "eef57a70-8b17-45fd-9abf-609c13e26ec8",
    "type": "reading",
    "attributes": {
      "tracking_number": 23,
      "temperature": 25.0,
      "humidity": 25.0,
      "battery_charge": 25.0
    },
    "relationships": {
      "thermostat": {
        "data": {
          "id": "d05f3009-7e93-4ab9-b671-b6377393c2df",
          "type": "thermostat"
        }
      }
    }
  }
}
```

Example `404` response:
```javascript
{
  "errors": {
    "title": "RecordNotFound",
    "detail": "Record not found."
  }
}
```

* Required headers: `"thermostat-auth-token": THERMOSTAT_HOUSEHOLD_TOKEN`


`GET  /api/v1/thermostats/:thermostat_id/stats`
------------------------

Example response:
```javascript
{
  "data": {
    "id": "d05f3009-7e93-4ab9-b671-b6377393c2df",
    "type": "stats",
    "attributes": {
      "temperature": {
        "average": 28.6,
        "maximum": 111.0,
        "minimum": 10.0
      },
      "humidity": {
        "average": 36.1,
        "maximum": 42.0,
        "minimum": 0.0
      },
      "battery_charge": {
        "average": 38.7,
        "maximum": 100.0,
        "minimum": 0.0
      }
    },
    "relationships": {
      "thermostat": {
        "data": {
          "id": "d05f3009-7e93-4ab9-b671-b6377393c2df",
          "type": "thermostat"
        }
      }
    }
  }
}
```

* Required headers: `"thermostat-auth-token": THERMOSTAT_HOUSEHOLD_TOKEN`
