require File.expand_path '../../test_helper', __dir__

# Test class for Managed Disk Model
class TestSnapshot < Minitest::Test
  def setup
    @service = Fog::Compute::AzureRM.new(credentials)
    @snapshot = snapshot(@service)
    _compute_client = @service.instance_variable_get(:@compute_mgmt_client)
  end

  def test_model_attributes
    attributes = [
      :id,
      :name,
      :type,
      :location,
      :resource_group_name,
      :account_type,
      :time_created,
      :os_type,
      :disk_size_gb,
      :owner_id,
      :provisioning_state,
      :tags,
      :creation_data,
      :encryption_settings,
      :tags
    ]
    attributes.each do |attribute|
      assert_respond_to @snapshot, attribute
    end
  end
end
