module RelationshipRole
	CREATOR = 0
	PHOTOGRAPHER = 1
	RIDER = 2

	def role_name(role)
		if role == 0 then "Creator" 
		elsif role == 1 then "Photographer"
		elsif role == 2 then "Rider"
		end
	end
end