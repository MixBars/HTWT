class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[new edit create update destroy]
  before_action :userLikeOnReview 

  def index
    @reviews = Review.all
    
  end

  def show
    @author = getAuthor(set_review)
    
    @showAuthorInfo = getAuthorNick(set_review) + ' ('+ t('profile.likesCount') + countUserLikes(getAuthor(set_review)) + ')'
    
  end

  def new
    @users = User.select(:email).map(&:email)
    @categories = Category.all
    @review = Review.new

  end

  def edit
    
    if set_review.authorEmail == current_user.email || current_user.admin
      @categories = Category.all
      @users = User.select(:email).map(&:email)
    else
      redirect_to root_path
    end
  end

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

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to getAuthor(@review), notice: t('review.destroyed') }
      format.json { head :no_content }
    end
  end

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

  def userLikeOnReview
    if user_signed_in?
    @like = Like.where(user_id: current_user.id, review_id: params[:id])
    end
  end
  
  def getAuthorNick(review)
    review.authorEmail[0..review.authorEmail.index('@')-1]
  end

  def getAuthor(review)
    User.find_by(email: review.authorEmail)
  end

  def countUserLikes(user)
    @reviews = Review.where(authorEmail: user.email)
    sum = 0
    @reviews.each do |review|
      sum += review.likes.count
    end
    return sum.to_s
  end


    def set_review
      @review = Review.find(params[:id])
    end

 
    def review_params
    if current_user.admin   
      params.require(:review).permit(:category_id, :name, :content, :rating, :authorEmail)

    else
      params.require(:review).permit(:category_id, :name, :content, :rating).merge(authorEmail: current_user.email)
    end  
  
end
