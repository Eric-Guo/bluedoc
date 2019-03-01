# frozen_string_literal: true

module ApplicationHelper
  def markdown(body, opts = {})
    opts[:format] = "markdown"
    raw BlueDoc::HTML.render(body, opts)
  end

  def sanitize_html(html)
    raw Sanitize.fragment(html, BlueDoc::Sanitize::DEFAULT)
  end

  def close_button
    raw %(<i class="notice-close js-notice-close fas fa-cancel"></i>)
  end

  def icon_tag(name, opts = {})
    icon_html = content_tag(:i, "", class: "fas fa-#{name} #{opts[:class]}")
    return icon_html if opts[:label].blank?
    raw [icon_html, "<span>#{opts[:label]}</span>"].join(" ")
  end

  def notice_message
    flash_messages = []

    flash_messages << flash_block_tag(:success, flash[:notice]) if flash[:notice]
    flash_messages << flash_block_tag(:error, flash[:alert]) if flash[:alert]

    content_tag(:div, flash_messages.join("\n").html_safe, class: "navbar-notice")
  end

  def flash_block_tag(type, message)
    content_tag(:div, class: "notice notice-#{type}") do
      close_button + message
    end
  end

  def timeago(t)
    return "" if t.blank?

    if t < 2.weeks.ago
      return content_tag(:span, class: "time", title: t.iso8601) { l t, format: :short }
    end

    content_tag(:span, class: "timeago", datetime: t.iso8601, title: t.iso8601) { l t, format: :short }
  end

  def title_tag(*texts)
    text = texts.join(" - ")
    content_for :title, h("#{text} - BlueDoc")
  end

  def action_button_tag(target, action_type, opts = {})
    return "" if target.blank?

    label      = opts[:label]
    undo_label = opts[:undo_label]
    icon       = opts[:icon]
    undo       = opts[:undo]
    with_count = opts[:with_count]

    label ||= t("shared.action_button.#{action_type}")
    undo_label ||= t("shared.action_button.un#{action_type}")
    icon ||= action_type.downcase

    action_type_pluralize = action_type.to_s.pluralize
    action_count = "#{action_type_pluralize}_count"

    url = target.to_path("/action?#{{ action_type: action_type }.to_query}")

    data = { method: :post, label: label, undo_label: undo_label, remote: true, disable: true }
    class_names = opts[:class] || "btn btn-sm"
    if with_count
      class_names += " btn-with-count"
    end
    btn_label = label.dup

    if undo.nil?
      undo = current_user && User.find_action(action_type, target: target, user: current_user)
    end

    if undo
      data[:method] = :delete
      btn_label = undo_label.dup
    end

    out = []

    out << link_to(icon_tag(icon, label: btn_label), url, data: data, class: class_names)
    if with_count && target.respond_to?(action_count)
      out << %(<span class="social-count" >#{target.send(action_count)}</span>)
    end
    content_tag(:span, raw(out.join("")), class: "#{target.class.name.underscore.singularize}-#{target.id}-#{action_type}-button")
  end

  # Render div.form-group with a block, it including validation error below input
  #
  # form_group(f, :email) do
  #   f.email_field :email, class: "form-control"
  # end
  def form_group(form, field, opts = {}, &block)
    has_errors = form.object.errors[field].present?
    opts[:class] ||= "form-group"
    opts[:class] += " has-error" if has_errors

    content_tag :div, class: opts[:class] do
      concat form.label field, class: "control-label" if opts[:label] != false
      concat capture(&block)
      concat errors_for(form, field)
    end
  end

  def errors_for(form, field)
    message = form.object.errors.full_messages_for(field)&.first
    return nil if message.blank?
    content_tag(:div, message, class: "form-error")
  end
end
