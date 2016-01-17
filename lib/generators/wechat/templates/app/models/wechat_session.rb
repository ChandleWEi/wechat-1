# Used by wechat gems, do not rename WechatSession to other name.
class WechatSession < ActiveRecord::Base
  validates :openid, presence: true, uniqueness: true

  def self.find_or_initialize_session(from_user_openid, _to_app_openid)
    find_or_initialize_by(openid: from_user_openid)
  end

  def save_session
    save!
  end

  def json_hash=(data)
    self.json_hash_raw = data.try :to_json
  end

  def json_hash
    json_hash_raw.blank? ? {} : JSON.parse(json_hash_raw).symbolize_keys
  end
end
