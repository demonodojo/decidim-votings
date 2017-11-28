# frozen_string_literal: true

module Decidim
  module Votings
    # This is the engine that runs on the public interface of
    # `decidim-votings`. It mostly handles rendering
    # the collaborations associated to a participatory Decidimprocess.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Votings::Admin

      paths['db/migrate'] = nil

      routes do
        resources :votings
        get '/votings_scopes/search', to: 'votings_scopes#search', as: :votings_scopes_search

        root to: 'votings#index'
      end
    end
  end
end