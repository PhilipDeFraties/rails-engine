class ApplicationController < ActionController::API

  private

  def check_params(params)
    render json: JSON.generate(
      {
        error: 'missing parameter',
        errors: params.map { |param| "#{param} parameter with value required in search request" },
        status: :bad_request
      }
    )
  end
end
