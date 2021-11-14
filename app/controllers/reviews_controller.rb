class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[new edit create update destroy]

  # GET /reviews or /reviews.json
  def index
    @reviewsLast = Review.last(3).reverse
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    @user = User.find_by(email: set_review.authorEmail)
  end

  # GET /reviews/new
  def new
    @users = User.select(:email).map(&:email)
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    if set_review.authorEmail == current_user.email || current_user.admin
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
        format.html { redirect_to @review, notice: "Review was successfully created." }
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
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    
    respond_to do |format|
      if @review.update(review_params)
        
          format.html { redirect_to @review, notice: "Review was successfully updated." }
          format.json { render :show, status: :ok, location: @review }
        
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
    if current_user.admin   
      params.require(:review).permit(:group, :name, :body, :rating, :authorEmail)

    else
      params.require(:review).permit(:group, :name, :body, :rating).merge(authorEmail: current_user.email)
    end  
  
end
