mongoose = require('../mongo')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId
Mixed = Schema.Types.Mixed

Storage = new Schema
	uid :
		type: String
		index: true
	data:
		type: Mixed
		index: false
		default: {}
	version:
		type: Number
		index: false
		default: 0

Model = module.exports = mongoose.model 'Storage', Storage