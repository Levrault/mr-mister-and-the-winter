extends Node

signal retro_filter_changed(value)

signal dialogue_interaction_started(text)
signal dialogue_collectable_started(text)
signal dialogue_combinable_started(text)
signal dialogue_finished
signal dialogue_text_displayed
signal dialogue_question_answered(answer)

signal loading_screen_animation_finished

signal map_changed_for(path, portal_id)

signal inventory_item_added(id)
