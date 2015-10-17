require 'bundler'

Bundler.require

# curl -u oauth-token:x-oauth-basic https://api.github.com/orgs/#{org}/repos\?per_page\=200

unless File.exists? "config.yml"
  raise "Please create config.yml by looking into config.default.yml"
end

yaml = YAML.load_file "config.yml"
oauth_token = yaml["oauth_token"]
org_dir = yaml["project_working_directory"]
org = yaml["github_organisation_name"]

dir = Dir.pwd

github = Github.new oauth_token: oauth_token, auto_pagination: true
repos = github.repos.list org: org, per_page: 100
repos.each do |repo|
  name = repo.name
  ssh_url = repo.ssh_url
  project_dir = [org_dir, name].join("/")
  if Dir.exists? project_dir
    p "Updating #{name}"
    Dir.chdir project_dir
    `git pull`
  else
    p "Cloning #{name}"
    Dir.chdir org_dir
    'git clone #{ssh_url}'
  end
end

Dir.chdir dir