---
layout: page
title: Примеры
permalink: /examples/
---
Ниже приведены примеры использования EDOC-Schema.

## Пример документа
# Заявление на предоставление муниципальной услуги
Заявление, как и любой другой документ, использует стандартный [контейнер для хранения документов](/schemas/document/ru/document.json) ([пример данных](/examples/document/ru/signboard_lease_living.json)).
[Пример мета-данных](/uslugi/) - заявление на оказание муниципальной услуги по 210-ФЗ.

## Простые
# Пример ИНН
Схема:
```json
{% include schemas/identifier/ru/inn.json %}
```

Данные:
```json
"160123456789"
```

# Пример ОКОПФ
Схема:
```json
{% include schemas/classifier/ru/okopf.json %}
```

Данные:
```json
{
  "code": "12300",
  "title": "Общество с ограниченной ответственностью"
}
```

# ФИО
Схема:
```json
{% include schemas/person/ru/fio.json %}
```

Данные:
```json
{
  "surname": "Пушкин",
  "name": "Александр",
  "patronimic": "Сергеевич"
}
```

## Составные
# ФИО и номер телефона
Схема:
```json
{% include schemas/person/ru/person_mobile.json %}
```

Данные:
```json
{
  "fio": {
    "surname": "Лобачевский",
    "name": "Николай",
    "patronimic": "Иванович"
  },
  "phone": {
    "country_code": 7,
    "region_code": 843,
    "number": 2599923
  }
}
```

# Юридическое лицо
Схема:
```json
{% include schemas/organization/ru/organization.json %}
```

Данные:
```json
{
  "inn": "1657119572",
  "ogrn": "1121690046411",
  "kpp": "165701001",
  "okopf": "12300",
  "name": {
    "full": "Рога и копыта",
    "short": "Рога и копыта",
    "abbreviation": "РиК",
    "common": "Рога"
  }
}
```

