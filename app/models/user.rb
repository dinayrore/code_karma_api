class User < ApplicationRecord
  belongs_to: account, :polymorphic => true
end
