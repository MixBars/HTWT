class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[new edit create update destroy]
  before_action :userLikeOnReview, :userRatingOnReview, only: %i[show]
  before_action :userRatingOnReview, only: %i[show index]

  def index
    @reviews = Review.all.paginate(page: params[:page], per_page: 4).order("created_at DESC")
    
  end

  def show
    
    @showAuthorInfo = set_review.user.nick + ' ('+ t('profile.likesCount') + set_review.user.countUserLikes + ')'
  end

  def new
    @users = User.all
    @categories = Category.all
    @review = Review.new
    
  end

  def edit
    if set_review.user.id == current_user.id || current_user.admin
      @categories = Category.all
      @users = User.all
    else
      redirect_to root_path
    end
  end

  def create
    @categories = Category.all
    @review = Review.new(review_params)
    @review.update(body: @review.content)

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

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @review.user, notice: t('review.destroyed') }
      format.json { head :no_content }
    end
  end

  def update
    
    respond_to do |format|
      if @review.update(review_params)
      @review.update(body: @review.content)
          format.html { redirect_to @review, notice: t('review.edited')}
          format.json { render :show, status: :ok, location: @review }
        
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  

  

  private

  def userLikeOnReview
    if user_signed_in?
    @like = Like.where(user_id: current_user.id, review_id: params[:id])
    end
  end

  def userRatingOnReview
    if user_signed_in?
    @rating = UserRating.where(user_id: current_user.id, review_id: params[:id])
    end
  end


    def set_review
      @review = Review.find(params[:id])
    end

 
    def review_params
    if current_user.admin   
      params.require(:review).permit(:category_id, :name, :content, :rating, :all_tags, :user_id)
    else
      params.require(:review).permit(:category_id, :name, :content, :rating, :all_tags).merge(user_id: current_user.id)
    end  
  end
end
