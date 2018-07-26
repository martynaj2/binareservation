json.array! @reservations do |r|

	json.id r.id
	json.title r.title
	json.start r.start_date
	json.end r.end_date
end
