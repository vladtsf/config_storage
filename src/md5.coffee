crypto = require 'crypto'

module.exports = (text) ->
	shasum = crypto.createHash 'md5'
	shasum.update text
	shasum.digest 'hex'