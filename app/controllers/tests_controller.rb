class TestsController < Simpler::Controller

  def index
    @time = Time.now
    status 201
    headers
  end

  def create; end

  def show
    @test = Test.find(params[:id])
  end
end
