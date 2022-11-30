class CommentsController < ApplicationController
    before_action only: [:edit, :update, :destroy, :create, :react]
    before_action :set_event

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
            redirect_to edit_event_comment_path(@event, @comment)
        end
    end

  # DELETE /comments/1
    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        flash[:notice] = "Comment was deleted."
        redirect_to event_path(@event)
    end

  # user thumb-up/like/laugh or undo the reaction to the comment
    def react
        comment_id = params[:id]
        dictionary = { 0 => "thumb-uped", 1 => "liked", 2 => "laughed" }
        action = params[:action_id].to_i
        user_id = User.find_by(username: current_user.username).id
        record = Reaction.find_by(user_id: user_id, comment_id: comment_id, action: action)
        # the user didn't click the reaction before
        if record.nil?
            reaction = current_user.reactions.create(user_id: user_id, comment_id: comment_id, action: action)
            reaction.save
            flash[:notice] = "You " + dictionary[action] + " the comment."
        else
            record.destroy
            flash[:warning] = "You un" + dictionary[action] +  " the comment."
        end
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