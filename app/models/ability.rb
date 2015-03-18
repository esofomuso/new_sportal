class Ability
  include CanCan::Ability

  def initialize(user)
    
    def initialize(u)
      @user = u
      send(user.user_type.name.downcase)
    end
    
    
    def guest
        cannot :manage, :all
        can :read, :public
      end
    
      def student
        guest
        can :select_courses
        # other stuff
      end
    
      def teacher
        student
        can :manage, [:guest, :student, :teacher, Course, CurrentCourse, CurrentElective, Elective, Grade, RecommendedCourse, TakenCourse, AppealCourse]
        cannot destroy :teacher
        can approve :course_selection
        # other stuff
      end
    
      def admin
        teacher
        # other stuff
        can :manage, [:admin, :teacher, UserType, User]
        can destroy :teacher
        # other stuff
      end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
