
if defined?(ChefSpec)
  def install_openresty(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:myopenresty_install, :install, resource_name)
  end
end
