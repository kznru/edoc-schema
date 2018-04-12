UslugaRequest(Заявление на услугу)
------------
### States(состояния)
* created: начальное состояние, задаётся при создании заявления на услугу.
* submitted: заявление подтвреждено, задаётся автоматически.
* assigned: заявление назначено исполнителю.
* accepted: заявление принято.
* rejected: заявление отклонено.

<!--
* scheduled_consultation:
* consultation:
* consulted:
-->


### Events(события)
* submit: подтвердить заявление.
  * created –> submitted
* assign: назначить заявление исполнителю.
  * submitted –> assigned
  * assigned –> assigned
<!--
  * scheduled_consultation –> scheduled_consultation
  * consultation –> consultation
-->
* accept: приянть заявление.
  * assigned –> accepted
* reject: отклонить заявление.
  * assigned –> rejected
<!--
# called by system only
* schedule_consultation: заявление.
  * created –> scheduled_consultation
* begin_consultation: заявление.
  * created –> consultation
  * scheduled_consultation –> consultation
* end_consultation: заявление.
  * consultation –> consulted
 -->
