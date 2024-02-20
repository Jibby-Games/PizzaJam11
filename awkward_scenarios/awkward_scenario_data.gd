class_name AwkwardScenarioData extends Resource

## The text that sets up the event
@export var event_text: String
## Toggle if the player is talking during the scenario being presented
@export var playertalk_scenario: bool
## Toggle if the NPC is talking during the scenario being presented
@export var npctalk_scenario: bool
## The animation to use for the NPC animation during the scenario being presented
## One of:
##  - girl0
##  - girl0_grimace
@export var npc_animation: String
## The animation to use for the player animation during the scenario being presented
@export var player_animation: String

### CHOICE 1
## Player choice 1
@export var choice_1: String
## Response to player choice 1
@export var response_1: String
## Awkwardness for choice 1
@export var awkardness_1: int
## Set the player animation for choice 1 response
@export var player_animation_1: String
## Toggles player speaking animation for choice 1 response
@export var player_talk_1: bool
## Set the npc animation for choice 1 response
@export var npc_animation_1: String
## Toggles NPC speaking animation for choice 1 response
@export var npc_talk_1: bool

### CHOICE 2
## Player choice 2
@export var choice_2: String
## Response to player choice 2
@export var response_2: String
## Awkwardness for choice 2
@export var awkardness_2: int
## Set the player animation for choice 2 response
@export var player_animation_2: String
## Toggles player speaking animation for choice 2 response
@export var player_talk_2: bool
## Set the npc animation for choice 2 response
@export var npc_animation_2: String
## Toggles NPC speaking animation for choice 2 response
@export var npc_talk_2: bool

### CHOICE 3
## Player choice 3
@export var choice_3: String
## Response to player choice 3
@export var response_3: String
## Awkwardness for choice 3
@export var awkardness_3: int
## Set the player animation for choice 3 response
@export var player_animation_3: String
## Toggles player speaking animation for choice 3 response
@export var player_talk_3: bool
## Set the npc animation for choice 3 response
@export var npc_animation_3: String
## Toggles NPC speaking animation for choice 3 response
@export var npc_talk_3: bool
