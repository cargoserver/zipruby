require 'mkmf'

if have_header('zlib.h') and have_library('z')
  have_func('fseeko')
  have_func('ftello')
  have_func('mkstemp')
  create_makefile('zipruby')
end

cc_version = `#{RbConfig::expand("$(CC) --version".dup)}`
if cc_version.match?(/clang/i)
  unless RbConfig::CONFIG['DLDFLAGS'].to_s.include?("dynamic_lookup")
    # Ref: https://github.com/redis-rb/redis-client/issues/58
    # Ref: https://bugs.ruby-lang.org/issues/19005
    $DLDFLAGS << ' -Wl,-undefined,dynamic_lookup '
  end
end
