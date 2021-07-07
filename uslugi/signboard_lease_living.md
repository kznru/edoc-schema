---
layout: page
title: "Согласование проекта размещения средств наружной информации: Добавление в реестр записи о согласовании вывески: аренда, жилой дом"
permalink: /uslugi/signboard_lease_living
---

## Схема
```json
{% include examples/document/ru/46_signboard_lease_living.json %}
```

## Пример данных
```json
{
  "agent": {
    "fio": {
      "name": "Оксана",
      "surname": "Петрова",
      "patronymic": "Сергеевна"
    },
    "mobile": "+70123456789",
    "passport_number": "873214"
  },
  "text": "ДАРЬЯ КРУТЫХЪ",
  "image_project": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%BF%D1%80%D0%B8%D0%B2%D1%8F%D0%B7%D0%BA%D0%B0.jpg"
    ]
  },
  "image_original": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%B8%D1%81%D1%85%D0%BE%D0%B4%D0%BD%D0%BE%D0%B5_%D1%84%D0%BE%D1%82%D0%BE.jpg"
    ]
  },
  "image_topographic": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%BE%D0%BF%D0%BE%D1%81%D1%8A%D0%B5%D0%BC%D0%BA%D0%B0.jpg"
    ]
  },
  "image_constructions": [
    {
      "image": {
        "file": {
          "object": "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%BA%D0%BE%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F.jpg"
        }
      },
      "contruction_type": "настенная конструкция в виде световых объёмных букв"
    }
  ],
  "organization": {
    "inn": "223402781200",
    "kpp": "",
    "name": "ИП Семёнова Дарья Юрьевна",
    "ogrn": "317213000002341",
    "value": "223402781200, ИП Семёнова Дарья Юрьевна"
  },
  "passport_bti": {
    "bti": "РГУП БТИ",
    "content": {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_5.jpg",
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_3.jpg",
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_8.jpg",
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_4.jpg",
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_2.jpg",
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_1.jpg",
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_9.jpg",
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_6.jpg",
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_7.jpg",
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D1%82%D0%B5%D1%85%D0%BF%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%82_10.jpg"
      ]
    },
    "issue_date": "2012-10-05",
    "inventory_number": "50К.2-9930/I-9",
    "appartment_number": "1009"
  },
  "planeta_number": "4118",
  "cadastre_number": "16:50:090570:406",
  "letter_of_attorney": {
    "content": {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%B4%D0%BE%D0%B2%D0%B5%D1%80.jpg"
      ]
    }
  },
  "lease_contracts": [
    {
      "tenant": {
        "inn": "223231781200",
        "kpp": "",
        "name": "ИП Семёнова Дарья Юрьевна",
        "ogrn": "317213000003211",
        "value": "223231781200, ИП Семёнова Дарья Юрьевна"
      },
      "content": {
        "files": [
          "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%B4%D0%BE%D0%B3%D0%BE%D0%B2%D0%BE%D1%80_%D0%B0%D1%80%D0%B5%D0%BD%D0%B4%D1%8B_%D1%81%D1%82%D1%801.jpg",
          "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%B4%D0%BE%D0%B3%D0%BE%D0%B2%D0%BE%D1%80_%D0%B0%D1%80%D0%B5%D0%BD%D0%B4%D1%8B_%D1%81%D1%82%D1%806.jpg",
          "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%B4%D0%BE%D0%B3%D0%BE%D0%B2%D0%BE%D1%80_%D0%B0%D1%80%D0%B5%D0%BD%D0%B4%D1%8B_%D1%81%D1%82%D1%807.jpg",
          "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%B4%D0%BE%D0%B3%D0%BE%D0%B2%D0%BE%D1%80_%D0%B0%D1%80%D0%B5%D0%BD%D0%B4%D1%8B_%D1%81%D1%82%D1%805.jpg",
          "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%B4%D0%BE%D0%B3%D0%BE%D0%B2%D0%BE%D1%80_%D0%B0%D1%80%D0%B5%D0%BD%D0%B4%D1%8B_%D1%81%D1%82%D1%803.jpg",
          "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%B4%D0%BE%D0%B3%D0%BE%D0%B2%D0%BE%D1%80_%D0%B0%D1%80%D0%B5%D0%BD%D0%B4%D1%8B_%D1%81%D1%82%D1%802.jpg",
          "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%B4%D0%BE%D0%B3%D0%BE%D0%B2%D0%BE%D1%80_%D0%B0%D1%80%D0%B5%D0%BD%D0%B4%D1%8B_%D1%81%D1%82%D1%804.jpg"
        ]
      },
      "valid_to": "2018-10-31",
      "valid_from": "2017-11-24",
      "landlord_organizations": [
        {
          "inn": "161233810037",
          "kpp": "",
          "name": "ИП Савушкин Павел Анатольевич",
          "ogrn": "312169031700332",
          "value": "161233810037, ИП Савушкин Павел Анатольевич"
        }
      ]
    }
  ],
  "address_with_map": {
    "address": {
      "value": "г Казань, ул Ягодинская, д 25",
      "fias_id": "37811460-c822-46b5-b109-940fa88608b3",
      "fias_level": "8",
      "city_district": "Кировский р-н",
      "geo_coordinates": {
        "lat": 55.8143423,
        "lon": 49.0771051
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
              49.07703697661419,
              55.81445562161933
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
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%A1%D0%B2-%D0%B2%D0%BE_%D0%BE_%D0%B3%D0%BE%D1%81_%D1%80%D0%B5%D0%B3%D0%B8%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D0%B8_%D0%BF%D1%80%D0%B0%D0%B2%D0%B0.jpg"
      ],
      "description": "свидетельство  регистрации права"
    },
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%BF%D0%BB%D0%B0%D0%BD%D0%B5%D1%82%D0%B0_%D0%B7%D0%B0%D0%B4%D0%B0%D1%87.jpeg"
      ],
      "description": "пз"
    },
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%95%D0%93%D0%A0%D0%98%D0%9F_2.jpg",
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%95%D0%93%D0%A0%D0%98%D0%9F.jpg"
      ],
      "description": "Выписка"
    },
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/808C26AB-B112-4206-B1FD-33F36A275432/%D0%98%D0%9D%D0%9D_%D0%9E%D0%93%D0%A0%D0%9D%D0%98%D0%9F.jpg"
      ],
      "description": "ИНН и ОГРНИП"
    }
  ]
}
```
