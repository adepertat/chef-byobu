action :enable do
	
	cmd = Mixlib::ShellOut.new("getent passwd #{new_resource.user} | awk -F':' '{print $6}'")
    cmd.run_command
    home = cmd.stdout.strip
	
	append_if_no_line 'source byobu in profile' do
		path "#{home}/.profile"
		line '_byobu_sourced=1 . /usr/bin/byobu-launch'
	end

	append_if_no_line 'source byobu in bashrc' do
		path "#{home}/.bashrc"
		line '[ -r ~/.byobu/prompt ] && . ~/.byobu/prompt   #byobu-prompt#'
	end

	file "#{home}/.byobu/disable-autolaunch" do
		action :delete
	end

	file "#{home}/.byobu/backend" do
		content "BYOBU_BACKEND=#{new_resource.backend}"
	end

end

action :disable do
	
	cmd = Mixlib::ShellOut.new("getent passwd #{new_resource.user} | awk -F':' '{print $6}'")
    cmd.run_command
    home = cmd.stdout.strip
	
	delete_lines 'source byobu in profile' do
		path "#{home}/.profile"
		pattern '_byobu_sourced=1 . /usr/bin/byobu-launch'
	end

	delete_lines 'source byobu in bashrc' do
		path "#{home}/.bashrc"
		pattern '[ -r ~/.byobu/prompt ] && . ~/.byobu/prompt   #byobu-prompt#'
	end

	directory "#{home}/.byobu"
	file "#{home}/.byobu/disable-autolaunch"

end
