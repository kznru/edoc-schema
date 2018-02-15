---
layout: page
title: "Согласование проекта размещения средств наружной информации: Добавление в реестр записи о согласовании вывески: без аренды, административное здание"
permalink: /uslugi/signboard_no_lease_no_living
---

## Схема
```json
{% include schemas/document/ru/uslugi/43_signboard_no_lease_no_living.json %}
```

## Пример данных
```json
{
  "agent": {
    "fio": {
      "name": "Наталья",
      "surname": "Мазанова",
      "patronymic": "Георгиевна"
    },
    "email": "some@email.ru",
    "mobile": "+70123456789",
    "passport_number": "158078"
  },
  "organization": {
    "inn": "1656020411",
    "kpp": "166001001",
    "name": "ООО \"ЭКОТЕХСЕРВИС\"",
    "ogrn": "1021603279180",
    "value": "1656020411, ООО \"ЭКОТЕХСЕРВИС\""
  },
  "planeta_number": "4245",
  "cadastre_number": "16:50:140212:1831",
  "address_with_map": {
    "address": {
      "value": "г Казань, пр-кт Победы, д 216",
      "fias_id": "79964d0b-fcd8-461c-aa10-523d66b254f1",
      "fias_level": "8",
      "city_district": "Советский р-н",
      "geo_coordinates": {
        "lat": 55.8052164,
        "lon": 49.2072702
      }
    },
    "geoJSON": {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "geometry": {
            "type": "Point",
            "coordinates": [
              49.20705974082012,
              55.80517702140137
            ]
          },
          "properties": {

          }
        },
        {
          "type": "Feature",
          "geometry": {
            "type": "Point",
            "coordinates": [
              49.20717239359875,
              55.80508356096083
            ]
          },
          "properties": {

          }
        },
        {
          "type": "Feature",
          "geometry": {
            "type": "Point",
            "coordinates": [
              49.20731186846752,
              55.80498105570354
            ]
          },
          "properties": {

          }
        }
      ]
    }
  },
  "text": "Инфинити",
  "image_project": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/9C12D1AA-5EE1-4C9C-B21D-19BBE04B407D/%D0%9F%D1%80%D0%BE%D0%B5%D0%BA%D1%82%D0%BD%D0%BE%D0%B5_%D0%BF%D1%80%D0%B5%D0%B4%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5.jpg"
    ]
  },
  "image_original": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/9C12D1AA-5EE1-4C9C-B21D-19BBE04B407D/%D0%98%D1%81%D1%85%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F_%D1%81%D0%B8%D1%82%D1%83%D0%B0%D1%86%D0%B8%D1%8F.jpg"
    ]
  },
  "image_topographic": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/9C12D1AA-5EE1-4C9C-B21D-19BBE04B407D/%D0%A2%D0%BE%D0%BF%D0%BE%D1%81%D1%8C%D0%B5%D0%BC%D0%BA%D0%B0.jpg"
    ]
  },
  "image_constructions": [
    {
      "image": {
        "file": {
          "object": "https://s3.uslugi.kzn.ru/uploads/9C12D1AA-5EE1-4C9C-B21D-19BBE04B407D/%D0%9E%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5.jpg"
        }
      },
      "contruction_type": "настенная конструкция в виде световых объёмных букв"
    }
  ],
  "attachments": [
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/9C12D1AA-5EE1-4C9C-B21D-19BBE04B407D/%D1%81%D0%B2%D0%B8%D0%B4_%D0%B7%D0%B5%D0%BC_%D1%83%D1%87_%D1%8D%D1%82%D1%81.jpg"
      ],
      "description": "свидетельство  регистрации права"
    },
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/9C12D1AA-5EE1-4C9C-B21D-19BBE04B407D/%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82_%D0%9F%D0%97_2.jpg",
        "https://s3.uslugi.kzn.ru/uploads/9C12D1AA-5EE1-4C9C-B21D-19BBE04B407D/%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82_%D0%9F%D0%97_1.jpg"
      ],
      "description": "пз"
    },
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/9C12D1AA-5EE1-4C9C-B21D-19BBE04B407D/%D0%A2%D0%B5%D1%85_%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82.pdf"
      ],
      "description": "техпаспорт "
    },
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/9C12D1AA-5EE1-4C9C-B21D-19BBE04B407D/%D0%9F%D0%B8%D1%81%D1%8C%D0%BC%D0%BE_%D0%BE%D1%82_%D1%81%D0%BE%D0%B1%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D0%B8%D0%BA%D0%B0.jpg"
      ],
      "description": "Письмо от заявителя"
    }
  ]
}
```
