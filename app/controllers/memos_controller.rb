class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  
  def index
    @memos = Memo.all
    @search = Memo.search(params[:q]) 
    @memos = @search.result 

    respond_to do |format|
      format.html
      format.json { render json: @memos }
    end

  end
  
  def show
  end

  def new
    @memo = Memo.new
  end

  def edit
  end

  def create
    @memo = Memo.new(memo_params)

    respond_to do |format|
      if @memo.save
        TitlesChangeJob.perform_later(@memo.id)
        format.html { redirect_to memos_path } 
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :new }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @memo.update(memo_params)
        TitlesChangeJob.perform_later(@memo.id)
        format.html { redirect_to memos_path } 
        format.json { render :show, status: :ok, location: @memo }
      else
        format.html { render :edit }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to memos_path } 
      format.json { head :no_content }
    end
  end

  private
  
    def set_memo
      @memo = Memo.find(params[:id])
    end

    def memo_params
      params.require(:memo).permit(:title, :content, :icon)
    end
end
