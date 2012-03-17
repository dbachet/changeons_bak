# -*- encoding : utf-8 -*-
class AnswersController < ApplicationController
  before_filter :authenticate_user!
  
  def vote_up
    begin
      @answer_to_vote = Answer.find(params[:id])
      if current_user.voted_for?(@answer_to_vote)
        current_user.clear_votes(@answer_to_vote)
      else
        current_user.vote_exclusively_for(@answer_to_vote)
      end
      @answer_votes_result = @answer_to_vote.plusminus
      # authorize! :vote_up, @post
      
      respond_to do |format|
        format.js { render 'answers/vote_refresh'}
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  def vote_down
    begin
      @answer_to_vote = Answer.find(params[:id])
      if current_user.voted_against?(@answer_to_vote)
        current_user.clear_votes(@answer_to_vote)
      else
        current_user.vote_exclusively_against(@answer_to_vote)
      end
      @answer_votes_result = @answer_to_vote.plusminus
      
      # authorize! :vote_down, @post
      
      respond_to do |format|
        format.js { render 'answers/vote_refresh'}
      end
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end
  
  # GET /answers
  # GET /answers.xml
  def index
    @answers = Answer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.xml
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.xml
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(params[:answer])
    @answer.user_id = current_user
    
    respond_to do |format|
      if @answer.save
        format.html { redirect_to(@answer, :notice => 'Answer was successfully created.') }
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.xml
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to(@answer, :notice => 'Answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(answers_url) }
      format.xml  { head :ok }
    end
  end
end
