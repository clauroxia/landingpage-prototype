# frozen_string_literal: true

# Dropping Tables
Subscriber.destroy_all
Preference.destroy_all

# Seeding Preferences
Preference.create([{ name: 'women' }, { name: 'men' }, { name: 'children' }])
