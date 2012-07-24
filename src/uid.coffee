app = require './app'

module.exports = (req, res, next) ->
	uid = req.cookies[app.settings.cookieName]

	if uid?
		req.uid = uid
		next()
	else 
		res.send 403