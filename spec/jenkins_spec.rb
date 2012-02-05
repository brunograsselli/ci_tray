require 'spec_helper'

describe CiTray::Jenkins do
  describe "#jobs" do
    before :each do
      stub_request(:get, "http://test.jenkins.org/api/json").to_return :body => {
        jobs: [
          {
            name: "job_one",
            url: "http://test.jenkins.org/job/job_one/",
            color: "red"
          },
          {
            name: "job_two",
            url: "http://test.jenkins.org/job/job_two/",
            color: "blue"
          }
        ]
      }.to_json
    end

    subject do
      described_class.new(:address => "http://test.jenkins.org").jobs
    end

    it "should access jenkins api and return the job names" do
      subject.map{|j| j[:name]}.should eq %w{job_one job_two}
    end

    it "should access jenkins api and return the job colors" do
      subject.map{|j| j[:color]}.should eq %w{red blue}
    end

    it "should access jenkins api and return the job urls" do
      subject.map{|j| j[:url]}.should eq %w{http://test.jenkins.org/job/job_one/ http://test.jenkins.org/job/job_two/}
    end
  end
end
