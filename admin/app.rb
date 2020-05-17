require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module AdminFramework
  class Admin < Padrino::Application
    '''
      Application Name
    '''
    $application_name="Admin Framework 1.0"
    '''
      Menu
    '''
    $pos_menu=0
    $data_menutree =
    [
      {'menu_parent':
        {
          'icon' => 'menu-icon icon-speedometer',
          'menu_name' => 'Dashboard',
          'url' => '/admin',
          'menu_child' => []
        }
      },
      {'menu_parent':
        {
          'icon' => 'menu-icon icon-users',
          'menu_name' => 'User Management',
          'url' => 'javascript::void(0);',
          'menu_child' =>[
             {
               'menu_name' => 'Accounts',
               'url' => '/admin/accounts'
             }
          ]
        }
      },
    ]
    $menu_max=$data_menutree.count

    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl
    register WillPaginate::Sinatra

    ##
    # Application configuration options
    #
    # set :raise_errors, true         # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true          # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true      # Shows a stack trace in browser (default for development)
    # set :logging, true              # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, "foo/bar"   # Location for static assets (default root/public)
    # set :reload, false              # Reload application files (default in development)
    # set :default_builder, "foo"     # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, "bar"         # Set path for I18n translations (default your_app/locales)
    # disable :sessions               # Disabled sessions by default (enable if needed)
    # disable :flash                  # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout              # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    set :admin_model, 'Account'
    set :login_page,  '/sessions/new'

    enable  :sessions
    disable :store_location

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow   '/sessions'
    end

    access_control.roles_for :supervisor do |role|
      role.project_module :accounts, '/accounts'
    end

    access_control.roles_for :admin do |role|
      role.project_module :accounts, '/accounts'
    end

    # Custom error management
    error(403) { @title = "403 | Not Permitted Access"; @title_error = "403"; @title_error_description = "Sorry, You do not Permitted Access"; render('errors/403', :layout => :error) }
    error(404) { @title = "404 | Not Found"; @title_error = "404"; @title_error_description = "Page Not Found"; render('errors/404', :layout => :error) }
    error(405) { @title = "405 | Method Not Allowed"; @title_error = "405"; @title_error_description = "Method Not Allowed"; render('errors/405', :layout => :error) }
    error(500) { @title = "500 | Internal Server Error"; @title_error = "500"; @title_error_description = "Internal Server Error"; render('errors/500', :layout => :error) }
  end
end
