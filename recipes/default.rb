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

# We use a ruby block because we want this to happen at run-time (not compile
# time)
#
# The whitelist itself are node attributes, so you can build it up easily from
# nodes/roles as needed.
ruby_block "filter node attributes" do
  block do
    whitelist = node[:whitelist].to_hash
    node.default_attrs = Whitelist.filter(node.default_attrs, whitelist)
    node.normal_attrs = Whitelist.filter(node.normal_attrs, whitelist)
    node.override_attrs = Whitelist.filter(node.override_attrs, whitelist)
    node.automatic_attrs = Whitelist.filter(node.automatic_attrs, whitelist)
  end
end
