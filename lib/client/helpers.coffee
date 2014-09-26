getUserInitial = (user)->
	if user.username
		user.username.charAt(0).toUpperCase()
	else if user.profile.firstName
		user.profile.firstName.charAt(0).toUpperCase()
	else if user.profile.email
		user.emails[0].address.charAt(0).toUpperCase()
	else
		'<i class="fa fa-user"></i>'

getUserColor = (user)->
	index = user._id.charCodeAt(0) - 48
	UserHelpers.colorPalette[index]

Template.profileThumb.helpers
	profileThumbSrc: (_id) ->
		if typeof Meteor.users != 'undefined'
			if Meteor.users.findOne _id
				user = Meteor.users.findOne({_id:_id})
				if typeof user.profile.picture != 'undefined'
					picture = user.profile.picture

					if picture.indexOf('/') > -1
						picture
					else
						if typeof ProfilePictures != 'undefined' && ProfilePictures.findOne user.profile.picture
							picture = ProfilePictures.findOne picture
							picture.url({store: 'thumbs'});
	profileThumbInitial: (_id) ->
		if typeof Meteor.users != 'undefined'
			user = Meteor.users.findOne({_id:_id})
			html = getUserInitial(user)
			{
				html: html
				color: 'white'
				backgroundColor: getUserColor(user)
			}