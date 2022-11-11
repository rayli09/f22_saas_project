class CommentsController < ApplicationController
    before_action only: [:index, :edit, :update, :destroy, :create]
    before_action :set_event

  # GET /event/comments
    def index
        id = params[:id]
        @comments = @event.comments.all
    end

  # GET /comments/new
    def new
        #@comment = current_user.comments.build 
    end

  # GET /comments/1/edit
    def edit
        @comment = set_comment()
    end

  # POST /comments
    def create
        if is_comment_valid(comment_params)
            @comment = current_user.comments.create(comment_params)
            @comment.event_id = @event.id
            @comment.save
            flash[:notice] = 'Comment was successfully created.'
            redirect_to event_path(@event)
        else
            flash[:warning] = "Comment shoudn't be empty."
            redirect_to event_path(@event)
        end
    end

  # PUT /comments/1
    def update
        @comment = set_comment()
        is_valid = is_comment_valid(comment_params)
        if is_valid
            @comment.update_attributes(comment_params)
            flash[:notice] = "Comment was successfully updated."
            redirect_to event_path(@event)
        else
            flash[:notice] = "Comment content shouldn't be empty."
            redirect_to event_comment_path(@event, @comment)
        end
    end

  # DELETE /comments/1
    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        flash[:notice] = "Comment was deleted."
        redirect_to event_path(@event)
    end

    private
        # the comment shouldn't be empty
    def is_comment_valid(params)
        content = params["content"].to_s.strip
        if content.blank? or content.length > 100
            return false
        end
        return true
    end 

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
        @comment = Comment.find(params[:id])
    end

    def set_event
        @event = Event.find(params[:event_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
        params.require(:comment).permit(:content, :user_id, :event_id)
    end
end