ActiveAdmin.register BrowserNotification do
  menu priority: 6

  actions :index, :show, :new, :create

  permit_params :title, :body, :url

  config.filters = false
  config.sort_order = 'created_at_desc'

  index do
    column :title
    column :body
    column :url do |notification|
      link_to notification.url, notification.url, target: '_blank'
    end
    column :users_count do |notification|
      notification.subscription_ids.count
    end
    column :fetchers_count do |notification|
      notification.fetcher_ids.count
    end
    column :clickers_count do |notification|
      notification.clicker_ids.count
    end
    column :created_at
    actions
  end

  form data: { confirm: 'Уверен?' } do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :body, as: :text
      f.input :url, as: :url, hint: 'https://appy.gy/...'
    end
    h2 'Уведомление будет отправлено сразу после создания', style: 'color: red'
    f.actions
  end

  show do
    users_list = -> subscriptions do
      users = User.where id: subscriptions.where.not(user_id: nil).select(:user_id)
      list = users.map{ |user| link_to user.name, "/users/#{user.slug}", target: '_blank' }.join(', ')
      list += ' + ' if users.present?
      list += "#{subscriptions.where(user_id: nil).count} незарегистрированных"
      list.html_safe
    end

    attributes_table do
      row :title
      row :body
      row :url do |notification|
        link_to notification.url, notification.url, target: '_blank'
      end
      row :users do |notification|
        users_list.call notification.recipients
      end
      row :fetchers do |notification|
        users_list.call notification.fetchers
      end
      row :clickers do |notification|
        users_list.call notification.clickers
      end
    end
  end

  controller do
    after_action :send_notification, only: [:create]

    private

    def send_notification
      BrowserNotifications::Sender.new(resource).send
    end
  end
end
