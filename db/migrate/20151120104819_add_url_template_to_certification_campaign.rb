class AddUrlTemplateToCertificationCampaign < ActiveRecord::Migration
  def change
    add_column :certification_campaigns, :dataset_url_template, :string
  end
end
