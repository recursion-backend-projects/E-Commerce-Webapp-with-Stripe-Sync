class SamplesController < ApplicationController
  before_action :authenticate_admin_account!
  def index; end
end
