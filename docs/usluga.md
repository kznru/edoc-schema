Usluga(Услуга)
------------
##### States(состояния)
* created: начальное состояние, задаётся при создании услуги.
* started: услуга начата, задаётся после принятия заявления на услугу.
* assigned: услуга назначена исполнителю.
* assigned_again: услуга переназначена.
* completed: услуга завершена.
* completed_signed: услуга завершена и подписана.
* rejected: услуга отклонена.
* rejected_signed: услуга отклонена и подписана.

<!--
* scheduled_consultation:
* consultation:
* consulted:
-->


### Events(события)
* start: начать услугу.
  * created –> started
* assign: назначить услугу исполнителю.
  * started –> assigned
  * assigned –> assigned
  * assigned_again –> assigned_again
* complete: завершить услугу.
  * assigned –> completed
  * assigned_again –> completed
* reject: отклонить услугу.
  * assigned –> rejected
  * assigned_again –> rejected
* sign: подписать услугу.
  * completed –> completed_signed
  * rejected –> rejected_signed
* assign_again: переназначить услугу исполнителю.
  * completed –> assigned_again
  * rejected –> assigned_again
