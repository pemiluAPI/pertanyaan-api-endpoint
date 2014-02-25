require 'spec_helper'

describe Pertanyaan::API do
  before (:each) do
    #two questions
    create(:question)
    create(:question, :id => '002', :reference_law => "", :excerpt_law => "")

    #one tag
    create(:tag)
  end

  describe "GET /api/questions" do
    it "returns an json of questions" do
      get "/api/questions"
      response.status.should == 200
      questions = Question.find_all
      response.body.should == 
        {
        results: {
          count: Question.count,
          total: questions.count,
          questions: questions
        }
      }.to_json
    end

    it "limit questions should works" do
      get "/api/questions?limit=1"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 2
      ress["results"]["total"].should == 1
    end

    it "offset questions should works" do
      get "/api/questions?offset=1"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 2
      ress["results"]["total"].should == 1
      ress["results"]["questions"][0]['id'].should == "002"
    end

    it "seacrh by tags questions should works" do
      get "/api/questions?tags=indonesia"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 2
      ress["results"]["total"].should == 1
    end

    it "should total return 0 if tag is not found" do
      get "/api/questions?tags=whatever"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 2
      ress["results"]["total"].should == 0
    end

    it "seacrh by law questions should works" do
      get "/api/questions?law=UUD%201945"
      ress = JSON.parse(response.body)
      response.status.should == 200
      ress["results"]["count"].should == 2
      ress["results"]["total"].should == 1
    end
  end

  describe "GET /api/questions/001" do
    it "returns an array of question" do
      get "/api/questions/001"
      response.status.should == 200
      response.body.should == {
        results: {
          count: 1,
          total: 1,
          questions: {:id=>'001',
            :question => 'Apakah perempuan bisa mencalonkan diri dalam pemilu?',
            :answer => 'Ya',
            :reference_law => 'UUD 1945 Pasal 27 Ayat (1)',
            :excerpt_law => 'Pasal 27: (1) Yang menjadi warga negara ialah orang orang bangsa Indonesia asli dan orang orang bangsa lain yang disahkan dengan undangundang sebagai warga negara.',
            :tags => ["indonesia"]
          }
        }
      }.to_json
    end
  end

  describe "GET /api/tags/" do
    it "returns an array of tags" do
      get "/api/tags"
      response.status.should == 200
      response.body.should == {
          results: {
            count: 1,
            tags: [{:tag => "indonesia", :question_count=>1}]
          }
        }.to_json
    end
  end
end