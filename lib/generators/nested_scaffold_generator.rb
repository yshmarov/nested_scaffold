require 'rails/generators/rails/scaffold/scaffold_generator'
require File.join(File.dirname(__FILE__), 'base')
require File.join(File.dirname(__FILE__), 'scaffold_controller/scaffold_controller_generator')
require File.join(File.dirname(__FILE__), 'active_record/active_record_generator')

module NestedScaffold
  module Generators
    class NestedScaffoldGenerator < ::Rails::Generators::ScaffoldGenerator
      include ::NestedScaffold::Base

      # override ScaffoldGenerator
      hook_for :scaffold_controller, required: true

      # override ModelGenerator
      hook_for :orm, required: true

      # replacing hook for adding config/routes
      remove_hook_for :resource_route
      # override
      def add_resource_route
        return if options[:actions].present?

        in_root do
          if File.read('config/routes.rb').include?("scope module: :#{plural_nested_parent_name} do")
            inject_into_file(
              'config/routes.rb',
              "      resources :#{file_name.pluralize}\n",
              after: "scope module: :#{plural_nested_parent_name} do\n"
            )
          elsif File.read('config/routes.rb').include?("resources :#{plural_nested_parent_name} do")
            inject_into_file(
              'config/routes.rb',
              "    resources :#{file_name.pluralize}, module: :#{plural_nested_parent_name}\n",
              after: "resources :#{plural_nested_parent_name} do\n"
            )
          else
            route_config = "resources :#{plural_nested_parent_name} do\n" \
                         "  resources :#{file_name.pluralize}, module: :#{plural_nested_parent_name}\n" \
                         "end\n"
            route route_config
            gsub_file 'config/routes.rb', / *resources :#{plural_nested_parent_name}\n/, ''
          end
        end
      end

      def add_to_navigation
        return unless File.exist?("app/views/shared/_sidebar_links.html.erb")
        
        append_to_file "app/views/shared/_sidebar_links.html.erb" do
          <<-ERB
<%= nav_link "#{plural_table_name.titleize}", #{nested_parent_name}_#{index_helper(type: :path)}(@#{nested_parent_name}), icon: "svg/question-mark-circle.svg" %>
          ERB
        end
      end
    end
  end
end
