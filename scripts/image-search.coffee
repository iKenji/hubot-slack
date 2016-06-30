module.exports = (robot) ->
  robot.respond /tiqav (.*)/i, (msg) ->
    request = require('request');
    request.get("http://api.tiqav.com/search.json?q=#{msg.match[1]}", (error, response, body) ->
      if error or response.statusCode != 200
        return msg.send('$B2hA|8!:w$K<:GT$7$^$7$?(B...')
      data = JSON.parse(body)[0]
      # robot.logger.info data
      msg.send "$B2hA|$NMM;R$G$9(B: http://img.tiqav.com/#{data.id}.#{data.ext}" )
