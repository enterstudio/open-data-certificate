require 'spec_helper'

describe CertificationCampaign do
  context "dataset url templates" do
    subject(:campaign) do
      CertificationCampaign.new(url: "http://example.org/ckan/")
    end

    it 'generates default ckan dataset urls' do
      expect(campaign.dataset_url_for("dataset-name")).to eq "http://example.org/ckan/dataset/dataset-name"
    end

    context "with a custom template" do
      it "uses the template" do
        campaign.dataset_url_template = "custom-location/{name}"
        expect(campaign.dataset_url_for("dataset-name")).to eq "http://example.org/ckan/custom-location/dataset-name"
      end

      it "uses treats urls starting with / as relative to the root" do
        campaign.dataset_url_template = "/new-location/{name}"
        expect(campaign.dataset_url_for("dataset-name")).to eq "http://example.org/new-location/dataset-name"
      end

      it "overrides the site if an absolute url is provided" do
        campaign.dataset_url_template = "http://elsewhere.com/{name}"
        expect(campaign.dataset_url_for("dataset-name")).to eq "http://elsewhere.com/dataset-name"
      end
    end
  end
end
