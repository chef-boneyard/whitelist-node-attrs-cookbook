#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2011 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Whitelist
  # filter takes two arguments - the data you want to filter, and a
  # whitelisted map of the keys you want included. Note we are only using the
  # keys in this hash - if the values are anything other than another hash, we
  # ignore them. (You can't magically morph into a blacklist with "false" as a
  # value in the whitelist.)
  #
  # Whitelist.filter(
  # { "filesystem" => {
  #    "/dev/disk0s2" => {
  #     "size" => "10mb"
  #    },
  #    "map - autohome' => {
  #     "size" => "10mb"
  #    }
  # },
  # {
  #   "filesystem" => {
  #     "/dev/disk0s2" => true
  #   }
  # })
  #
  # Will drop the entire "map - autohome" tree.
  def self.filter(data, whitelist)
    if data == nil
      return nil
    end

    new_data = data.reject { |key, value| !whitelist.keys.include?(key) }
    whitelist.each do |k,v|
      if v.kind_of?(Hash)
        new_data[k] = filter(new_data[k], v)
      end
    end
    new_data
  end
end

class Chef
  class Node
    alias_method :old_save, :save

    def save
      Chef::Log.info("Whitelisting node attributes")
      whitelist = self[:whitelist].to_hash
      self.default_attrs = Whitelist.filter(self.default_attrs, whitelist)
      self.normal_attrs = Whitelist.filter(self.normal_attrs, whitelist)
      self.override_attrs = Whitelist.filter(self.override_attrs, whitelist)
      self.automatic_attrs = Whitelist.filter(self.automatic_attrs, whitelist)
      old_save
    end
  end
end

