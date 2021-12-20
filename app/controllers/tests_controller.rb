class TestsController < Simpler::Controller

  def index
    @time = Time.now
    status 201
    headers['Content-type'] = 'text/plain'
  end

  def create

  end

end
