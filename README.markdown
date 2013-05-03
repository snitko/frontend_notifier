FrontendNotifier
=================

![Screenshot](https://github.com/snitko/frontend_notifier/raw/master/Screenshot.png)

Shows cute notifications in frontend. No need to manually create your own html/css/js to show Rails's flash[:notice] or other flashes. This gem handles it nicely + you can customize it.

INSTALLATION
------------

**Requirements**: Rails 3.1.0, jQuery

1. `gem install frontend_notifier`
2. put the following in your .scss file: `@import "frontend_notifier";`
3. put the following in your .js or .coffee file: `#= require lib/_frontend_notifier`
4. put the following in layout: `= render :partial => "shared/frontend_notifier"`

USAGE
-----

**Regular reuqests**
FrontendNotifier will pick up any flash with the names `:error`, `:alert`, `:warning`, `:success` or `:notice`. You can customize this by creating your own `views/shared/frontend_notifier` template.

**Ajax requests**
Sometimes you may need to display the notification after an ajax request. For that, you may want to use `#notify_frontend` method now available in your controller and pass it either a model with (or without) errors:

    def create
      ...    
      notify_frontend(@user)
    end

or a message and an error type:

    def create
      ...
      notify_frontend("Email can't be blank", :error)
    end

Both will result in rendering the following json:

    { type: "error", message: "Email can't be blank" }

Now you can deal with this in your ajax request callback. Assuming this is a jQuery $.ajax function:

    success: function(response) { FrontendNotifier.show(response) }

In this case, `FrontendNotifier.show` will recognize the type of the notification (either "success" or "error") and display appropriately styled notification (by default, green background for success and red for error).

You can also specify the type of error to the FrontendNotifier class manually and call the .show() function anywhere in your js:
    FrontendNotifier.show("Testing notifications", "success")

There's also a handy #join_model_errors method added to the ApplicationController, which you might want to look at. It basically takes errors from the model and compiles them into a one line message which may then be handed to the FrontendNotifier. So, you may want to use it like this:

    flash[:error] = join_model_errors(@user, include_field_names: true) # :include_field_names is true by default

CUSTOMIZE
-----
Run `rails generate frontend_notifier`. It will copy frontend_notifier's view and stylesheet to yours application directory.
