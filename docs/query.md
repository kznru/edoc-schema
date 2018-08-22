Query(Запрос)
------------
##### States(состояния)
* created: начальное состояние, задаётся при создании запроса.
* started: запрос принят к исполнению.
* assigned: запрос назначен исполнителю.
* completed: запрос завершен.
<!--
* completed_signed: запрос завершен и подписан.
-->
* rejected: запрос отклонен.
<!--
* rejected_signed: запрос отклонен и подписан.
-->
* cancelled: запрос отменён.

<!--
* scheduled_consultation:
* consultation:
* consulted:
-->

### Events(события)
* start: принять запрос к исполнению.
  * created –> started
* assign: назначить запрос исполнителю.
  * started –> assigned
  * assigned –> assigned
* complete: завершить запрос.
  * assigned –> completed
* reject: отклонить запрос.
  * assigned –> rejected
