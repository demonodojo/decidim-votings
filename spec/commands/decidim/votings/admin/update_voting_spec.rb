# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Votings
    module Admin
      describe UpdateVoting do
        subject { described_class.new(form, voting) }

        let(:organization) { create(:organization) }
        let(:participatory_process) do
          create :participatory_process, organization: organization
        end
        let(:current_feature) do
          create :voting_feature, participatory_space: participatory_process
        end

        let(:context) do
          {
            current_organization: organization,
            current_feature: current_feature
          }
        end

        let(:voting) { create(:voting, feature: current_feature) }

        let(:title) { Decidim::Faker::Localized.sentence(3) }
        let(:description) { Decidim::Faker::Localized.sentence(3) }
        let(:image) { Decidim::Dev.test_file("city.jpeg", "image/jpeg") }
        let(:start_date) { (Time.zone.today + 1.day).strftime("%Y-%m-%d") }
        let(:end_date) { (Time.zone.today + 5.days).strftime("%Y-%m-%d") }
        let(:scope) { create :scope, organization: organization }
        let(:scope_id) { scope.id }
        let(:importance) { ::Faker::Number.number(2).to_i }
        let(:census_date_limit) { Time.zone.today.strftime("%Y-%m-%d") }
        let(:simulation_code) { ::Faker::Number.number(1).to_i }
        let(:voting_system) { "nVotes" }
        let(:voting_domain_name) { "test.org" }
        let(:voting_identifier) { "identifier" }
        let(:shared_key) { "SHARED_KEY" }

        let(:form) do
          double(
            invalid?: invalid,
            title: title,
            description: description,
            image: image,
            start_date: start_date,
            end_date: end_date,
            scopes_enabled: true,
            scope: scope,
            importance: importance,
            census_date_limit: census_date_limit,
            simulation_code: simulation_code,
            voting_system: voting_system,
            voting_domain_name: voting_domain_name,
            voting_identifier: voting_identifier,
            shared_key: shared_key
          )
        end
        let(:invalid) { false }

        context "when the form is not valid" do
          let(:invalid) { true }

          it "is not valid" do
            expect { subject.call }.to broadcast(:invalid)
          end
        end

        context "when everything is ok" do
          let(:updated_voting) { Decidim::Votings::Voting.last }

          it "sets all attributes received from the form" do
            subject.call
            expect(updated_voting.title).to eq title
            expect(updated_voting.description).to eq description
            expect(updated_voting.image.path.split("/").last).to eq "city.jpeg"
            expect(updated_voting.start_date.strftime("%Y-%m-%d")).to eq start_date
            expect(updated_voting.end_date.strftime("%Y-%m-%d")).to eq end_date
            expect(updated_voting.decidim_scope_id).to eq scope_id
            expect(updated_voting.importance).to eq importance
            expect(updated_voting.census_date_limit.strftime("%Y-%m-%d")).to eq census_date_limit
            expect(updated_voting.simulation_code).to eq simulation_code
            expect(updated_voting.voting_system).to eq voting_system
            expect(updated_voting.voting_domain_name).to eq voting_domain_name
          end
        end
      end
    end
  end
end
