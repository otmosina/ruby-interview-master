# frozen_string_literal: true

NativeDbTypesOverride.configure_adapters(
  postgres: {
    datetime: { name: "timestamptz" },
    timestamp: { name: "timestamptz" }
  }
)
