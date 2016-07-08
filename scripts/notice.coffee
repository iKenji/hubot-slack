#  Description
#   omit
# 定期処理をするオブジェクトを宣言
cronJob = require('cron').CronJob

module.exports = (robot) ->

  # 特定のチャンネルへ送信するメソッド(定期実行時に呼ばれる)　
  send = (channel, msg) ->
    robot.send {room: channel}, msg

  # Crontabの設定方法と基本一緒 *(sec) *(min) *(hour) *(day) *(month) *(day of the week)
  new cronJob('0 0 19 * * 1-5', () ->
    # ↑のほうで宣言しているsendメソッドを実行する
    send '#freetalk', "hubotがhubotで定時をお知らせします"
  ).start()

  new cronJob('0 0 12 * * 1-5', () ->
    send '#freetalk', "hubotがhubotで12時をお知らせします。"
  ).start()

  new cronJob('0 30 18 * * 1-5', () ->
    send '#freetalk', "業務報告を書いて帰る支度を始めましょう"
  ).start()
