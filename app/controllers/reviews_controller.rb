class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[new edit create update destroy]

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
    
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    @user = User.find_by(email: set_review.authorEmail)
    @countUserLikes = countUserLikes(@user)
  end

  # GET /reviews/new
  def new
    @users = User.select(:email).map(&:email)
    @categories = Category.all
    @review = Review.new

  end

  # GET /reviews/1/edit
  def edit
    
    if set_review.authorEmail == current_user.email || current_user.admin
      @categories = Category.all
      @users = User.select(:email).map(&:email)
    else
      redirect_to root_path
    end
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: t('review.created') }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: t('review.destroyed') }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    
    respond_to do |format|
      if @review.update(review_params)
        
          format.html { redirect_to @review, notice: t('review.edited')}
          format.json { render :show, status: :ok, location: @review }
        
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  

  private

  def countUserLikes(user)
    @reviews = Review.where(authorEmail: user.email)
    sum = 0
    @reviews.each do |review|
      sum += review.likes.count
    end
    return sum.to_s
  end


    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
    if current_user.admin   
      params.require(:review).permit(:category_id, :name, :body, :rating, :authorEmail)

    else
      params.require(:review).permit(:category_id, :name, :body, :rating).merge(authorEmail: current_user.email)
    end  
  
end
