class PreparedsController < ItemsController
  autocomplete :raw, :name, :full => true
  def new
    @item = Prepared.new
  end

  def create
    @item = Prepared.create(params[:prepare])
  end
end
