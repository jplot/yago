# Usage

```
curl --location --request POST 'https://yogo-jplot.herokuapp.com/professional_liability/quotas' \
--header 'Content-Type: application/json' \
--data-raw '{
    "person": {
        "first_name": "John",
        "last_name": "Doe",
        "phone": "+33123456789",
        "email": "john.doe@yago.be",
        "managers_attributes": [
            {
                "role": "chief_executive_officier",
                "company_attributes": {
                    "name": "Yago",
                    "kind": "014",
                    "number": "0639926420",
                    "natural_person": false,
                    "annual_revenue": 1000000,
                    "activity_begins_at": "2015-10-05",
                    "activities_attributes": [
                        {
                            "code": "65121"
                        },
                        {
                            "code": "58290"
                        }
                    ],
                    "headquarters_attributes": {
                        "name": "Séraphin",
                        "number": "2246201680",
                        "activity_begins_at": "2015-10-05",
                        "activities_attributes": [
                            {
                                "code": "65121"
                            },
                            {
                                "code": "58290"
                            }
                        ],
                        "address_attributes": {
                            "address": "Rue des Francs 79",
                            "zipcode": "1040",
                            "city": "etterbeek",
                            "country": "be"
                        }
                    }
                }
            }
        ]
    }
}'
```