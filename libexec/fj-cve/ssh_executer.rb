require 'bundler/setup'
require 'net/ssh'

=begin

   For up to date cipher see
   https://github.com/net-ssh/net-ssh/pull/479

=end

class SSHExecuter

  def initialize
  end

  def dpkg_pkgs host
    Net::SSH.start(host) do |ssh|
      stdout = ''
      cmd = "dpkg-query -W -f='${Package} ${Version} ${Architecture} ${Status}\n' | awk '/installed/ {print $1 \" \" $2 \" \" $3}'"

      ssh.exec!(cmd) do |channel, stream, data|
        stdout << data if stream == :stdout
      end

      return parse_pkgs stdout
    end
  end

  def os_release host
    Net::SSH.start(host) do |ssh|
      stdout = ''
      cmd = "cat /etc/issue"

      ssh.exec!(cmd) do |channel, stream, data|
        stdout << data if stream == :stdout
      end

      return parse_version stdout
    end
  end

  private

  def parse_pkgs pkg_str
    ret_arr = pkg_str.split "\n"
    ret_arr.first.gsub! /Got: /, ""

    return ret_arr
  end

  def parse_version ver_str
    case ver_str
    when /Ubuntu.*12\.04/
      return {:os_id => 'Ubuntu', :os_version => '12.04'}
    when /Ubuntu.*14\.04/
      return {:os_id => 'Ubuntu', :os_version => '14.04'}
    when /Ubuntu.*16\.04/
      return {:os_id => 'Ubuntu', :os_version => '16.04'}
    when /Debian GNU\/Linux 6/
      return {:os_id => 'Debian', :os_version => '6'}
    when /Debian GNU\/Linux 7/
      return {:os_id => 'Debian', :os_version => '7'}
    when /Debian GNU\/Linux 8/
      return {:os_id => 'Debian', :os_version => '8'}
    when /Debian GNU\/Linux 9/
      return {:os_id => 'Debian', :os_version => '9'}
    end
    raise "Unknown distribution on target host. Details follow.\n#{ver_str}"
  end

end
