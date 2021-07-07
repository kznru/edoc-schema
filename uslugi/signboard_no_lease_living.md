---
layout: page
title: "Согласование проекта размещения средств наружной информации: Добавление в реестр записи о согласовании вывески: без аренды, жилой дом"
permalink: /uslugi/signboard_no_lease_living
---

## Схема
```json
{% include examples/document/ru/44_signboard_no_lease_living.json %}
```

## Пример данных
```json
{
  "agent": {
    "fio": {
      "name": "Ольга",
      "surname": "Иванова",
      "patronymic": "Вячеславовна"
    },
    "mobile": "+70123456789",
    "passport_number": "532135"
  },
  "text": "Аптека Сакура",
  "image_project": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/AE3C4A90-4BB5-4AD3-836B-E6135D9BD804/%D0%BF%D0%BF.jpg"
    ]
  },
  "image_original": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/AE3C4A90-4BB5-4AD3-836B-E6135D9BD804/%D0%B8%D1%81%D1%85.jpg"
    ]
  },
  "image_topographic": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/AE3C4A90-4BB5-4AD3-836B-E6135D9BD804/%D1%82%D0%BE%D0%BF%D0%BE.jpg"
    ]
  },
  "image_constructions": [
    {
      "image": {
        "file": {
          "object": "https://s3.uslugi.kzn.ru/uploads/AE3C4A90-4BB5-4AD3-836B-E6135D9BD804/%D0%BE%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5.jpg"
        }
      },
      "contruction_type": "настенная конструкция в виде световых объёмных букв"
    }
  ],
  "organization": {
    "inn": "1661006162",
    "kpp": "165801001",
    "name": "ООО \"САКУРА-ФАРМАЦИЯ\"",
    "ogrn": "1021603881463",
    "value": "1661006162, ООО \"САКУРА-ФАРМАЦИЯ\""
  },
  "letter_of_attorney": {
    "content": {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/AE3C4A90-4BB5-4AD3-836B-E6135D9BD804/%D0%94%D0%BE%D0%B2%D0%B5%D1%80%D0%B5%D0%BD%D0%BD%D0%BE%D1%81%D1%82%D1%8C.jpg"
      ]
    }
  },
  "passport_bti": {
    "bti": "БТИ Вахитовского района",
    "content": {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/AE3C4A90-4BB5-4AD3-836B-E6135D9BD804/%D1%82%D0%BF_1.jpg",
        "https://s3.uslugi.kzn.ru/uploads/AE3C4A90-4BB5-4AD3-836B-E6135D9BD804/%D1%82%D0%BF_3.jpg",
        "https://s3.uslugi.kzn.ru/uploads/AE3C4A90-4BB5-4AD3-836B-E6135D9BD804/%D1%82%D0%BF_2.jpg"
      ]
    },
    "issue_date": "2007-09-17",
    "inventory_number": "91"
  },
  "cadastre_number": "16:50:010606:0000:0002:0028",
  "address_with_map": {
    "address": {
      "value": "г Казань, ул Большая Красная, д 54",
      "fias_id": "561cadef-7903-49ac-8f88-52f6daf77a1a",
      "fias_level": "8",
      "city_district": "Вахитовский р-н",
      "geo_coordinates": {
        "lat": 55.7965071,
        "lon": 49.1323241
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
              49.13302540759106,
              55.7963123553815
            ]
          },
          "properties": {

          }
        }
      ]
    }
  },
  "attachments": [
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/AE3C4A90-4BB5-4AD3-836B-E6135D9BD804/%D1%81%D0%B2%D0%B8%D0%B4%D0%B5%D1%82%D0%B5%D0%BB%D1%8C%D1%81%D1%82%D0%B2%D0%BE.jpg"
      ],
      "description": "свидетельство  регистрации права"
    },
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/AE3C4A90-4BB5-4AD3-836B-E6135D9BD804/%D1%8D%D0%BF.jpg"
      ],
      "description": "Эскизный проект"
    }
  ]
}
```
