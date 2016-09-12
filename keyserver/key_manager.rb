class KeyManager
    @time_to_live # keep key alive till
    @release_within # release if blocked
    def initialize
	@num_of_keys = 20
	@key_pool = []
	@assigned_keys = []
    end
    def generate_keys
	while @key_pool.size < 20
	    # generate random key
	    random_key = (0...8).map { (65 + rand(26)).chr }.join
	    @key_pool.push(random_key)
	end
	@key_pool
    end
    def get_key
	key = @key_pool.pop
	@assigned_keys.push(key)
	key
    end
end