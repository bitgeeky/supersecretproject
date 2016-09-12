class KeyManager
    def initialize
	@max_num_of_keys = 20
	@expire_after = 10 # automatically expire after
	@release_after = 5 # release if blocked 
	@key_pool = { }
	@assigned_keys = { }
    end
    def generate_keys
	while @key_pool.size < @max_num_of_keys
	    # generate random key
	    random_key = (0...8).map { (65 + rand(26)).chr }.join
	    @key_pool[random_key] = {
		last_update: Time.now.to_i,
	    }
	end
	@key_pool
    end
    def get_all
	@key_pool
    end
    def get_key
	key = @key_pool.keys.first
	@key_pool.delete(key)
	@assigned_keys[key] = {
	    assigned_at: Time.now.to_i,
	}
	key
    end
    def delete_key(key)
	@key_pool.delete(key)
	@assigned_keys.delete(key)
	key
    end
    def release_key(key)
	@assigned_keys.delete(key)
	@key_pool[key] = {
	    last_update: Time.now.to_i,
	}
	key
    end
    def keep_alive(key)
	@assigned_keys[@random_key] = {
	    last_update: Time.now.to_i,
	}
	key
    end
    def cron_job
	puts "key rotation working fine"
	@key_pool.each do |key, val|
	    if Time.now.to_i - @key_pool[key][:last_update] >= @expire_after
		@key_pool.delete(key)
	    end
	end
	@assigned_keys.each do |key, val|
	    if Time.now.to_i - @assigned_keys[key][:assigned_at] >= @release_after
		@assigned_keys.delete(key)
		@key_pool[key] = {
		    last_update: Time.now.to_i,
		}
	    end
	end
    end
end