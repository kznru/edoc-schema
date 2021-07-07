---
layout: page
title: "Согласование проекта размещения средств наружной информации: Добавление в реестр записи о согласовании вывески: без аренды, отдельностоящая конструкция"
permalink: /uslugi/signboard_no_lease_separate
---

## Схема
```json
{% include examples/document/ru/48_signboard_no_lease_separate.json %}
```

## Пример данных
```json
{
  "agent": {
    "fio": {
      "name": "Ольга",
      "surname": "Петрова",
      "patronymic": "Вячеславовна"
    },
    "mobile": "+70123456789",
    "passport_number": "596635"
  },
  "text": "Марципан",
  "image_project": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/046B0ABA-E0C3-4FDB-8808-29DAEDF3123E/%D0%BF%D0%BF.jpg"
    ]
  },
  "image_original": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/046B0ABA-E0C3-4FDB-8808-29DAEDF3123E/%D0%B8%D1%81%D1%85.jpg"
    ]
  },
  "image_topographic": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/046B0ABA-E0C3-4FDB-8808-29DAEDF3123E/%D1%82%D0%BE%D0%BF%D0%BE.jpg"
    ]
  },
  "image_constructions": [
    {
      "image": {
        "file": {
          "object": "https://s3.uslugi.kzn.ru/uploads/046B0ABA-E0C3-4FDB-8808-29DAEDF3123E/%D0%BE%D0%BF%D0%B8%D1%81%D0%B0%D0%BD%D0%B8%D0%B5.jpg"
        }
      },
      "contruction_type": "настенная конструкция в виде световых объёмных букв"
    }
  ],
  "organization": {
    "inn": "1660214674",
    "kpp": "166001001",
    "name": "ООО \"СКИ \"МАРЦИПАН\"",
    "ogrn": "1141690062546",
    "value": "1660214674, ООО \"СКИ \"МАРЦИПАН\""
  },
  "cadastre_number": "16:50:100501:3387",
  "letter_of_attorney": {
    "content": {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/046B0ABA-E0C3-4FDB-8808-29DAEDF3123E/%D0%B4%D0%BE%D0%B2%D0%B5%D1%80%D0%B5%D0%BD%D0%BD%D0%BE%D1%81%D1%82%D1%8C.jpg"
      ]
    }
  },
  "address_with_map": {
    "address": {
      "value": "г Казань, пр-кт Ибрагимова, д 61А",
      "fias_id": "2579b969-cec8-4526-95e6-149a6e3156f9",
      "fias_level": "8",
      "city_district": "Московский р-н",
      "geo_coordinates": {
        "lat": 55.8251338,
        "lon": 49.0957887
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
              49.09604310969372,
              55.82384350625326
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
        "https://s3.uslugi.kzn.ru/uploads/046B0ABA-E0C3-4FDB-8808-29DAEDF3123E/%D1%81%D0%B2%D0%B8%D0%B4.jpg"
      ],
      "description": "свидетельство  регистрации права"
    },
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/046B0ABA-E0C3-4FDB-8808-29DAEDF3123E/%D0%90%D0%BD%D0%BD%D1%83%D0%BB%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5.jpg"
      ],
      "description": "Аннулирование"
    },
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/046B0ABA-E0C3-4FDB-8808-29DAEDF3123E/%D0%A2%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_6.jpg",
        "https://s3.uslugi.kzn.ru/uploads/046B0ABA-E0C3-4FDB-8808-29DAEDF3123E/%D0%A2%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_7.jpg",
        "https://s3.uslugi.kzn.ru/uploads/046B0ABA-E0C3-4FDB-8808-29DAEDF3123E/%D0%A2%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_1.jpg"
      ],
      "description": "техпаспорт "
    }
  ]
}
```
