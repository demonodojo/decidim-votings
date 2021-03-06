# frozen_string_literal: true

module Decidim
  module Votings
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    # Note that it inherits from `Decidim::Features::BaseController`, which
    # override its layout and provide all kinds of useful methods.
    class ApplicationController < Decidim::Features::BaseController
      include FormFactory
    end
  end
end
