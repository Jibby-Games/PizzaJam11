class_name AwkwardScenarioData extends Resource

## The text that sets up the event
@export var event_text: String
## Toggle if the player is talking during the scenario being presented
@export var playertalk_scenario: bool
## Toggle if the NPC is talking during the scenario being presented
@export var npctalk_scenario: bool
## The animation to use for the NPC animation
## One of:
##  - girl0
##  - girl0_grimace
@export var npc_animation: String

### CHOICE 1
## Player choice 1
@export var choice1: String
## Response to player choice 1
@export var response1: String
## Awkwardness for choice 1
@export var awkardness1: int
## Toggles player speaking animation for choice 1 response
@export var playertalk1: bool
## Toggles NPC speaking animation for choice 1 response
@export var npctalk1: bool

### CHOICE 2
## Player choice 2
@export var choice2: String
## Response to player choice 2
@export var response2: String
## Awkwardness for choice 2
@export var awkardness2: int
## Toggles player speaking animation for choice 2 response
@export var playertalk2: bool
## Toggles NPC speaking animation for choice 2 response
@export var npctalk2: bool

### CHOICE 3
## Player choice 3
@export var choice3: String
## Response to player choice 3
@export var response3: String
## Awkwardness for choice 3
@export var awkardness3: int
## Toggles player speaking animation for choice 3 response
@export var playertalk3: bool
## Toggles NPC speaking animation for choice 3 response
@export var npctalk3: bool
