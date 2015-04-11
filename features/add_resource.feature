Feature: User can manually add a resource

Scenario: Adds a resource to the database
	Given I am on the resources page
	When I press "Add"
	And I fill in "name" with "Spoon"
	And I fill in "description" with "Used for eating soup"
	And I fill in "numberOf" with "2"
	When I press "Save"
	Then I should see "Spoon"