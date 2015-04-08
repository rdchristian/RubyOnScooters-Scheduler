Feature: User can manually add a facility

Scenario: Adds a facility to the database
	Given I am on the facilities page
	When I press "Add"
	And I fill in "name" with "Closet"
	And I fill in "description" with "Small room for storage"
	And I fill in "capacity " with "2"
	When I press "Save"
	Then I should see "Closet"