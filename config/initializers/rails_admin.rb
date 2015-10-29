module RailsAdmin
  module Config
    module Actions
      class DisableUser < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :visible? do
          authorized? && bindings[:object].class == User
        end

        register_instance_option :member do
          true
        end

        register_instance_option :link_icon do
          'icon-eye-open'
        end

        register_instance_option :http_methods do
          [:get, :put]
        end

        register_instance_option :controller do
          proc do
            if request.get? # DISABLE

              respond_to do |format|
                format.html { render @action.template_name }
                format.js   { render @action.template_name, layout: false }
              end

            elsif request.delete? # DISABLE 

              redirect_path = nil
              @auditing_adapter && @auditing_adapter.delete_object(@object, @abstract_model, _current_user)
              if @object.destroy
                flash[:success] = t('admin.flash.successful', name: @model_config.label, action: t('admin.actions.delete.done'))
                redirect_path = index_path
              else
                flash[:error] = t('admin.flash.error', name: @model_config.label, action: t('admin.actions.delete.done'))
                redirect_path = back_or_index
              end

              redirect_to redirect_path

            end
          end
        end
      end
    end
  end
end


RailsAdmin.config do |config|

  config.audit_with :history

  ### Popular gems integration

  ## == Devise ==
  #config.authenticate_with do
    #warden.authenticate! scope: :user
  #end
  #config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  #Include only this models on admin page
  config.included_models = ["User", "Page", "Post"]

  #Change order of models
  config.model 'User' do
    weight -1
  end

  config.navigation_static_links = {
    'Followme' => 'http://www.followme.co/amoludage'
  }

  config.authorize_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == 'admin' && password == 'josh1234'
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    disable_user
    ## With an audit adapter, you can add:
     history_index
     history_show
  end
end
