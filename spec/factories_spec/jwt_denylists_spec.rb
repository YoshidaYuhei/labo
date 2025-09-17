require 'rails_helper'

RSpec.describe JwtDenylist do
  let(:factories_to_lint) do
    FactoryBot.factories.select { it.name == described_class.name.underscore.to_sym }
  end

  it do
    aggregate_failures do
      expect(factories_to_lint).not_to be_blank

      expect { FactoryBot.lint(factories_to_lint, traits: true) }.not_to raise_error
    end
  end
end
