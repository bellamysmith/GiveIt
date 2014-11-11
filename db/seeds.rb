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
