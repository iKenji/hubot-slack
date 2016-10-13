#  Description
#   omit
# 定期処理をするオブジェクトを宣言
JapaneseHoliday = require('japanese-public-holiday')
cronJob = require('cron').CronJob

module.exports = (robot) ->

  # 特定のチャンネルへ送信するメソッド(定期実行時に呼ばれる)　
  send = (channel, msg) ->
    robot.send {room: channel}, msg

  # Crontabの設定方法と基本一緒 *(sec) *(min) *(hour) *(day) *(month) *(day of the week)
  new cronJob('0 0 19 * * 1-5', () ->
    # ↑のほうで宣言しているsendメソッドを実行する
    today = new Date
    if checkIsNotHoliday(today)
      send '#freetalk', "hubotがhubotで 19:00 をお知らせします :beer:"
  ).start()

  new cronJob('0 0 12 * * 1-5', () ->
    # send '#freetalk', "hubotがhubotで12時をお知らせします。:baby:"
  ).start()

  new cronJob('0 0 18 * * 1-5', () ->
    # send '#freetalk', "hubotがhubotで定時(18:00)をお知らせします :beer:"
  ).start()

  new cronJob('0 0 10 * * 1-5', () ->
    today = new Date
    if checkIsNotHoliday(today)

      send '#freetalk', "おはようございます！' + today.getFullYear() + “/” +  today.getMonth() + 1 + “/”+ today.getDate()  + “/” + today.getDay())  + ' の朝礼を開始します:raising_hand:"
  ).start()

#休日でない場合にtrueを返す
checkIsNotHoliday = (date) ->
  if !japaneseHoliday.isPublicHoliday(date)
    return true
  if !checkEndOfTheYear(date)
    return true
  if !checkBeginningOfTheYear(date)
    return true
  return false

#年末の12月29,30,31日かどうかをチェック
checkEndOfTheYear = (date) ->
  month = 12
  day = 29
  for i in [0..2]
    if isHoliday(date, month, day)
      return true
    day++
  return false

#年始の1月2,3日かどうかをチェック
checkBeginningOfTheYear = (date) ->
  month = 1
  day = 2
  for i in [0..1]
    if isHoliday(date, month, day)
      return true
    day++
  return false

#dateとholidayが同一日の場合trueを返す
isHoliday = (date, holidayMonth, holidayDay) ->
  holiday = new Date(date.getFullYear(), holidayMonth-1, holidayDay)
  #dateとholidayが同じ日程であったなら
  if date.getMonth() == holiday.getMonth() and date.getDate() == holiday.getDate()
    return true
  return false
