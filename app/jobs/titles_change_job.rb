class TitlesChangeJob < ApplicationJob
  queue_as :default

  def perform(memo_id)
    Memo.find(memo_id).title_change
  end
end
