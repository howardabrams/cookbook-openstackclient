#  encoding: UTF-8
#
#  Copyright 2016 cloudbau GmbH
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

require_relative 'openstack_base'
module OpenstackclientCookbook
  class OpenstackDomain < OpenstackBase
    resource_name :openstack_domain

    property :domain_name, String, name_property: true
    property :connection_params, Hash, required: true

    default_action :create

    action :create do
      domain = connection.domains.find { |u| u.id == domain_name } ||
               connection.domains.find { |u| u.name == domain_name }
      if domain
        log "Domain with name: \"#{domain_name}\" already exists"
      else
        connection.domains.create(
          name: domain_name
        )
      end
    end

    action :delete do
      domain = connection.domains.find { |u| u.name == domain_name }
      if domain
        domain.destroy
      else
        log "Domain with name: \"#{domain_name}\" doesn't exist"
      end
    end
  end
end
