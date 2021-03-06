homebrew_go = "#{Chef::Config[:file_cache_path]}/homebrew_go"

remote_file homebrew_go do
  source "https://raw.github.com/mxcl/homebrew/go"
  mode 00755
  owner node['homebrew']['run_as']
end

execute homebrew_go do
  not_if { File.exist? '/usr/local/bin/brew' }
  user node['homebrew']['run_as']
end

package 'git' do
  not_if "which git"
end

execute "update homebrew from github" do
  command "/usr/local/bin/brew update || true"
  user node['homebrew']['run_as']
end
