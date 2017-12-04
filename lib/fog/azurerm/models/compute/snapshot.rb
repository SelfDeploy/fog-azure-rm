module Fog
  module Compute
    class AzureRM
      # This class is giving implementation of create/save and
      # delete/destroy for snapshot.
      class Snapshot < Fog::Model
        attribute :id
        identity  :name
        attribute :location
        attribute :resource_group_name
        attribute :account_type
        attribute :disk_size_gb
        attribute :tags
        attribute :time_created
        attribute :creation_data
        attribute :encryption_settings

        def self.parse(snapshot)
          snap = get_hash_from_object(snapshot)

          unless snapshot.creation_data.nil?
            creation_data = Fog::Compute::AzureRM::CreationData.new
            snap['creation_data'] = creation_data.merge_attributes(Fog::Compute::AzureRM::CreationData.parse(snapshot.creation_data))
          end

          unless snapshot.encryption_settings.nil?
            encryption_settings = Fog::Compute::AzureRM::EncryptionSettings.new

            snap['encryption_settings'] = encryption_settings.merge_attributes(Fog::Compute::AzureRM::EncryptionSettings.parse(snapshot.encryption_settings))
          end

          snap['resource_group_name'] = get_resource_group_from_id(snapshot.id)

          snap
        end
      end
    end
  end
end
