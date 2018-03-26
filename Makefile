generate_schemas:
	ruby _plugins/schema_generator.rb

production:
	@echo 'export HOST=http://edoc-schema.kzn.ru'

development:
	@echo 'export HOST=http://localhost:4000'
