require 'open-uri'
require 'json'

class CiTray::Jenkins
  def initialize(options)
    @address = options[:address]
  end

  def jobs
    jenkins_response['jobs'].map do |job|
      simbolize_keys! job
    end
  end

  private

  def jenkins_response
    response_body = open api_address
    JSON.parse response_body.read
  end

  def simbolize_keys!(hash)
    hash.keys.each do |key|
      hash[key.to_sym] = hash.delete(key)
    end
    hash
  end

  def api_address
    "#{@address}/api/json"
  end
end
