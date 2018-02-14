---
layout: page
title: Услуги
permalink: /uslugi/
---
В рамках внедрения информационной систему "Управления муниципальными
услугами" разработан формат хранения и обработки электронных документов,
нелобходимых для предоставления муниципальных услуг.

Ниже приведён пример электронного документа,
описывающего заявление на предоставление муниципальной услуги
по выдаче ордера на выполнение аварийных земляных работ.

Используемые definitions

|---|---|
| [Geographic Coordinate](/schemas/geo/point.json) <br> [<small>(canonical url)</small>](/geo/point) | географические координаты точки (широта и долгота) |


Схема:
```json
{% include schemas/document/ru/uslugi/40_kvb_orders_emergency.json %}
```

Данные:
```json
{
  "agent": {
    "fio": {
      "name": "Михаил",
      "surname": "Лермонтов",
      "patronymic": "Юрьевич"
    },
    "email": "timerbaev.ramis@mail.ru",
    "mobile": "+70123456789",
    "passport_number": "123456"
  },
  "end_date": "2017-12-27",
  "begin_date": "2017-12-20",
  "application": {
    "content": {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/-001.jpg"
      ]
    }
  },
  "attachments": [
    {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/-004.jpg"
      ],
      "description": "памятка"
    }
  ],
  "organization": {
    "inn": "1653006666",
    "kpp": "166001001",
    "ogrn": "1021602830370",
    "okopf": {
      "code": "122000",
      "code": "Муниципальное унитарное предприятие",
    },
    "name": {
      "full": "Водоканал",
      "short": "Водоканал",
      "commmon": "Водоканал",
    },
  },
  "confirmations": [
    "я ознакомлен с регламентом предоставления услуги",
    "я ознакомлен с правилами благоустройства г.Казани"
  ],
  "certificate_sro": {
    "content": {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/OneTouch_Sep_04_2017_15.JPG",
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/OneTouch_Sep_04_2017_14.JPG",
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/OneTouch_Sep_04_2017_12.JPG",
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/OneTouch_Sep_04_2017_16.JPG",
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/OneTouch_Sep_04_2017_13.JPG"
      ]
    }
  },
  "address_with_map": {
    "address": {
      "value": "г Казань, ул Дубравная, д 47",
      "fias_id": "0c1413ce-a612-4401-b0ee-2958c6d8051c",
      "fias_level": "8",
      "geo_coordinates": {
        "lat": 55.7382689,
        "lon": 49.2008083
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
              49.20199692249299,
              55.73840054703434
            ]
          },
          "properties": {

          }
        }
      ]
    }
  },
  "warranty_restore": {
    "content": {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/-003.jpg"
      ]
    }
  },
  "letter_of_attorney": {
    "content": {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/-009.jpg",
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/-010.jpg",
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/-008.jpg"
      ]
    }
  },
  "emergency_repair_of": "Водопровод",
  "customer_responsible": {
    "name": "Ильдар",
    "surname": "Ахметзянов",
    "patronymic_name": "Ильгизович"
  },
  "contractor_responsible": {
    "fio": {
      "name": "Андрей",
      "surname": "Сафин",
      "patronymic_name": "Фаритович"
    },
    "mobile": "89870085576"
  },
  "topography_of_networks": {
    "files": [
      "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/-006.jpg"
    ]
  },
  "contractor_organization": {
    "inn": "1653006666",
    "kpp": "166001001",
    "name": "МУП \"ВОДОКАНАЛ\"",
    "ogrn": "1021602830370",
    "value": "1653006666, МУП \"ВОДОКАНАЛ\""
  },
  "certificate_of_separation": {
    "content": {

    }
  },
  "subcontractor_responsible": {
    "fio": {

    }
  },
  "area_of_damage_to_sidewalk": "5",
  "conclusion_place_of_damage": {
    "content": {
      "files": [
        "https://s3.uslugi.kzn.ru/uploads/D95CD02F-5102-4EEC-AF98-88207420DE03/-002.jpg"
      ]
    }
  },
  "subcontractor_organization": {

  },
  "area_of_damage_to_local_road": "5"
}
```
