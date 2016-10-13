#  Description
#   omit
#

messages = [
  '選ばれたのは、 {name} さん でした :tea:',
  '　{name} さんが適任です :smile:',
  '　{name} さん 呼ばれてますよ :raising_hand:',
  'たぶん {name}さんが良いとおもいます....  :thinking_face:'
]

module.exports = (robot) ->
  robot.respond /.*(random|ランダム|抽選|選ぶ|誰|選んで).*/i, (msg) ->
    url = 'https://slack.com/api/channels.list?token=' + process.env.HUBOT_SLACK_BOT_TOKEN
    # チャンネル一覧を取得
    request = require('request')
    request.get(url, (err, res, body) ->
      # msg.message.room で現在の channel 名が取れる
      channel = findChannel(JSON.parse(body).channels, msg.message.room)

      # bot 自身を除外して抽選
      botId = robot.name

      member = msg.random(channel.members)
      message = msg.random(messages)

      msg.send(message.replace('{name}', "<@" + member + ">"))
    )

    findChannel = (channels, targetName) ->
      for key,channel of channels
        if channel.name == targetName
          return channel
