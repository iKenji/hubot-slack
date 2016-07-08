# 定期処理をするオブジェクトを宣言
cronJob = require('cron').CronJob


module.exports = (robot) ->

  # 特定のチャンネルへ送信するメソッド(定期実行時に呼ばれる)　
  send = (channel, msg) ->
    robot.send {room: channel}, msg

  # Crontabの設定方法と基本一緒 *(sec) *(min) *(hour) *(day) *(month) *(day of the week)
  new cronJob('0 0 19 * * 1-5', () ->
    # ↑のほうで宣言しているsendメソッドを実行する
    send '#test', "@nonomu とりあえず一服。"
  ).start()

  new cronJob('0 0 12 * * 1-5', () ->
    send '#test', "hubotがhubotで12時をお知らせします。"
  ).start()

  new cronJob('0 20 15 * * 1-5', () ->
    send '#test', "hubotがhubotでテストしています"
  ).start()

  new cronJob('*/30 * * * * 1-5', () ->
    send '#test', "[repeat]hubotが30分おきにhubotでテストしています"
  ).start()
