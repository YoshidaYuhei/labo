class NullJwtRevocation
  # 失効判定は常にfalse
  def self.jwt_revoke?(_payload, _user) = false
  # 失効処理は何もしない
  def self.revoke_jwt(_payload, _user) = nil
end