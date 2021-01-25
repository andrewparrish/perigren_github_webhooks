PerigrenGithubWebhooks::Engine.routes.draw do
  resources :github_webhooks, only: [:create]
end
