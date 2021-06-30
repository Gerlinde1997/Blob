extends Node

## Stores all variables needed for loading another room
## Copyright (C) 2021 Gerlinde van Ginkel
## SPDX-License-Identifier: GPL-3.0-or-later

# chosen input "wsad" or "click_move"
var chosen_input

# Player variables
var pos = null
var animation = null
var coins = 0

# name of NPC...
var colors = []

var quest_status_by_npc = {"Red": 0, "Orange": 0, "Yellow": 0, "Green": 0, "Blue": 0, "Purple": 0}

# stock NodePath of collected items
var picked_coins = []
var picked_shovel = null
var picked_hidden_coin = null