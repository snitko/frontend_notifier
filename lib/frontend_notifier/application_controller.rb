module FrontendNotifierControllerExtension
  
  def notify_frontend(message, error_type="error")
    unless message.kind_of? String || message.nil?
      if message.errors.empty?  
        message = "Success"
        error_type = "success"
      else
        message = join_model_errors(message) 
      end
    end
    render :json => { :type => error_type, :message => message  }
  end

  private

    def join_model_errors(model, options = { include_field_names: true })
      result = []
      model.errors.each do |k,v|
        if k == :base
          result << v
        else
          if options[:include_field_names]
            result << "#{k} #{v}"
          else
            result << v
          end
        end
      end
      result = result.join("; ")
      dot_at_the_end = (result =~ /\.\Z/) ? "" : "."
      result + dot_at_the_end
    end

end
