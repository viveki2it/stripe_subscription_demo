module ApplicationHelper

  def bootstrap_class_for flash_type
    {success: "success", error: "error", alert: "error", notice: "success", recaptcha_error: "error"}[flash_type.to_sym] || flash_type.to_s
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      next if type.eql?('invalid_inputs')

      type = bootstrap_class_for type

      text = "<script>toastr.#{type}('#{message.to_s.gsub("'", %q(\\\'))}', {timeOut: 5000, closeButton: true});</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
