---
layout: page
title: Спецификация
permalink: /specification/
---
Соответствует стандарту [JSON Schema draft-06](http://json-schema.org/)

Схема для валидации
-------------------------------
[Core schema meta-schema](/validation_schema.json)

Стандартные схемы данных
------------------------

### Classifier
{% specification_list directory_name:classifier %}

### Document
{% specification_list directory_name:document %}

### Generic
{% specification_list directory_name:generic %}

### Geo
{% specification_list directory_name:geo %}

### Identifier
{% specification_list directory_name:identifier %}

### Location
{% specification_list directory_name:location %}

### Magnitude
{% specification_list directory_name:magnitude %}

### Organization
{% specification_list directory_name:organization %}

### Person
{% specification_list directory_name:person %}

Стандартный контейнер документа
-------------------------------
Приведённая выше схема [Document](/schemas/document/ru/document.json) описывает свойства абстрактного документа.
Описания конкретных типов документов используют её как контейнер для
размещения метаданных этого типа документа.

Взаимодействие между участниками обмена документами
---------------------------------------------------
В процессе обмена документами задействованы различные информационные системы.
Они используют:
 - стандартизированные форматы обмена
 - стандартизированные средства транспорта (TODO: про СМЭВ)
 - связи между документами (ссылки на документы указываются в соответствии с принципами RFC 1738 (URL) и RFC 3986 (URI))
 - типовые структуры данных (см. [спецификацию](/specification) и [примеры](/examples))
