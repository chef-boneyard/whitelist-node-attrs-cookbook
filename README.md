Description
===========

This cookbook provides a library that allows you to set a whitelist of
node attributes that should be saved on the server. All of the
attributes are still available throughout the chef run, but only those
specifically listed will be saved to the server.

Requirements
============

Chef 0.9.0+

Requires chef-client and a Chef Server - this cookbook doesn't make
sense, nor work, with chef-solo.

Works on any platform.

Attributes
==========

`node[:whitelist]` provides a map of node attributes to store. The
defaults are provided by this cookbook, and the map is:

    node.default[:whitelist] = {
      "domain" => true,
      "fqdn" => true,
      "hostname" => true,
      "ipaddress" => true,
      "macaddress" => true,
      "platform" => true,
      "platform_version" => true,
      "kernel" => {
        "machine" => true,
        "name" => true,
        "os" => true,
        "release" => true,
        "version" => true
      }
    }

This cookbook honors the fact that attributes are set at different
precedence levels.

Usage
=====

Upload the cookbook, and make sure that it is included as a dependency
in another cookbooks metadata, or that the recipe (which does nothing)
is included in the role.

Whenever node.save is called, such as at the end of the run, the
whitelist will be applied.

License and Author
==================

Author:: Adam Jacob (<adam@opscode.com>)

Copyright:: 2011-2012, Opscode, Inc (<legal@opscode.com>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
