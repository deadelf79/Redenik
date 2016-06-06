module Kernel
	def with(instance, &block)
		instance.instance_eval(&block)
		instance
	end

	def assert_class(name, argue, classname, default)
		unless argue.is_a? classname
			wr "Argument '#{name}' has classmissed: #{classname} instead of #{default}. Return default."
			return default
		end
		return argue
	end

	def assert_range(name, argue, range, default)

	end
end