# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Topic.destroy_all
Nonprofit.destroy_all
TopicJunctionTable.destroy_all

Topic.create([
	{topic: "Food"},
	{topic: "Hunger"},
	{topic: "Women"},
	{topic: "Business"},
	{topic: "Health"},
	{topic: "Microloans"},
	{topic: "Animal-Related"},
	{topic: "Arts & Culture"},
	{topic: "Civil Rights & Advocacy"},
	{topic: "Community Improvement"},
	{topic: "Crime/Legal"},
	{topic: "Medical"},
	{topic: "Education"},
	{topic: "Employment"},
	{topic: "Environment"},
	{topic: "Food & Nutrition"},
	{topic: "Health Care"},
	{topic: "Housing & Shelter"},
	{topic: "Human Services"},
	{topic: "International/Foreign Affairs"},
	{topic: "Medical Research"},
	{topic: "Mental Health & Crisis Intervention"},
	{topic: "Mutual & Membership Benefit"},
	{topic: "Philanthropy & Volunteerism"},
	{topic: "Public & Societal Benefit"},
	{topic: "Public Safety & Relief"},
	{topic: "Recreation & Sports"},
	{topic: "Religious"},
	{topic: "Science/Technology"},
	{topic: "Social Science"},
	{topic: "Other"},
	{topic: "Youth"},
	])
Nonprofit.create([
	{email: "example@example.com",
		name: "Bellamy's Nonprofit",
		password: "examplenonprofit",
		main_topic: Topic.first.id,
		description: "This is a description",
		website: "www.examplenonprofit.com",
		oauth: "example"},
	{email: "another@example.com",
		name: "No Oauth",
		password: "anotherexample",
		oauth: "example2",
		main_topic: 9,
		website: "http://miamifoundation.com",
		description: "This is a sample non profit, you can't really do anything with it, but I wanted to give it an example description"

		},
	{email: "sample@sample.com",
		name: "Women's Equality",
		password: "womensequality",
		oauth: "nooauth",
		description: "We work for Women's equality accross the globe, your dollar will go to microloans for women in Africa",
		website: "www.generalassemb.ly",
		main_topic: 6}	
		])