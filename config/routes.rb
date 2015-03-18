Sportal::Application.routes.draw do
  devise_for :users
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get 'login', to: 'users#sign_in', as: 'login'
  get 'logout', to: 'users#sign_out', as: 'logout'
  get 'stud_data', to: 'welcome#stud_data'
  get 'dept_data', to: 'welcome#dept_data'
  get 'rec_course_data', to: 'welcome#rec_course_data'
  get 'curr_course_data', to: 'welcome#curr_course_data'
  get 'store_course', to: 'welcome#store_course'
  get 'store_appeal', to: 'welcome#store_appeal'
  get 'remove_selection', to: 'welcome#remove_selection'
  get 'remove_appeal_option', to: 'welcome#remove_appeal_option'
  get 'dept_grade_courses_data', to: 'welcome#dept_grade_courses_data'
  get 'get_courses', to: 'welcome#get_courses'
  get 'electives', to: 'welcome#electives'
  get 'store_elective', to: 'welcome#store_elective'
  get 'remove_elective', to: 'welcome#remove_elective'
  get 'summary', to: 'welcome#summary'
  post "/note_to_scheduler", to: 'welcome#note_to_scheduler', as: 'note_to_scheduler'
  post "update-account", to: 'welcome#update', as: 'update_user'
  get "edit-account", to: 'welcome#edit', as: 'edit_user'
  get "change-password", to: 'welcome#change_password', as: 'change_password'
  get "welcome", to: 'teachers_welcome#index'

  
  # -------------------------------------------------------------------
    # Admin Routes
    # -------------------------------------------------------------------
     
  
    get '/admin', to: "admin/accounts#index", as: "admin"
    get "/admin/accounts/:action", controller: "admin/accounts"
    
 namespace :admin do
    resources :accounts
    resources :grades
      
    resources :departments
      
    resources :courses do
       member do
         get 'activate'
         get 'deactivate'
       end
       collection do
         post 'activate_all'
         post 'deactivate_all'
       end
    end
    resources :electives
      
     resources :students do
     	member do
     	  get 'activate'
     	  get 'deactivate'
     	end
     	collection do
     		post 'update_selected'
     		post 'activate_all'
     		post 'deactivate_all'
        post 'add_previous_course'
        post 'add_recommended_course'
        post 'add_current_course'
        post 'remove_recommended_course'
        post 'remove_taken_course'
        post 'remove_current_course'
        post 'student_add_current_course'
        post 'student_remove_current_course'
        post 'student_add_appeal'
        post 'student_remove_appeal'
        post 'student_add_other_course'
        post 'student_remove_other_course'
        post "move_course_request_up"
        post "move_course_request_down"
     	end
     end
     resources :teachers
     resources :admins
  end
  resources :departments
end
