# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'components')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
# Rails.application.config.assets.precompile += %w( '.woff', '.eot', '.svg', '.ttf')

# Because I configured for page-specific javascripts (instead of dumping everything into application.js)
# precompile += %w( directory1/* directory2/* file.js )
Rails.application.config.assets.precompile += %w( page-specific/* tmpls/*)


# https://github.com/seejohnrun/ice_cube/issues/252
# bump up icecube version to 12.
IceCube.compatibility = 12