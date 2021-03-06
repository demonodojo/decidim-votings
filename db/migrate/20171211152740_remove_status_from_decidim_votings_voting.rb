# frozen_string_literal: true

class RemoveStatusFromDecidimVotingsVoting < ActiveRecord::Migration[5.1]
  def up
    remove_column :decidim_votings_votings, :status
  end

  def down
    add_column :decidim_votings_votings, :status, :integer
  end
end
